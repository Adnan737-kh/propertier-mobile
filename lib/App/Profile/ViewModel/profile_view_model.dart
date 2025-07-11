import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Analytics/Model/chart_data_model.dart';
import 'package:propertier/App/Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';
import 'package:propertier/App/Home/Model/comment_button_model.dart';
import 'package:propertier/App/Profile/Model/profile_model.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../constant/call_launcher.dart';
import '../../../constant/colors.dart';
import '../../../constant/toast.dart';
import '../../../repository/profile_repo/profile_view/profile_view_repo.dart';
import '../../../res/app_urls/app_url.dart';
import '../../Home/Model/properties_tiler_button_model.dart';
import 'package:http/http.dart' as http;

import '../View/Verification/View/components/edit_profile_textfield.dart';

class ProfileViewModel extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController profilePictureController = TextEditingController();
  final ProfileViewRepository _profileViewRepository = ProfileViewRepository();
  final RxBool _isShowMoreComment = false.obs;
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  UserPreference userPreference = UserPreference();
  String selectedGender = "male"; // Default gender
  String? accessToken;
  String? _userID;
  String? get userID => _userID;
  bool get isShowMoreComment => _isShowMoreComment.value;
  var isLoading = false.obs;
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final RxBool uploadCompleted = false.obs;


  Function? _onUploadComplete;

  void setUploadCompleteCallback(Function callback) {
    _onUploadComplete = callback;
  }

  void callUploadComplete() {
    _onUploadComplete?.call();
  }
  @override
  void dispose() {
    phoneController.dispose();
    addressController.dispose();
    profilePictureController.dispose();
    phoneFocusNode.dispose();
    addressFocusNode.dispose();
    super.dispose();
  }



  @override
  void onReady() async {
    super.onReady();

    userPreference.getUserAccessToken().then((value) async {
      if (kDebugMode) {
        print('ProfileViewModel Access Token  !!! ${value.accessToken}');
      }
      if (value.accessToken!.isNotEmpty &&
          value.accessToken.toString() != 'null') {
        accessToken = value.accessToken;
        profileModel.value = await getProfile(
          context: Get.context!,
          accessToken: value.accessToken!,
        );

        userPreference.getUserProfileData().then((value) async {
          if (value!.email!.isNotEmpty && value.email.toString() != 'null') {
            _userID = value.id.toString();
            if (kDebugMode) {
              print('user saved id $value.id.toString()');
            }
          }
        });
      }
    });
  }

  Future<ProfileModel> getProfile({
    required BuildContext context,
    required String accessToken,
  }) async {
    isLoading.value = true;

    try {
      final result =
          await _profileViewRepository.viewProfileDetails(accessToken);

      final dataResponse = ProfileModel.fromJson(result);
      profileModel.value = dataResponse;

      await userPreference.saveUserProfileData(profileModel.value.userProfile!);

      if (kDebugMode) {
        print('Profile Data Saved: ${result['user_profile']['phone_number']}');
      }
      final requiresProfileCompletion =
          result['user_profile']['requires_profile_completion'];

      if (kDebugMode) {
        print('requires_profile_completion $requiresProfileCompletion');
      }
      if (requiresProfileCompletion == true) {
        showProfileCompletionDialog(context, profileModel.value);
      }

      return profileModel.value;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('Error fetching profile: $error');
        print('$stackTrace');
      }

      Get.offAllNamed(AppRoutes.loginView);
      isLoading(false);
      rethrow;
    } finally {
      isLoading(false);
    }
  }

  final List<SalesData> spline1ThisWeek = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 90),
    SalesData('Apr', 32),
    SalesData('May', 50),
    SalesData('Jun', 90),
    SalesData('Jul', 200),
    SalesData('Aug', 40),
    SalesData('Sep', 150),
    SalesData('Oct', 100),
    SalesData('Nov', 89),
    SalesData('Dec', 2),
  ];
  final List<SalesData> spline2ThisWeek = [
    SalesData('Jan', 50),
    SalesData('Feb', 18),
    SalesData('Mar', 30),
    SalesData('Apr', 52),
    SalesData('May', 60),
    SalesData('Jun', 100),
    SalesData('Jul', 200),
    SalesData('Aug', 250),
    SalesData('Sep', 150),
    SalesData('Oct', 10),
    SalesData('Nov', 89),
    SalesData('Dec', 2),
  ];

  Future<bool> completeProfile() async {
    final phoneText = phoneController.text.trim();

    if (phoneText.length <= initialCode.length) {
      // Validation error should be handled by validator, so just return false
      return false;
    }
    if (selectedImage.value == null) {
      // You may want to show toast here because this is outside form validation
      CustomToast.show(title: 'Please select a profile image', context: Get.context!);
      return false;
    }

    try {
      final uri = Uri.parse(AppUrls.profileUrl);
      final request = http.MultipartRequest('PATCH', uri)
        ..headers['Authorization'] = 'Bearer $accessToken'
        ..fields['phone_number'] = initialCode + phoneText
        ..fields['address'] = addressController.text.trim()
        ..fields['gender'] = selectedGender;

      File? imageFile = selectedImage.value;
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_picture',
          imageFile.path,
        ));
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      CustomToast.show(title: 'An error occurred', context: Get.context!);
      return false;
    }
  }

  showMoreComment(bool value) {
    _isShowMoreComment.value = value;
  }

  RxList<PropertiesTileButtonModel> propertiesTileButtonList =
      <PropertiesTileButtonModel>[
    PropertiesTileButtonModel(
        onTap: (val) {
          if (val != '') {
            launchCallandSMS(type: 'sms', phoneNumber: val!);
          }
        },
        title: "SMS",
        color: AppColor.white,
        icon: null,
        titleColor: AppColor.greenColor,
        borderColor: AppColor.greenColor),
    PropertiesTileButtonModel(
        onTap: (val) async {
          if (val != '') {
            launchCallandSMS(type: 'tel', phoneNumber: val!);
          }
        },
        titleColor: AppColor.white,
        borderColor: AppColor.greenColor,
        title: 'Call',
        color: AppColor.greenColor,
        icon: Ionicons.call),
    PropertiesTileButtonModel(
        onTap: (val) async {
          if (val != '') {
            launchCallandSMS(type: 'tel', phoneNumber: val!);
          }
        },
        titleColor: AppColor.backgroundColor,
        borderColor: AppColor.forGroundColor,
        title: 'Chat',
        color: AppColor.forGroundColor,
        icon: null),
  ].obs;

  RxList<CommentButtonModel> commentButtonsList = <CommentButtonModel>[
    CommentButtonModel(icon: Ionicons.chatbubble_outline, title: '1'),
    CommentButtonModel(icon: Ionicons.return_up_back_outline, title: '4'),
    CommentButtonModel(icon: Ionicons.heart_outline, title: '2'),
    CommentButtonModel(icon: Ionicons.stats_chart_outline, title: '4'),
    CommentButtonModel(icon: Ionicons.share_social_outline, title: '')
  ].obs;

  final RxString _initialCode = '+92'.obs;
  String get initialCode => _initialCode.value;


  changeInitialCode(String code) {
    _initialCode.value = code;
  }

  void showProfileCompletionDialog(
      BuildContext context, ProfileModel userProfile) {
    final formKey = GlobalKey<FormState>();

    ValueNotifier<bool> isLoading = ValueNotifier(false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text("Complete Your Profile"),
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      CustomPhoneNumberTextField(
                        onChangeCountry: (country) {
                          changeInitialCode("+${country.dialCode}");
                        },
                        initialCode: initialCode,
                        label: "Phone Number",
                        isEditable: true,
                        isShowEditIcon: false,
                        controller: phoneController,
                        focusNode: phoneFocusNode,
                        hintText: 'Enter Your Phone Number',
                        textInputType: TextInputType.phone,
                        suffix: const Icon(Icons.record_voice_over),
                        validator: (value) {
                          final fullValue = value?.trim() ?? '';

                          // Ensure user types something beyond just the initialCode
                          if (fullValue.isEmpty || !fullValue.startsWith(initialCode)
                              || fullValue.length <= initialCode.length) {
                            return 'Please enter phone number';
                          }

                          // Extract number after initial code
                          final numberPart = fullValue.substring(initialCode.length);

                          if (numberPart.isEmpty || !RegExp(r'^\d{6,}$').hasMatch(numberPart)) {
                            return 'Please enter valid phone number';
                          }

                          return null;
                        },


                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(addressFocusNode);
                        },
                      ),
                    TextFormField(
                      controller: addressController,
                      focusNode: addressFocusNode,
                      decoration: const InputDecoration(labelText: "Address"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your address";
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      onChanged: (value) {
                        selectedGender = value!;
                      },
                      items: ["male", "female", "other"]
                          .map((gender) =>
                          DropdownMenuItem(value: gender, child: Text(gender)))
                          .toList(),
                      decoration: const InputDecoration(labelText: "Gender"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select a gender";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        const Text('Select Profile Image'),
                        const SizedBox(height: 10),
                        ReactiveProfileImagePicker(
                          selectedImage: selectedImage,
                          onTap: pickImageFromGallery,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Center(
                child: ValueListenableBuilder<bool>(
                  valueListenable: isLoading,
                  builder: (context, loading, _) {
                    return loading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          isLoading.value = true;
                          bool success = await completeProfile();
                          isLoading.value = false;

                          if (phoneController.text.length <= initialCode.length) {
                            // Validation error should be handled by validator, so just return false
                            return CustomToast.show(title: 'Please enter  phone number', context: context);
                          }

                          if (success) {
                            Get.back();  // close dialog on success
                            Get.toNamed(AppRoutes.navBarView, arguments: {'initialIndex': 2});
                            getProfile(
                                      context: context,
                                      accessToken: accessToken!,
                                    );
                            CustomToast.show(title: 'Profile Updated Successfully', context: context);
                          } else {
                            CustomToast.show(title: 'Failed to update profile', context: context);
                          }
                        }

                        // if (formKey.currentState!.validate()) {
                        //   isLoading.value = true;
                        //   completeProfile().whenComplete(() {
                        //     getProfile(
                        //       context: context,
                        //       accessToken: accessToken!,
                        //     );
                        //     isLoading.value = false;
                        //   });
                        // }
                      },
                      child: const Text("Submit"),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  final Rx<File?> selectedImage = Rx<File?>(null);
  final picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImage.value = File(pickedImage.path);
    }
  }
}

class ReactiveProfileImagePicker extends StatelessWidget {
  final Rx<File?> selectedImage;
  final VoidCallback onTap;

  const ReactiveProfileImagePicker({super.key, required this.selectedImage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: onTap,
        child: selectedImage.value != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            selectedImage.value!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        )
            : Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.add_a_photo, color: Colors.grey),
        ),
      );
    });
  }
}

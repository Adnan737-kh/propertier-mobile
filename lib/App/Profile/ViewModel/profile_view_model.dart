import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Analytics/Model/chart_data_model.dart';
import 'package:propertier/App/Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';
import 'package:propertier/App/Home/Model/comment_button_model.dart';
import 'package:propertier/App/Profile/Model/profile_model.dart';

import '../../../RoutesAndBindings/app_routes.dart';
import '../../../constant/call_launcher.dart';
import '../../../constant/colors.dart';
import '../../../constant/toast.dart';
import '../../../repository/profile_repo/profile_update/profile_updat_repo.dart';
import '../../../repository/profile_repo/profile_view/profile_view_repo.dart';
import '../../Home/Model/properties_tiler_button_model.dart';

class ProfileViewModel extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController profilePictureController = TextEditingController();
  final ProfileUpdateRepository _api = ProfileUpdateRepository();
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

  @override
  void onInit() async {
    userPreference.getUserAccessToken().then((value) async {
      if (kDebugMode) {
        print('ProfileViewModel Access Token  !!! ${value.accessToken}');
      }
      if (value.accessToken!.isNotEmpty ||
          value.accessToken.toString() != 'null') {
        accessToken = value.accessToken;
        profileModel.value = await getProfilePageData(
          context: Get.context!,
          id: value.accessToken!,
        );

        userPreference.getUserProfileData().then((value) async {
          if (kDebugMode) {
            print('user saved id ${value?.id.toString()}');
          }
          if (value!.email!.isNotEmpty || value.email.toString() != 'null') {
            _userID = value.id.toString();
            if (kDebugMode) {
              print('user saved id $value.id.toString()');
            }
          }
        });
      }
    });

    super.onInit();
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

  Future<ProfileModel> getProfilePageData({
    required BuildContext context,
    required String id,
  }) async {
    isLoading.value = true;
    _profileViewRepository
        .viewProfileDetails(accessToken!)
        .then((result) async {
      final dataResponse = ProfileModel.fromJson(result);
      profileModel.value = dataResponse;

      await userPreference
          .saveUserProfileData(profileModel.value.userProfile!)
          .then((onValue) {
        Get.toNamed(AppRoutes.navBarView);
        if (kDebugMode) {
          print('Profile Data Saved $result');
        }
      }).onError((error, stackTrace) {});
        //     if (profileModel.value.userProfile!.requiresProfileCompletion == true) {
      //   showProfileCompletionDialog(Get.context!, profileModel);
      // }
      isLoading(false);
    }).onError((error, stackTrace) {
      Get.offAllNamed(AppRoutes.loginView);
      isLoading(false);

      if (kDebugMode) {
        print('$error and $stackTrace');
      }
    });
    return profileModel.value;
  }

  void completeProfile() {
    isLoading(true);

    CompleteProfile updateProfile = CompleteProfile(
      phoneNumber: phoneController.text.toString(),
      address: addressController.text.toString(),
      profilePictureUrl: profilePictureController.text.toString(),
      gender: selectedGender,
    );

    // // Send the model data as a Map to the API
    _api
        .updateProfile(updateProfile.toMap(), accessToken!)
        .then((onValue) async {
      isLoading(false);
      toast(title: 'Profile Updated Successfully', context: Get.context!);
      Get.back();
    }).onError((error, stackTrace) {
      isLoading(false);
      if (kDebugMode) {
        print('$error and $stackTrace');
      }
    });
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
        borderColor: AppColor.forgroundColor,
        title: 'Chat',
        color: AppColor.forgroundColor,
        icon: null),
  ].obs;

  RxList<CommentButtonModel> commentButtonsList = <CommentButtonModel>[
    CommentButtonModel(icon: Ionicons.chatbubble_outline, title: '1'),
    CommentButtonModel(icon: Ionicons.return_up_back_outline, title: '4'),
    CommentButtonModel(icon: Ionicons.heart_outline, title: '2'),
    CommentButtonModel(icon: Ionicons.stats_chart_outline, title: '4'),
    CommentButtonModel(icon: Ionicons.share_social_outline, title: '')
  ].obs;

  void showProfileCompletionDialog(
      BuildContext context, Rx<ProfileModel>? userProfile) {
    final formKey = GlobalKey<FormState>(); // Form key for validation

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the popup without action
      builder: (context) {
        return AlertDialog(
          title: const Text("Complete Your Profile"),
          content: SingleChildScrollView(
            child: Form(
              key: formKey, // Attach form key
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: phoneController,
                    decoration:
                        const InputDecoration(labelText: "Phone Number"),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone number";
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: "Address"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: profilePictureController,
                    decoration:
                        const InputDecoration(labelText: "Profile Picture URL"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter profile picture URL";
                      } else if (!Uri.tryParse(value)!.hasAbsolutePath) {
                        return "Enter a valid URL";
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedGender,
                    onChanged: (value) {
                      selectedGender = value!;
                    },
                    items: ["male", "female", "other"]
                        .map((gender) => DropdownMenuItem(
                            value: gender, child: Text(gender)))
                        .toList(),
                    decoration: const InputDecoration(labelText: "Gender"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select a gender";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // Only update profile if all fields are valid
                  completeProfile();
                  Navigator.pop(context);
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}

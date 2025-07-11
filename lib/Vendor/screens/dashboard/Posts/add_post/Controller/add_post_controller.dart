import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/add_post/Model/add_post_model.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../App/Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';
import '../../../../../../App/Profile/Model/profile_model.dart';
import '../../../../../../constant/datatimepicker/custom_data_time_picker.dart';
import '../../../profile/controller/profile_controller.dart';
import '../../../profile/model/service_model.dart';
import '../../select_category/Controller/select_category_controller.dart';

class PostController extends GetxController {
  final ApiService apiService = ApiService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController visitingChargesController = TextEditingController();
  final TextEditingController priceModelController = TextEditingController();
  final TextEditingController servicesRadiusController = TextEditingController();
  final TextEditingController serviceChargesController = TextEditingController();
  final TextEditingController subServicesController = TextEditingController();
  final TextEditingController youtubeVideoUrlController = TextEditingController();
  final Rx<VideoPlayerController?> videoController = Rx<VideoPlayerController?>(null);
  final SelectCategoryController controller = Get.put(SelectCategoryController());
  final ProfileController profileController = Get.find();
  UserPreference userPreference = UserPreference();
  final Rx<String?> visitingChargesSelectedItem = Rx<String?>(null);
  final Rx<String?> priceModelSelectedItem = Rx<String?>(null);
  final Rx<String?> waterTypesSelectedItem = Rx<String?>(null);
  final Rx<String?> waterDeliverySelectedItem = Rx<String?>(null);
  final Rx<String?> servicesRadiusSelectedItem = Rx<String?>(null);
  final Rx<String?> toolProvideSelectedItem = Rx<String?>(null);
  bool get isToolsProvided => toolProvideSelectedItem.value?.toLowerCase() == 'yes';
  RxString? selectedServiceCharge = RxString('');
  RxList<WeeklyAvailabilityModel> weeklyAvailabilityList = <WeeklyAvailabilityModel>[].obs;
  String? accessToken;
  final RxList<File> images = <File>[].obs;
  final Rxn<File> selectedImage = Rxn<File>();
  final Rx<File?> selectedVideo = Rx<File?>(null);
  final RxBool isPlaying = false.obs;
  final RxBool isVisit = false.obs;
  final ImagePicker _picker = ImagePicker();
  var showVideo = false.obs;
  String? category;


  @override
  Future<void> onInit() async {
    super.onInit();
    UserProfile? userProfileData =
    await userPreference.getUserProfileData();

    category = userProfileData?.vendor?.assignedService?.mainCategory;
    if (kDebugMode) {
      print('category $category');
    }
    userPreference.getUserAccessToken().then((value) async {
      if (kDebugMode) {
        print('Add Vendor Post Access Token!!! ${value.accessToken}');
      }
      if (value.accessToken!.isNotEmpty ||
          value.accessToken.toString() != 'null') {
         await userPreference.getUserProfileData();
        accessToken = value.accessToken;
      }
    });
    update();
  }


  void submitPost() {
    final String title = titleController.text;
    final String description = descriptionController.text;
    final String youtubeUrl = youtubeVideoUrlController.text;
    final String pricingType = priceModelSelectedItem.toString();
    final String price = selectedServiceCharge?.value == null || selectedServiceCharge!.value.isEmpty
        ? serviceChargesController.text
        : selectedServiceCharge!.value.toString();
    final String serviceRadius = servicesRadiusSelectedItem.value.toString();
    final String visitingCharges = visitingChargesController.text;

    savePost(
      postTitle: title,
      description: description,
      youtubeVideoUrl: youtubeUrl,
      pricingType: pricingType,
      price: price,
      serviceRadius: serviceRadius,
      postVisitingCharges: visitingCharges,
      toolsProvided: isToolsProvided,
      availability: weeklyAvailabilityList,
      images: images,
      shortVideo: selectedVideo,
    );
  }
  void openAvailabilityDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Weekly Availability'),
          content: SizedBox(
            width: double.maxFinite,
            child: CustomDataTimePicker(
              onSave: (List<WeeklyAvailabilityModel> selectedAvailability) {
                weeklyAvailabilityList.value = selectedAvailability;
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  final List<String> visitingChargesItems = [
    '300',
    '400',
    '500',
    '600',
    '700',
    '800',
    '900',
    'Other'
  ];
  final List<String> waterTypeDownItems = [
    'normal',
    'drinking',
    'both',
  ];
  final List<String> priceModelForArchitect = [
    'sqr',
    'sqmt',
    'hourly',
    'fixed',
    'Other'
  ];
  final List<String> priceModelForDomesticAndProfessional = [
    'day',
    'hourly',
    'fixed',
  ];
  final List<String> priceModelForWaterProvider = [
    'liter',
    'gallon',
    'custom',
  ];
  final List<String> waterTypes = [
    'normal',
    'drinking',
    'both',
  ];
  final List<String> waterDeliveryTypes = [
    'delivery',
    'pickup',
    'both',
  ];
  final List<String> measuringUnit = [
    'liter',
    'gallon',
    'custom',
  ];
  final List<String> toolsProvide = [
    'Yes',
    'No',
  ];
  final List<String> servicesRadiusItems = [
    '1',
    '2',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
  ];
  final List<String> serviceChargesItems = [
    '300',
    '400',
    '500',
    '600',
    '700',
    '800',
    '900',
  ];

  Future<void> pickVideo(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 60),
    );

    if (video != null) {
      final fileSizeInBytes = await video.length();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 25) {
        Get.dialog(
          AlertDialog(
            title: const Text("Video Size Exceeded"),
            content: Text(
                "The selected video size is ${fileSizeInMB.toStringAsFixed(2)} MB. The maximum allowed size is 25 MB."),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        selectedVideo.value = File(video.path);

        final controller = VideoPlayerController.file(selectedVideo.value!);
        await controller.initialize();
        videoController.value = controller;
        update(); // to refresh UI after initialization
      }
    } else {
      debugPrint("No video selected or user canceled the picker.");
    }
  }

  void deleteVideo() {
    videoController.value?.dispose();
    videoController.value = null;
    selectedVideo.value = null;
    isPlaying.value = false;
    update();
  }

  void togglePlayPause() {
    final controller = videoController.value;
    if (controller != null) {
      if (isPlaying.value) {
        controller.pause();
      } else {
        controller.play();
      }
      isPlaying.value = !isPlaying.value;
      update();
    }
  }

  Future<void> pickImages(BuildContext context) async {
    final pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      for (final pickedFile in pickedFiles) {
        final fileSizeInBytes = await pickedFile.length();
        final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

        if (fileSizeInMB > 2) {
          Get.dialog(AlertDialog(
            title: const Text("Image Size Exceeded"),
            content: Text(
                "The image ${pickedFile.name} is ${fileSizeInMB.toStringAsFixed(2)} MB (max allowed: 2 MB)."),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("OK"),
              ),
            ],
          ));
        } else {
          images.add(File(pickedFile.path));
        }
      }
    } else {
      debugPrint("No images selected or picker canceled.");
    }
  }

  void removeLastImage() {
    if (images.isNotEmpty) {
      images.removeLast();
    }
  }

  @override
  void dispose() {
    serviceChargesController.dispose();
    super.dispose();
  }

  void showError(String message) {
    Get.snackbar('Error', message);
  }

  bool validateFields({
    required String title,
    required String visitingCharges,
    required String fixedPriceValue,
    String? selectedCategory,
    ServiceModel? selectedServices,
    bool? isVisit,
    String? selectedServiceCharge,
  }) {
    if (selectedCategory == null) {
      showError('Select Category First');
      return false;
    }
    if (title.isEmpty) {
      showError('Title is not Empty');
      return false;
    }
    if (visitingCharges.isEmpty) {
      showError('Please enter visiting Charges');
      return false;
    } else if (visitingCharges == "Other") {
      if (visitingChargesController.text == "") {
        showError('Please enter visiting Charges');
        return false;
      }
    }
    if (fixedPriceValue.isEmpty) {
      showError('No service charges selected or entered');
      return false;
    }
    if (selectedServices == null) {
      showError('Please Select Service Type from Services');
      return false;
    }
    if (selectedImage.value == null) {
      showError('No image selected');
      return false;
    }
    if (selectedVideo.value == null) {
      showError('No video selected');
      return false;
    }
    return true;
  }

  Future<void> savePost({
    required String postTitle,
    required String description,
    required String youtubeVideoUrl,
    required String pricingType,
    required String serviceRadius,
    required String postVisitingCharges,
    required String price,
    bool? toolsProvided,
    required List<File> images,
    required Rx<File?> shortVideo,
    List<WeeklyAvailabilityModel>? availability,
  }) async {
    final postModel = AddPostModel(
      title: postTitle,
      description: description,
      images: images,
      youtubeVideoUrl: youtubeVideoUrl,
      shortVideo: shortVideo,
      pricingType: pricingType,
      price: price,
      visitingCharges: postVisitingCharges,
      serviceRadius: serviceRadius,
      toolsProvided: toolsProvided,
      availability: availability,
    );

    await apiService.postWithFeaturePackage(
      postModel,
      images,
      shortVideo.value,
      accessToken!,
    );
  }
}

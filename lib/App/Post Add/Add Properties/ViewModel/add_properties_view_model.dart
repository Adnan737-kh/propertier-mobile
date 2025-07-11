import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/Model/features_model.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/services/add_properties_services.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';

import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http/http.dart' as http;
import '../../../../Handlers/permissions_handler.dart';
import '../../../../Network/http_multipart_request.dart';
import '../../../../constant/constant.dart';
import '../../../../constant/toast.dart';
import '../../../../res/app_urls/app_url.dart';
import '../../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';
import '../../../Profile/ViewModel/profile_view_model.dart';
import '../../../What are you searching/ViewModel/what_are_viewmodel.dart';

class AddPropertiesViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  TextEditingController searchLocationController = TextEditingController();

  // final PropertyRepository _api = PropertyRepository();
  UserPreference userPreference = UserPreference();
  RxnString accessToken = RxnString();
  bool? _isProfileCompleted;
  bool? get isProfileCompleted => _isProfileCompleted;
  RxBool isSuccess = true.obs;
  RxString selectedArea = ''.obs;
  RxString selectedBathroom = ''.obs;
  RxString selectedBedRoom = ''.obs;
  RxString selectedPropertyType = ''.obs;
  RxString selectAreaUnitType = ''.obs;
  RxString selectedFloors = ''.obs;
  RxList<Place> places = <Place>[].obs;
  final RxInt _selectedPurpose = 0.obs;
  int get selectedPurpose => _selectedPurpose.value;
  var selectedFacilities = <int>[].obs;
  final vm = Get.put(UploadPropertyViewModel());
  var featuresList = Features().obs;
  final RxString _videoPath = ''.obs;
  String get videoPath => _videoPath.value;
  final RxString _thumbNailPath = ''.obs;
  String get thumbNailPath => _thumbNailPath.value;
  RxList<String> placesList = <String>[].obs; // Stores place names
  RxMap<String, GeoPoint> placesMap = <String, GeoPoint>{}.obs; // Map for names to GeoPoints
  RxList<String> galleryImage = <String>[].obs;
  RxBool uploadCompleted = false.obs;

  var selectedCountry = Rxn<Country>();
  var currencySymbol = '\$'.obs;

  void showCountryPickerFn(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        selectCountry(country);
      },
    );
  }
  void selectCountry(Country country) {
    selectedCountry.value = country;
    currencySymbol.value = _getCurrencySymbol(country.countryCode);
  }

  String _getCurrencySymbol(String countryCode) {
    switch (countryCode) {
      case 'US':
        return '\$';
      case 'GB':
        return '£';
      case 'EU':
        return '€';
      case 'IN':
        return '₹';
      case 'JP':
        return '¥';
      case 'PK':
        return '₨';
      default:
        return '\$';
    }
  }

  var selectedCurrency = 'USD'.obs;

  final List<String> currencyList = [
    'USD', // US Dollar
    'PKR', // Pakistani Rupee
    'INR', // Indian Rupee
    'EUR', // Euro
    'GBP', // British Pound
    'JPY', // Japanese Yen
    'AED', // UAE Dirham
  ];

  void setCurrency(String currency) {
    selectedCurrency.value = currency;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    unitsController.dispose();
    locationController.dispose();
    urlController.dispose();
    super.dispose();
  }

  void getAccessToken() async {
    var user = await userPreference.getUserAccessToken();

    if (user.accessToken != null) {
      accessToken.value = user.accessToken;
      userPreference.getUserProfileData().then((value) async {
        if (value!.profilePictureUrl.isNotEmpty ||
            value.profilePictureUrl.toString() != 'null') {
          _isProfileCompleted = value.requiresProfileCompletion;
          if (kDebugMode) {
            print('is profile completed $_isProfileCompleted');
          }
        }
      });
    }
  }

  List<String> areaType = <String>[
    'Commercial',
    'Residential',
  ];
  List<String> areaUnit = <String>[
    'ft²',
    'marla',
    'kanal',
    'acre',
  ];
  List<String> areaUnitType = <String>[
    'ft²',
    'marla',
    'kanal',
    'acre',
  ];
  List<String> bedrooms = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  List<String> bathrooms = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
  ];

  List<String> floors = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];

  var facilities = <String>[
    'Parking space',
    'Waste disposal',
    'Furnished',
    'Lounge Sitting rooms',
    'Servant Quater',
    'Drawing Room',
    'Store Room',
    'Study Room',
    'Laundry Rooms',
    'Electricity Room',
  ].obs;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<bool> uploadProperties({
    required BuildContext context,
    required String agentID,
    required String title,
    required String price,
    required String purpose,
    required String type,
    required String bedroom,
    required String bathroom,
    required String country,
    required String city,
    required String address,
    required String area,
    required String areaType,
    required String image,
    required String shortVideo,
    required String video,
    required String description,
    required List<String> galleryImages,
    required String floor,
    required List<int> features,
    required String areaUnit,
    required String accessToken,
  }) async {

    if (kDebugMode) {
      print('selectedFacilities $selectedFacilities');
    }
    isSuccess.value = false;
    try {
      RxDouble? progress;
      final uri = Uri.parse(AppUrls.propertiesUploadUrl);

      Get.offAllNamed(
        AppRoutes.navBarView,
        arguments: {'initialIndex': 2},
      );
      var request = MultipartRequest(
        'POST',
        uri,
        onProgress: (int bytes, int total) {
          vm.showOverlay();
          progress = (bytes / total).obs;
          showNotificationWithProgress(progress!.value * 100, 'uploading');
          vm.changeValue(progress!.value);
        },
      );

      // Add Headers
      request.headers.addAll({
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'multipart/form-data',
      });

      if (kDebugMode) {
        print('amenities ${jsonEncode(features)}');
      }
      // Add fields
      request.fields['agent'] = agentID;
      request.fields['title'] = title;
      request.fields['price'] = price;
      request.fields['bedroom'] = bedroom;
      request.fields['bathroom'] = bathroom;
      request.fields['country'] = "Peshawar";
      request.fields['city'] = "Peshawar";
      request.fields['city_slug'] = "Peshawar";
      request.fields['address'] = "Peshawar";
      request.fields['area'] = area;
      request.fields['area_type'] = areaType;
      request.fields['description'] = description;
      request.fields['type'] = type;
      request.fields['purpose'] = purpose;
      request.fields['floor'] = floor;
      request.fields['area_unit'] = areaUnit;
      request.fields['video'] = video;

      if (kDebugMode) {
        print(jsonEncode({
          "agent": agentID,
          "title": title,
          "price": price,
          "bedroom": bedroom,
          "bathroom": bathroom,
          "city": "Peshawar",
          "city_slug": "Peshawar",
          "address": "Peshawar",
          "area": area,
          "area_type": areaType,
          "description": description,
          "type": type,
          "purpose": purpose,
          "floor": floor,
          "area_unit": areaUnit,
          "video": video,
          "amenities": features, // Ensure it's a List<int>
          "image": image.isNotEmpty ? "Attached" : "Not Provided",
          "short_video": shortVideo.isNotEmpty ? "Attached" : "Not Provided",
          "GalleryImages": galleryImages.map((img) => "Attached").toList(),
        }));
      }

      if (kDebugMode) {
        print("Multipart Fields: ${request.fields}");
      }

      for (int i = 0; i < features.length; i++) {
        request.fields['amenities[$i]'] = features[i].toString();
        if (kDebugMode) {
          print("Sending amenities[$i]: ${features[i].toString()}");
        }
      }

      // Add Image
      if (image.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath('image', image));
      }

      // Add Short Video
      if (shortVideo.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('short_video', shortVideo));
      }

      // Add Gallery Images
      for (var img in galleryImages) {
        request.files
            .add(await http.MultipartFile.fromPath('GalleryImages', img));
      }

      if (kDebugMode) {
        print("Payload before sending: ${request.fields}");
      }

      // Send Request
      var response = await request.send();
      final res = await http.Response.fromStream(response);

      if (res.statusCode == 200 || res.statusCode == 201) {
       uploadCompleted.value = true;
       final profileVM = Get.put(ProfileViewModel());
       await profileVM.getProfile(
         context: Get.context!, // safe because this is inside GetMaterialApp
         accessToken: accessToken,
       );
        var responseData = jsonDecode(res.body);
        if (kDebugMode) {
          print("Property Uploaded Successfully: $responseData");
        }
        vm.hideOverlay();
        showNotificationWithProgress(
            progress!.value * 100, 'Property Uploaded Successfully');
        isSuccess.value = true;
      } else {
        vm.hideOverlay();
        showNotificationWithProgress(
            progress!.value * 100, 'Property Uploading Failed');
        if (kDebugMode) {
          print("Upload Failed: ${res.body}");
        }
      }
    } catch (e) {
      vm.hideOverlay();
      if (kDebugMode) {
        print("Error: $e");
      }
    }

    return isSuccess.value;
  }

  void showNotificationWithProgress(double progress, String message) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1',
      'Propertier',
      importance: Importance.max,
      priority: Priority.high,
      showProgress: true,
      onlyAlertOnce: true,
      maxProgress: 100,
      progress: progress.toInt(),
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message,
      '${progress.toInt()} %',
      platformChannelSpecifics,
    );
  }

  getFeaturesData() async {
    final data = await AddPropertiesServices().getFeatures();
    featuresList.value = data;
  }

  @override
  void onInit() {
    getFeaturesData();
    getAccessToken();
    super.onInit();
  }

  pickVideo() async {
    if (await PermissionsHandler.requestGalleryPermission()) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowCompression: true,
      );
      if (result != null) {
        _videoPath.value = result.files.first.path!;
        if (result.files.first.size >= 14000000) {
          CustomToast.show(
              title: 'Video Size must be less then 14MB',
              context: Get.context!);

          return;
        }
        _thumbNailPath.value =
            (await generateThumbnail(result.files.single.path!))!;
      }
    }
  }

  final RxString _pickedFrontImage = ''.obs;
  String get thumbnailImage => _pickedFrontImage.value;
  setPickedImage(String val) => _pickedFrontImage.value = val;
  Future<void> pickImage(bool front) async {
    if (await PermissionsHandler.requestGalleryPermission()) {
      final imageFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);

      if (imageFile != null) {
        if (front) {
          _pickedFrontImage.value = imageFile.path;
        }
      }
    }
  }

  Future<String?> generateThumbnail(String videoPath) async {
    try {
      final String? thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128, // specify the width of the thumbnail, can be adjusted
        quality: 75, // specify the quality of the thumbnail, can be adjusted
      );
      return thumbnailPath;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  changeSelectedPurpose(int index) {
    _selectedPurpose.value = index;
  }

  multiImagePick() async {
    if (await PermissionsHandler.requestGalleryPermission()) {
      final result =
          await ImagePicker().pickMultiImage(imageQuality: 50, limit: 5);
      if (result.isNotEmpty) {
        if (result.length > 5) {
          for (int i = 0; i < 5; i++) {
            galleryImage.add(result[i].path);
          }
        } else {
          for (var img in result) {
            galleryImage.add(img.path);
          }
        }
      }
    }
  }

  removeImage(int index) {
    galleryImage.removeAt(index);
  }

  Future<void> searchPlaces(String input,
      {bool isCurrentLocation = false}) async {
    const apiKey = Constant.googleApiKey;
    const endpoint =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final url = '$endpoint?input=$input&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.statusCode);
      }
      final data = json.decode(response.body);
      if (kDebugMode) {
        print('Prediction $data');
      }
      final predictions = data['predictions'] as List<dynamic>;
      if (kDebugMode) {
        print("Prediction ${predictions.length}");
      }
      places.value = predictions.map((prediction) => Place(
                placeId: prediction['place_id'],
                description: prediction['description'],)).toList();
    } else {
      places.value = [];
    }
  }

  pickFile() async {
    if (await PermissionsHandler.requestGalleryPermission()) {
      final file = await FilePicker.platform.pickFiles();
      if (file != null) {}
    }
  }
}

class UploadPropertyViewModel extends GetxController {
  RxBool isSuccess = true.obs;

  RxDouble progress = 0.0.obs;
  var isOverlayVisible = false.obs;
  changeValue(double updateProgress) {
    progress.value = updateProgress;
  }

  void showOverlay() {
    isOverlayVisible.value = true;
  }

  void hideOverlay() {
    isOverlayVisible.value = false;
  }
}

class PlaceInfo {
  final String name;
  final GeoPoint geoPoint;

  PlaceInfo({required this.name, required this.geoPoint});
}

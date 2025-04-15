import 'dart:convert';

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
import '../../../NavBar/ViewModel/navbar_view_model.dart';
import '../../../What are you searching/ViewModel/what_are_viewmodel.dart';

class AddPropertiesViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  // final PropertyRepository _api = PropertyRepository();
  UserPreference userPreference = UserPreference();
  RxnString accessToken = RxnString();

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
    if (kDebugMode) {
      print("@@@@@@ ${user.accessToken}");
    }
    if (user.accessToken != null) {
      accessToken.value = user.accessToken; // Updating observable variable
    }
  }
  // var featues = Features().obs;

  RxString selectedArea = ''.obs;
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
  RxString selectedPropertyType = ''.obs;
  RxString selectAreaUnitType = ''.obs;
  List<String> areaUnitType = <String>[
    'ft²',
    'marla',
    'kanal',
    'acre',
  ];
  RxString selectedBathroom = ''.obs;
  RxString selectedBedRoom = ''.obs;
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

  RxString selectedFloors = ''.obs;

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
  var selectedFacilities = <int>[].obs;
  final vm = Get.put(UploadPropertyViewModel());
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  // void uploadProperties({
  //   required BuildContext context,
  //   required String agentID,
  //   required String title,
  //   required String price,
  //   required String purpose,
  //   required String type,
  //   required String bedroom,
  //   required String bathroom,
  //   required String city,
  //   required String address,
  //   required String area,
  //   required String areaType,
  //   required String image,
  //   required String shortVideo,
  //   required String video,
  //   required String description,
  //   required List<String> galleryImages,
  //   required String floor,
  //   required List<int> features,
  //   required String areaUnit,
  //   String? accessToken,
  // })async{
  //
  //
  //   Map data1 = {
  //     "title": title,
  //     "price": price,//int
  //     "bedroom": bedroom,
  //     "bathroom": bathroom,
  //     "city": "Islamabad",
  //     "city_slug":city,
  //     "address": "Islamabad",
  //     "area": area, //int
  //     "area_type": areaType,
  //     "description": description,
  //     "type": type,
  //     "purpose": purpose,
  //     // "Features": features,
  //     "floor": floor,
  //     "area_unit": areaUnit,
  //     "image": galleryImage,
  //     "nearby": "near by plaza"
  //   };
  //   _api.uploadProperties(data1, accessToken!)
  //       .then((onValue) async {
  //     // isLoading(false);
  //     toast(title: 'Features added successfully!', context: Get.context!);
  //     // Get.back();
  //   }).onError((error, stackTrace) {
  //     // isLoading(false);
  //     print('$error and $stackTrace');
  //   });
  //
  //   print('image ${galleryImages}');
  //   print('accessToken $accessToken');
  //
  //
  // }
  //
  // final uri = Uri.parse(AppUrls.propertiesUploadUrl);
  // final headers = {
  //   "Content-Type": "application/json",
  //   'Authorization': 'Bearer $accessToken',
  // };
  //
  // Map data = {
  //   "title": title,
  //   "price": price,//int
  //   "bedroom": bedroom,
  //   "bathroom": bathroom,
  //   "city": "Islamabad",
  //   "city_slug":city,
  //   "address": "Islamabad",
  //   "area": area, //int
  //   "area_type": areaType,
  //   "description": description,
  //   "type": type,
  //   "purpose": purpose,
  //   // "Features": features,
  //   "floor": floor,
  //   "area_unit": areaUnit,
  //   "GalleryImages": galleryImage,
  //   "nearby": "near by plaza"
  // };
  // final body = jsonEncode(data);
  //
  // final responses = await http.post(uri, headers: headers, body: body);
  //
  // if (responses.statusCode == 201) {
  //   print('Features added successfully!');
  // }else{
  //   print('Features added Failed! ${responses.body}' );
  // }

  RxBool isSuccess = true.obs;
  Future<bool> uploadProperties({
    required BuildContext context,
    required String agentID,
    required String title,
    required String price,
    required String purpose,
    required String type,
    required String bedroom,
    required String bathroom,
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
      final uri =
          Uri.parse(AppUrls.propertiesUploadUrl);

      var request = MultipartRequest(
        'POST',
        uri,
        onProgress: (int bytes, int total) {
          vm.showOverlay();
           progress = (bytes / total).obs;
          showNotificationWithProgress(progress!.value * 100,'uploading');
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

      // request.fields['amenities'] = jsonEncode(features); // Sends the list as a JSON array
      // print("Sending amenities as JSON: ${jsonEncode(features)}");

      if (kDebugMode) {
        print("Upload Payload:");
      }
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
        "amenities": features,  // Ensure it's a List<int>
        "image": image.isNotEmpty ? "Attached" : "Not Provided",
        "short_video": shortVideo.isNotEmpty ? "Attached" : "Not Provided",
        "GalleryImages": galleryImages.map((img) => "Attached").toList(),
      }));
      }

      if (kDebugMode) {
        print("Multipart Fields: ${request.fields}");
      }


      for (int i = 0; i < features.length; i++) {
        // Sending each feature as a separate key-value pair
        request.fields['amenities[$i]'] = features[i].toString();  // Convert the int to string for sending
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
        var responseData = jsonDecode(res.body);
        if (kDebugMode) {
          print("Property Uploaded Successfully: $responseData");
        }
        Get.toNamed(AppRoutes.profileView);
        vm.hideOverlay();
        showNotificationWithProgress(progress!.value * 100,'Property Uploaded Successfully');
        isSuccess.value  = true;
      } else {
        vm.hideOverlay();
        showNotificationWithProgress(progress!.value * 100,'Property Uploading Failed');
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

    return  isSuccess.value;
  }

  // Future<bool> uploadProperties({
  //   required String agentID,
  //   required String title,
  //   required String price,
  //   required String purpose,
  //   required String type,
  //   required String bedroom,
  //   required String bathroom,
  //   required String city,
  //   required String address,
  //   required String area,
  //   required String areaType,
  //   required String image,
  //   required String shortVideo,
  //   required String video,
  //   required String description,
  //   required List<String> galleryImages,
  //   required String floor,
  //   required List<int> features,
  //   required String areaUnit,
  //   required String accessToken, required BuildContext context,
  // }) async {
  //
  //   bool isSuccess = false;
  //
  //   try {
  //     final uri = Uri.parse(AppUrls.propertiesUploadUrl);
  //
  //     // Create the payload as a JSON object
  //     var payload = {
  //       'agent': agentID,
  //       'title': title,
  //       'price': price,
  //       'bedroom': bedroom,
  //       'bathroom': bathroom,
  //       'city': "Peshawar", // This can be dynamic if needed
  //       'city_slug': "Peshawar", // Same as above
  //       'address': "Peshawar", // Same as above
  //       'area': area,
  //       'area_type': areaType,
  //       'description': description,
  //       'type': type,
  //       'purpose': purpose,
  //       'floor': floor,
  //       'area_unit': areaUnit,
  //       'video': video,
  //       'amenities': features,  // This will be sent as a list of integers
  //       'image': image.isNotEmpty ? "Attached" : "Not Provided",
  //       'short_video': shortVideo.isNotEmpty ? "Attached" : "Not Provided",
  //       'GalleryImages': galleryImages.map((img) => "Attached").toList(),
  //     };
  //
  //     // Convert payload to JSON
  //     String jsonPayload = jsonEncode(payload);
  //     print("Sending Payload: $jsonPayload");
  //
  //     // Send POST request
  //     final response = await http.post(
  //       uri,
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonPayload,
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       var responseData = jsonDecode(response.body);
  //       print("Property Uploaded Successfully: $responseData");
  //       isSuccess = true;
  //     } else {
  //       print("Upload Failed: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  //
  //   return isSuccess;
  // }

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

  var featuresList = Features().obs;
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

  final RxString _videoPath = ''.obs;
  String get videoPath => _videoPath.value;
  final RxString _thumbNailPath = ''.obs;
  String get thumbNailPath => _thumbNailPath.value;

  pickVideo() async {
    if (await PermissionsHandler.requestGalleryPermission()) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowCompression: true,
      );
      if (result != null) {
        _videoPath.value = result.files.first.path!;
        if (result.files.first.size >= 14000000) {
          toast(
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

  final RxInt _selectedPurpose = 0.obs;

  int get selectedPurpose => _selectedPurpose.value;
  changeSelectedPurpose(int index) {
    _selectedPurpose.value = index;
  }

  RxList<String> galleryImage = <String>[].obs;

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

  RxList<Place> places = <Place>[].obs;

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
      places.value = predictions
          .map((prediction) => Place(
                placeId: prediction['place_id'],
                description: prediction['description'],
              ))
          .toList();
    } else {
      places.value = [];
    }
  }

  RxList<String> placesList = <String>[].obs; // Stores place names
  RxMap<String, GeoPoint> placesMap = <String, GeoPoint>{}.obs; // Map for names to GeoPoints
  TextEditingController searchLocationController = TextEditingController();

  // Future<void> searchPlaces(String input) async {
  //   const endpoint = 'https://nominatim.openstreetmap.org/search';
  //   final url = '$endpoint?q=$input&format=json';
  //
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body) as List<dynamic>;
  //
  //     placesList.clear();
  //     placesMap.clear();
  //
  //     for (var place in data) {
  //       if (place['display_name'] != null) {
  //         String name = place['display_name'];
  //         GeoPoint point = GeoPoint(
  //           latitude: double.parse(place['lat']),
  //           longitude: double.parse(place['lon']),
  //         );
  //
  //         placesList.add(name);
  //         placesMap[name] = point;
  //       }
  //     }
  //   } else {
  //     placesList.clear();
  //     placesMap.clear();
  //   }
  // }

  pickFile() async {
    if (await PermissionsHandler.requestGalleryPermission()) {
      final file = await FilePicker.platform.pickFiles();
      if (file != null) {}
    }
  }
}

class UploadPropertyViewModel extends GetxController {
  RxBool isSuccess = true.obs;
  Future uploadPropertyData({
    required BuildContext context,
    required String agentID,
    required String title,
    required String price,
    required String purpose,
    required String type,
    required String bedroom,
    required String bathroom,
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
    String? accessToken,
  }) async {
    isSuccess.value = false;
    final result = await AddPropertiesServices().uploadProperty(
        context: context,
        areaUnit: areaUnit,
        features: features,
        agentID: agentID,
        floor: floor,
        areatype: areaType,
        galleryImage: galleryImages,
        title: title,
        price: price,
        purpose: purpose,
        type: type,
        bedroom: bedroom,
        bathroom: bathroom,
        city: "IslamAbad",
        address: "IslamAbad",
        area: area,
        image: image,
        shortVideo: shortVideo,
        video: video,
        description: description,
        accessToken: accessToken);

    if (result == true) {
      isSuccess.value = true;
      Get.find<NavBarViewModel>().changeSelectedTab(2);
      Get.back();
    } else {
      isSuccess.value = true;
    }
  }

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

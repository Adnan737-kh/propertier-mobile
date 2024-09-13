import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/Model/features_model.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/services/add_properties_services.dart';
import 'package:propertier/App/What%20are%20you%20searching/ViewModel/what_are_viewmodel.dart';
import 'package:propertier/constant/constant.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http/http.dart' as http;
import '../../../../Handlers/permissions_handler.dart';
import '../../../../constant/toast.dart';
import '../../../NavBar/ViewModel/navbar_view_model.dart';

class AddPropertiesViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

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
  RxString selectedpropertyType = ''.obs;

  RxString selectAreaUnitType = ''.obs;
  List<String> areaUnitType = <String>[
    'ft²',
    'marla',
    'kanal',
    'acre',
  ];
  RxString selectedBathroom = ''.obs;
  RxString selectedbedRoom = ''.obs;
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

  RxString selectedfloors = ''.obs;

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

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  var featuresList = Features().obs;
  getFeaturesData() async {
    final data = await AddPropertiesServices().getFeatures();
    featuresList.value = data;
  }

  @override
  void onInit() {
    getFeaturesData();
    // TODO: implement onInit
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
  String get pickedImage => _pickedFrontImage.value;
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
      print(e);
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
    const apiKey = Constant.google_api_key;
    const endpoint =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final url = '$endpoint?input=$input&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.statusCode);
      final data = json.decode(response.body);
      print('Prediction $data');
      final predictions = data['predictions'] as List<dynamic>;
      print("Prediction ${predictions.length}");
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

  TextEditingController searchLocationController = TextEditingController();

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
    required String areatype,
    required String image,
    required String shortVideo,
    required String video,
    required String description,
    required List<String> galleryImages,
    required String floor,
    required List<int> features,
    required String areaUnit,
  }) async {
    isSuccess.value = false;
    final result = await AddPropertiesServices().uploadProperty(
        context: context,
        areaUnit: areaUnit,
        features: features,
        agentID: agentID,
        floor: floor,
        areatype: areatype,
        galleryImage: galleryImages,
        title: title,
        price: price,
        purpose: purpose,
        type: type,
        bedroom: bedroom,
        bathroom: bathroom,
        city: city,
        address: address,
        area: area,
        image: image,
        shortVideo: shortVideo,
        video: video,
        description: description);

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
  changeValue(double prog) {
    progress.value = prog;
  }

  void showOverlay() {
    isOverlayVisible.value = true;
  }

  void hideOverlay() {
    isOverlayVisible.value = false;
  }
}

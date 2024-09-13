import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:propertier/App/PropertiesAndShortVideo/Model/all_properties_model.dart';
import 'package:propertier/constant/constant.dart';

import '../../../Home/View/home_view.dart';
// import '../Model/all_properties_model.dart';
import '../Model/prorperties_tile_model.dart';
// import '../Model/videos_model.dart';
// import '../Model/videos_model.dart';
import '../Services/all_properties_services.dart';

class ProfilePropertyListingViewModel extends GetxController {
  TextEditingController searchController = TextEditingController();

  final isLoading = false.obs;
  // bool get isLoading => _isLoading.value;
  setIsLoading(value) => isLoading.value = value;

  var data = Get.arguments;

  final isLoadingAll = false.obs;
  // bool get isLoadingAll => isLoadingAll.value;
  setIsLoadingAll(value) => isLoadingAll.value = value;

  final RxString _currentLocation = "All Locations".obs;
  String get currentLocation => _currentLocation.value;
  onChangeLocation(String value) {
    _currentLocation.value = value;
    doFilterAllData();
  }

  RxBool isSale = true.obs;
  changeSale(int val) {
    if (val == 0) {
      isSale.value = true;
    } else {
      isSale.value = false;
    }
  }

  RxList<String> listOfTab = RxList<String>();
  final RxInt _selectedTabIndex = 0.obs;
  int get selectedTabIndex => _selectedTabIndex.value;

  final RxString _selectedTab = 'All Types'.obs;
  String get selectedTab => _selectedTab.value;
  setSelectTab(String val) {
    _selectedTab.value = val;
    // if (val == "All Types") {
    //   getAllProperties(context: Get.context!, type: val).then(
    //     (value) {
    //       doFilterAllData();
    //     },
    //   );
    // } else {
    //   getAllProperties(context: Get.context!, type: val).then(
    //     (value) {
    doFilterAllData();
    //     },
    //   );
    // }
  }

  @override
  void onInit() {
    if (data["PropertyEnum"] == PoropertiesAndVideoEnum.video) {
      getAllProperties(
          context: Get.context!, id: data["PropertiesType"].toString());
    } else {
      getAllProperties(
          context: Get.context!, id: data["PropertiesType"].toString());
    }
    super.onInit();
  }

  final RxString _purpose = 'sale'.obs;
  String get purpose => _purpose.value;
  setPurpose(String value) {
    _purpose.value = value;
    doFilterAllData();
  }

  final RxList<Property> _propertyList = <Property>[].obs;
  RxList<Property> get propertyList => _propertyList;
  onChangeTab(String tab) {
    _selectedTab.value = tab;
  }

  final RxList<Property> _videosList = <Property>[].obs;
  RxList<Property> get videosList => _videosList;
  onChangeTabVideos(
    String tab,
  ) {
    _selectedTab.value = tab;
  }

  List<ArchitectureModel> architectureList = <ArchitectureModel>[
    ArchitectureModel(
        image: Constant.dummayImage,
        isFavorite: true,
        price: "PKR 10000",
        area: "",
        location: "DHA phase 6 Lahore , LAHORE",
        time: "20 days ago",
        title: "Building Architecture Designer"),
    ArchitectureModel(
        image: Constant.dummayImage,
        isFavorite: false,
        price: "PKR 10000",
        area: "5 Marla",
        location: "DHA phase 6 Lahore , LAHORE",
        time: "20 days ago",
        title: "Interior Architecture Designer"),
  ];

  final RxInt _onShortDetailChangeIndex = 0.obs;
  int get onShortDetailChangeIndex => _onShortDetailChangeIndex.value;
  changeShortDetailIndex(int index) {
    _onShortDetailChangeIndex.value = index;
  }

  PageController pageController = PageController();
  Rx<AllPropertiesModel> allPropertiesModel = AllPropertiesModel().obs;
  Future<AllPropertiesModel> getAllProperties(
      {required BuildContext context, required String id}) async {
    setIsLoadingAll(true);
    listOfTab.clear();
    final result = await AllPropertiesServices()
        .getAllPropertiesData(context: context, userId: id);
    if (result.data!.properties.isNotEmpty) {
      allPropertiesModel.value = result;
      for (var element in allPropertiesModel.value.data!.properties) {
        if (!listOfTab
            .any((e) => e.toLowerCase() == element.type!.toLowerCase())) {
          listOfTab.add(element.type!);
        }
      }
      doFilterAllData();
      print(
          "print posts Length ${allPropertiesModel.value.data!.cities.length}");
    }
    setIsLoadingAll(false);

    return allPropertiesModel.value;
  }

  doFilterAllData() {
    setIsLoading(true);
    List<Property> newList = [];
    List<Property> videonewList = [];
    if (currentLocation == "All Locations") {
      //!Addeding All location data
      if (selectedTab == "All Types") {
        //!Addeding All location data And All Types
        newList = allPropertiesModel.value.data == null
            ? []
            : allPropertiesModel.value.data!.properties
                .where((element) => element.purpose.toString() == purpose)
                .toList();
      } else {
        newList = allPropertiesModel.value.data == null
            ? []
            : allPropertiesModel.value.data!.properties
                .where((element) =>
                    element.type!.toLowerCase() == selectedTab.toLowerCase() &&
                    element.purpose!.toString().toLowerCase() ==
                        purpose.toLowerCase())
                .toList();
      }
    } else {
      if (selectedTab == "All Types") {
        newList = allPropertiesModel.value.data == null
            ? []
            : allPropertiesModel.value.data!.properties
                .where((element) =>
                    element.city == currentLocation &&
                    element.purpose!.toString().toLowerCase() ==
                        purpose.toLowerCase())
                .toList();
      } else {
        newList = allPropertiesModel.value.data == null
            ? []
            : allPropertiesModel.value.data!.properties
                .where((element) =>
                    element.type!.toLowerCase() == selectedTab.toLowerCase() &&
                    element.city == currentLocation &&
                    element.purpose!.toString().toLowerCase() ==
                        purpose.toLowerCase())
                .toList();
      }
    }

    _videosList.clear();
    _propertyList.clear();
    _videosList.value = videonewList;
    _propertyList.value = newList;
    setIsLoading(false);
  }

  // Rx<AllPropertiesModel> videosModel = AllPropertiesModel().obs;
  // Future<AllPropertiesModel> getVideosData(
  //     {required BuildContext context, required String id}) async {
  //   setIsLoadingAll(true);

  //   final result = await AllPropertiesServices()
  //       .getAllPropertiesData(context: context, userId: id);
  //   if (result.data != null) {
  //     videosModel.value = result;
  //     doFilterAllData();

  //     // print("Videos is ${videosModel.value.data!.videos!.length}");
  //   }
  //   setIsLoadingAll(false);

  //   return videosModel.value;
  // }
}

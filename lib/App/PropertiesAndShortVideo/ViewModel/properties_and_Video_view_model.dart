import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:propertier/App/PropertiesAndShortVideo/Model/all_properties_model.dart';
import 'package:propertier/App/PropertiesAndShortVideo/Model/prorperties_tile_model.dart';
import 'package:propertier/App/PropertiesAndShortVideo/Model/videos_model.dart';
import 'package:propertier/App/PropertiesAndShortVideo/Services/all_properties_services.dart';
import 'package:propertier/constant/constant.dart';

import '../../Home/View/home_view.dart';

class PropertiesAndVideoViewModel extends GetxController {
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
    if (data["PropertyEnum"] == PropertiesAndVideoEnum.video) {
      getAllProperties(context: Get.context!, type: "");
    } else {
      getAllProperties(context: Get.context!, type: "");
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

  final RxList<Video> _videosList = <Video>[].obs;
  RxList<Video> get videosList => _videosList;
  onChangeTabVideos(
    String tab,
  ) {
    _selectedTab.value = tab;
  }

  List<ArchitectureModel> architectureList = <ArchitectureModel>[
    ArchitectureModel(
        image: Constant.dummyImage,
        isFavorite: true,
        price: "PKR 10000",
        area: "",
        location: "DHA phase 6 Lahore , LAHORE",
        time: "20 days ago",
        title: "Building Architecture Designer"),
    ArchitectureModel(
        image: Constant.dummyImage,
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
  // Future<AllPropertiesModel> getAllProperties(
  //     {required BuildContext context, required String type}) async {
  //   setIsLoadingAll(true);
  //   listOfTab.clear();
  //   final result = await AllPropertiesServices()
  //       .getAllPropertiesData(context: context, type: type);
  //   if (result.data!.properties.isNotEmpty) {
  //     allPropertiesModel.value = result;
  //     for (var element in allPropertiesModel.value.data!.properties) {
  //       if (!listOfTab
  //           .any((e) => e.toLowerCase() == element.type!.toLowerCase())) {
  //         listOfTab.add(element.type!);
  //       }
  //     }
  //     doFilterAllData();
  //     print(
  //         "print posts Length ${allPropertiesModel.value.data!.cities.length}");
  //   }
  //   setIsLoadingAll(false);
  //
  //   return allPropertiesModel.value;
  // }

  Future<AllPropertiesModel> getAllProperties(
      {required BuildContext context, required String type}) async {
    setIsLoadingAll(true);
    listOfTab.clear();
    final result = await AllPropertiesServices()
        .getAllPropertiesData(context: context, type: type);
    if (kDebugMode) {
      print("Response Length ${result.properties?.length}");
    }

    if (result.properties != null && result.properties!.isNotEmpty) {
      allPropertiesModel.value = result;

      // Iterate over the properties and add them to _propertyList
      for (var element in allPropertiesModel.value.properties!) {
        // Assuming Property is directly addable, without needing toJson (if it's already a Property object)
        _propertyList.add(element);

        // Check if the type is already in the list and add if not
        if (!listOfTab.any((e) => e.toLowerCase() == element.type.toLowerCase())) {
          listOfTab.add(element.type);
        }
      }

      doFilterAllData();
    }

    setIsLoadingAll(false);
    return allPropertiesModel.value;
  }

  void doFilterAllData() {
    setIsLoading(true);
    List<Property> newList = [];

    bool isAllLocations = currentLocation == "All Locations";
    bool isAllTypes = selectedTab == "All Types";

    // Check if properties exist
    List<Property> properties = allPropertiesModel.value.properties ?? [];

    newList = properties.where((element) {
      bool matchesLocation = isAllLocations || element.city == currentLocation;
      bool matchesType = isAllTypes || element.type.toLowerCase() == selectedTab.toLowerCase();
      bool matchesPurpose = element.purpose.toLowerCase() == purpose.toLowerCase();

      return matchesLocation && matchesType && matchesPurpose;
    }).toList();

    // Sort by `createdAt`
    newList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    _propertyList.clear();
    _propertyList.value = newList;

    setIsLoading(false);
  }


//   doFilterAllData() {
//     setIsLoading(true);
//     List<Property> newList = [];
//     if (currentLocation == "All Locations") {
//       //!Addeding All location data
//       if (selectedTab == "All Types") {
//         //!Addeding All location data And All Types
//         newList = allPropertiesModel.value.data == null
//             ? []
//             : allPropertiesModel.value.data!.properties
//                 .where((element) => element.purpose.toString() == purpose)
//                 .toList();
//       } else {
//         newList = allPropertiesModel.value.data == null
//             ? []
//             : allPropertiesModel.value.data!.properties
//                 .where((element) =>
//                     element.type!.toLowerCase() == selectedTab.toLowerCase() &&
//                     element.purpose!.toString().toLowerCase() ==
//                         purpose.toLowerCase())
//                 .toList();
//       }
//     } else {
//       if (selectedTab == "All Types") {
//         newList = allPropertiesModel.value.data == null
//             ? []
//             : allPropertiesModel.value.data!.properties
//                 .where((element) =>
//                     element.city == currentLocation &&
//                     element.purpose!.toString().toLowerCase() ==
//                         purpose.toLowerCase())
//                 .toList();
//       } else {
//         newList = allPropertiesModel.value.data == null
//             ? []
//             : allPropertiesModel.value.data!.properties
//                 .where((element) =>
//                     element.type!.toLowerCase() == selectedTab.toLowerCase() &&
//                     element.city == currentLocation &&
//                     element.purpose!.toString().toLowerCase() ==
//                         purpose.toLowerCase())
//                 .toList();
//       }
//     }
//
//     _propertyList.clear();
//     _propertyList.value = newList
//       ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
//     setIsLoading(false);
//
// }
}

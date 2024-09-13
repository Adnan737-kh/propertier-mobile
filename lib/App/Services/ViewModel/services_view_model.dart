import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Services/Model/services_model.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';

class ServicesViewModel extends GetxController {
  TextEditingController searchCOntroller = TextEditingController();
  List<ServicesModel> servciesList = <ServicesModel>[
    ServicesModel(title: Get.context!.local.plumber, icon: Constant.plumber),
    ServicesModel(
        title: Get.context!.local.electrician, icon: Constant.electrician),
    ServicesModel(
        title: Get.context!.local.acTechnician, icon: Constant.acMechanic),
    ServicesModel(title: Get.context!.local.gardener, icon: Constant.gardner),
    ServicesModel(
        title: Get.context!.local.carpanter, icon: Constant.carpanter),
    ServicesModel(title: Get.context!.local.painter, icon: Constant.painter),
  ];

  List<ServicesModel> topSellingList = <ServicesModel>[
    ServicesModel(
        title: 'Architecture Designer', icon: Constant.architactureDesigner),
    ServicesModel(title: 'Handmade 3D Sketches', icon: Constant.sketches),
    ServicesModel(
        title: 'Graphic & Logo Designer', icon: Constant.logoDesigner),
  ];
}

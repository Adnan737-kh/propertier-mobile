import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../App/Services/Model/ServiceDashboardModel.dart';


class AllServicesScreenController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    services = Get.arguments;
  }


  late List<SellingServices> services;




}
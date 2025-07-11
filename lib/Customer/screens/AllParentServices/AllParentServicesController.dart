import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../App/Services/Model/services_model.dart';
import '../../../App/Services/Service/ServicesCore.dart';

class AllParentServicesController extends GetxController {
  ServicesCore servicesCore = ServicesCore();

  Future<List<ParentServicesModel>> getAllParentServices(
      BuildContext context) async {
    return servicesCore.getAllParentServices(context: context);
  }
}

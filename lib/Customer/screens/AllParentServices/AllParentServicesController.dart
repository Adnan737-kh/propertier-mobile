import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../App/Services/Model/services_model.dart';
import '../../../App/Services/Service/ServicesCore.dart';

class AllParentServicesController extends GetxController{




  ServicesCore servicesCore = ServicesCore();

  Future<List<ParentServicesModel>> getAllParentServices(BuildContext context)async{
    return servicesCore.getAllParentServices(context: context);
  }
}
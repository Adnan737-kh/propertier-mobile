import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/ServiceDetail/View/component/service_detail_widget.dart';
import 'package:propertier/App/ServiceDetail/ViewModel/ServiceDetailViewModel.dart';
import 'package:propertier/App/Services/Model/FixedServicesModel.dart';


class ServiceDetail extends GetView<ServiceDetailViewModel>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ServiceAppBar(context, controller.fixedServicesModel),
    );
  }
}
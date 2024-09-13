import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferedServicesViewModel extends GetxController {
  final oSFormKey = GlobalKey<FormState>();
  final TextEditingController serviceController = TextEditingController();

  var services = <String>[
    'PVC Pipes',
    'PEX Pipes',
    'Furnished',
    'Copper Pipes',
    'ABS Pipes',
    'Drainage',
    'Sanitary plumbing',
    'Gas fitting',
    'Laundry Rooms',
    'Mechanical Services',
  ].obs;

  @override
  void onClose() {
    serviceController.dispose();
    super.onClose();
  }
}

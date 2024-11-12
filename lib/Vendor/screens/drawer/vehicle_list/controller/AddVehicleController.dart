import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/Vendor/helpers/api_service.dart';
import 'package:http/http.dart' as http;
import '../../../../../Handlers/permissions_handler.dart';

class AddVehicleController extends GetxController{

  final _formKey = GlobalKey<FormState>();

  // TextEditingControllers for each field
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController registrationNumberController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController fuelTypeController = TextEditingController();
  final TextEditingController transmissionTypeController = TextEditingController();


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

  // Submit method
  void submitForm(BuildContext context, String vendorId) async{

      if(modelController.text == "" || modelController.text == "" || yearController.text == "" || colorController.text == "" || ownerNameController.text == "" || capacityController.text == "" || fuelTypeController.text == "" || transmissionTypeController.text == "" ){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('All field required.')),
        );
        return;
      }

      if(galleryImage.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Images required.')),
        );
        return;
      }

      http.Response response = await ApiService().addVehicle(vendorid: vendorId, make: makeController.text, model: modelController.text, color: colorController.text, name: ownerNameController.text, capacity: capacityController.text, fuelType: fuelTypeController.text, registrationNumber: registrationNumberController.text, year: yearController.text, transmissionType: transmissionTypeController.text, images: galleryImage);

      if(response.statusCode == 201){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vehicle Added.')),
        );
        Get.back();
      }
  }

}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/drawer/EditVendorForm/EditVendorFormController.dart';
import '../../../../Utils/app_text.dart';
import '../../../../constant/colors.dart';
import '../../ServiceForm/model/ServiceFormModel.dart';
import '../../ServiceForm/model/TransportModel.dart';

class EditVendorForm extends GetView<EditVendorFormController>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: controller.data.length,
          itemBuilder: (context, index) {
            final field = controller.data[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(field.id != 18 && field.id != 19)
                    appText(title: field.requirementDetails?.fieldName ?? "", context: context),
                  const SizedBox(height: 8),
                  _buildField(field.requirementDetails!, field.value),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState?.validate() == true) {
            _formKey.currentState?.save();
            final formData = controller.getFormValues();
            print("Form Data: $formData");
            // controller.saveVendorData(formData);
          } else {
            print("Form validation failed.");
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildField(ServiceFormModel field, dynamic value) {
    if(field.id == 19) return SizedBox();
    if(field.id == 18){
      controller.selectedTransportName.value = value;
      controller.formFieldValues[field.fieldName??""] = value;
      // Find the selected transport's details
      final selectedTransport = controller.filteredTransports.firstWhere(
            (transport) => transport.name == value,
        orElse: () => TransportModel(),
      );
      controller.formFieldValues["Transport Id"] = selectedTransport.id;
      return _selectTranspor(field);
    }
    switch (field.fieldType) {
      case 'text':
        if(value != null){
          controller.formFieldValues[field.fieldName ?? ""] = value ?? "";
        }
        return TextFormField(
          decoration: InputDecoration(
            labelText: field.fieldName,
            border: const OutlineInputBorder(),
          ),
          validator: field.isRequired == true
              ? (value) => (value == null || value.isEmpty)
              ? "This field is required"
              : null
              : null,
          onSaved: (v) {
            controller.formFieldValues[field.fieldName ?? ""] = v ?? "";
          },
        );
      case 'number':
        if(value != null){
          controller.formFieldValues[field.fieldName ?? ""] = value ?? "";
        }
        return TextFormField(
          decoration: InputDecoration(
            labelText: field.fieldName,
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: field.isRequired == true
              ? (value) => (value == null || value.isEmpty)
              ? "This field is required"
              : null:null,
          onSaved: (value) {
            controller.formFieldValues[field.fieldName ?? ""] = int.tryParse(value ?? "") ?? 0;
          },
        );
      case 'file':
      case 'image': // Handle image uploads
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () => controller.multiImagePick(field.fieldName ?? ""),
              child: Text("Upload Images for ${field.fieldName}"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.buttonColor
              ),
            ),
            Obx(() {
              final images = controller.formFieldValues[field.fieldName ?? ""] as List<String>? ?? [];
              return
                images.isNotEmpty?Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: images
                      .map((imagePath) => Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(imagePath),
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // InkWell(
                      //   onTap: (){
                      //     images.removeWhere((e) => e== imagePath);
                      //     print(images.length);
                      //   },
                      //     child: Icon(Icons.close))
                    ],
                  ))
                      .toList(),
                ):
                value != null && value.isNotEmpty?
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: value
                    .map<Widget>((imagePath) => Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imagePath,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // InkWell(
                    //   onTap: (){
                    //     images.removeWhere((e) => e== imagePath);
                    //     print(images.length);
                    //   },
                    //     child: Icon(Icons.close))
                  ],
                ))
                    .toList(),
              )
                  :const Text("No images selected.");
            }),
          ],
        );
      default:
        return const SizedBox();
    }
  }

  Widget _selectTranspor(ServiceFormModel field){
    return FutureBuilder(
        future: controller.getAllTransport(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            List<TransportModel> transports = snapshot.data??[];
            controller.filteredTransports = transports;
            return _selectTransportDropdown(field);
          }
          return SizedBox();
        }
    );
  }


  Widget _selectTransportDropdown(ServiceFormModel field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Transport:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),
        Obx(()=> DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          isExpanded: true,
          value: controller.selectedTransportName.value,
          items: controller.filteredTransports.map((transport) {
            return DropdownMenuItem<String>(
              value: transport.name,
              child: Text(transport.name ?? ""),
            );
          }).toList(),
          onChanged: (value) {
            controller.selectedTransportName.value = value;
            controller.formFieldValues[field.fieldName??""] = value;
            // Find the selected transport's details
            final selectedTransport = controller.filteredTransports.firstWhere(
                  (transport) => transport.name == value,
              orElse: () => TransportModel(),
            );
            controller.formFieldValues["Transport Id"] = selectedTransport.id;

            print(controller.formFieldValues.values);

          },
          hint: const Text("Select a transport"),
        )),
        const SizedBox(height: 20),
        Obx(()=> controller.selectedTransportName.value != null?
        Text(
          "Selected Transport: ${controller.selectedTransportName.value}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ):SizedBox()),
      ],
    );
  }
}
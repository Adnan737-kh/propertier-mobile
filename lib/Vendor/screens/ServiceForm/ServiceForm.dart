import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/Vendor/screens/ServiceForm/ServiceFormController.dart';
import 'package:propertier/Vendor/screens/ServiceForm/model/ServiceFormModel.dart';
import 'package:propertier/Vendor/screens/ServiceForm/model/TransportModel.dart';
import 'package:propertier/constant/colors.dart';


class ServiceForm extends GetView<ServiceFormController> {
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
      body: Column(
        children: [
          Expanded(child: FutureBuilder<List<ServiceFormModel>>(
            future: controller.getRequirements(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.done) {
                final fields = snapshot.data ?? [];
                if (fields.isEmpty) {
                  return const Center(
                    child: Text("No Further Detail Required."),
                  );
                }
                return Form(
                  key: _formKey,
                  child: ListView.builder(
                    itemCount: fields.length,
                    itemBuilder: (context, index) {
                      final field = fields[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(field.id != 18 && field.id != 19)
                              appText(title: field.fieldName ?? "", context: context),
                            const SizedBox(height: 8),
                            _buildField(field),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Obx(()=> textButton(context: context, title: controller.isLoading.value?"Loading...":"Continue", onClick: (){
              if (_formKey.currentState?.validate() == true) {
                _formKey.currentState?.save();
                final formData = controller.getFormValues();
                print("Form Data: $formData"); // Handle form submission here
                // controller.saveVendorData(formData);
              } else {
                print("Form validation failed.");
              }
            })),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (_formKey.currentState?.validate() == true) {
      //       _formKey.currentState?.save();
      //       final formData = controller.getFormValues();
      //       print("Form Data: $formData"); // Handle form submission here
      //       // controller.saveVendorData(formData);
      //     } else {
      //       print("Form validation failed.");
      //     }
      //   },
      //   child: const Icon(Icons.save),
      // ),
    );
  }

  Widget _buildField(ServiceFormModel field) {
    if(field.id == 19) return SizedBox();
    if(field.id == 18) return _selectTranspor(field);
    switch (field.fieldType) {
      case 'text':
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
          onSaved: (value) {
            controller.formFieldValues[field.fieldName ?? ""] = value ?? "";
          },
        );
      case 'number':
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
              return images.isEmpty
                  ? const Text("No images selected.")
                  : Wrap(
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
              );
            }),
          ],
        );
      case 'multiple_select':
      // Safely handle the value as a String
        final dynamic currentValue = controller.formFieldValues[field.fieldName ?? ""];
        final selectedValue = currentValue is String ? currentValue.obs : "".obs;

        return Obx(()=> DropdownButton<String>(
          isExpanded: true,
          value: selectedValue.isNotEmpty ? selectedValue.value : null,
          hint: Text("Select ${field.fieldName}"),
          items: field.options?.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              // Ensure only a single String is stored
              controller.formFieldValues[field.fieldName ?? ""] = value;
              selectedValue.value = value;
            }
          },
        ));


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






// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:propertier/Utils/app_text.dart';
// import 'package:propertier/Vendor/screens/ServiceForm/ServiceFormController.dart';
// import 'package:propertier/Vendor/screens/ServiceForm/model/ServiceFormModel.dart';
// import 'package:propertier/constant/colors.dart';
//
//
// class ServiceForm extends GetView<ServiceFormController>{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(onPressed: (){
//           Get.back();
//         }, icon: Icon(Icons.arrow_back,color: AppColor.blackColor,)),
//       ),
//       body: FutureBuilder(future: controller.getRequirements(),
//           builder: (context, snapshot){
//             if(snapshot.connectionState == ConnectionState.waiting){
//               return Center(child: CircularProgressIndicator());
//             }
//             if(snapshot.connectionState == ConnectionState.done){
//               List<ServiceFormModel> fields = snapshot.data??[];
//               if(fields.isEmpty){
//                 return Center(
//                   child: Text("No Further Detail Required."),
//                 );
//               }
//               return ListView.builder(
//                 itemCount: fields.length,
//                   itemBuilder: (context, index){
//                     ServiceFormModel field = fields[index];
//                     return Column(
//                       children: [
//                         appText(title: field.fieldName??"", context: context),
//                       ],
//                     );
//                   }
//               );
//             }
//             return SizedBox();
//           }
//       ),
//     );
//   }
// }
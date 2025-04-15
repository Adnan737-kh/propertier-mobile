// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:propertier/Utils/app_text.dart';
// import 'package:propertier/Utils/text_botton.dart';
// import 'package:propertier/Vendor/screens/ServiceForm/ServiceFormController.dart';
// import 'package:propertier/Vendor/screens/ServiceForm/model/ServiceFormModel.dart';
// import 'package:propertier/Vendor/screens/ServiceForm/model/TransportModel.dart';
// import 'package:propertier/constant/colors.dart';
//
// class ServiceForm extends GetView<ServiceFormController> {
//   final _formKey = GlobalKey<FormState>();
//
//   ServiceForm({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: AppColor.blackColor,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//               child: FutureBuilder<List<ServiceFormModel>>(
//             future: controller.getRequirements(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (snapshot.connectionState == ConnectionState.done) {
//                 final fields = snapshot.data ?? [];
//                 if (fields.isEmpty) {
//                   return const Center(
//                     child: Text("No Further Detail Required."),
//                   );
//                 }
//                 return Form(
//                   key: _formKey,
//                   child: ListView.builder(
//                     itemCount: fields.length,
//                     itemBuilder: (context, index) {
//                       final field = fields[index];
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (field.id != 18 && field.id != 19)
//                               appText(
//                                   title: field.fieldName ?? "",
//                                   context: context),
//                             const SizedBox(height: 8),
//                             _buildField(field),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }
//               return const SizedBox();
//             },
//           )),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10,
//                 vertical: 10),
//             child: Obx(() => textButton(
//                 context: context,
//                 title: controller.isLoading.value ? "Loading..."
//                     : "Continue",
//                 onClick: () {
//                   if (_formKey.currentState?.validate() == true) {
//                     _formKey.currentState?.save();
//                     final formData = controller.getFormValues();
//                     if (kDebugMode) {
//                       print("Form Data: $formData");
//                     } // Handle form submission here
//                     controller.saveVendorData(formData);
//                   } else {
//                     if (kDebugMode) {
//                       print("Form validation failed.");
//                     }
//                   }
//                 })),
//           )
//         ],
//       ),
//
//     );
//   }
//
//   Widget _buildField(ServiceFormModel field) {
//     if (field.id == 19) return const SizedBox();
//     if (field.id == 18) return _selectTransport(field);
//     switch (field.fieldType) {
//       case 'text':
//         return TextFormField(
//           decoration: InputDecoration(
//             labelText: field.fieldName,
//             border: const OutlineInputBorder(),
//           ),
//           validator: field.isRequired == true
//               ? (value) => (value == null || value.isEmpty)
//                   ? "This field is required"
//                   : null
//               : null,
//           onSaved: (value) {
//             controller.formFieldValues[field.fieldName ?? ""] = value ?? "";
//           },
//         );
//       case 'number':
//         return TextFormField(
//           decoration: InputDecoration(
//             labelText: field.fieldName,
//             border: const OutlineInputBorder(),
//           ),
//           keyboardType: TextInputType.number,
//           validator: field.isRequired == true
//               ? (value) => (value == null || value.isEmpty)
//                   ? "This field is required"
//                   : null
//               : null,
//           onSaved: (value) {
//             controller.formFieldValues[field.fieldName ?? ""] =
//                 int.tryParse(value ?? "") ?? 0;
//           },
//         );
//       case 'file':
//       case 'image': // Handle image uploads
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ElevatedButton(
//               onPressed: () => controller.multiImagePick(field.fieldName ?? ""),
//               style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColor.buttonColor),
//               child: Text("Upload Images for ${field.fieldName}"),
//             ),
//             Obx(() {
//               final images = controller.formFieldValues[field.fieldName ?? ""]
//                       as List<String>? ??
//                   [];
//               return images.isEmpty
//                   ? const Text("No images selected.")
//                   : Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: images
//                           .map((imagePath) => Stack(
//                                 alignment: Alignment.topRight,
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(8),
//                                     child: Image.file(
//                                       File(imagePath),
//                                       width: 80,
//                                       height: 80,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   // InkWell(
//                                   //   onTap: (){
//                                   //     images.removeWhere((e) => e== imagePath);
//                                   //     print(images.length);
//                                   //   },
//                                   //     child: Icon(Icons.close))
//                                 ],
//                               ))
//                           .toList(),
//                     );
//             }),
//           ],
//         );
//       case 'multiple_select':
//         // Safely handle the value as a String
//         final dynamic currentValue =
//             controller.formFieldValues[field.fieldName ?? ""];
//         final selectedValue =
//             currentValue is String ? currentValue.obs : "".obs;
//
//         return Obx(() => DropdownButton<String>(
//               isExpanded: true,
//               value: selectedValue.isNotEmpty ? selectedValue.value : null,
//               hint: Text("Select ${field.fieldName}"),
//               items: field.options?.map((option) {
//                 return DropdownMenuItem<String>(
//                   value: option,
//                   child: Text(option),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 if (value != null) {
//                   // Ensure only a single String is stored
//                   controller.formFieldValues[field.fieldName ?? ""] = value;
//                   selectedValue.value = value;
//                 }
//               },
//             ));
//
//       default:
//         return const SizedBox();
//     }
//   }
//
//   Widget _selectTransport(ServiceFormModel field) {
//     return FutureBuilder(
//         future: controller.getAllTransport(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             List<TransportModel> transports = snapshot.data ?? [];
//             controller.filteredTransports = transports;
//             return _selectTransportDropdown(field);
//           }
//           return const SizedBox();
//         });
//   }
//
//   Widget _selectTransportDropdown(ServiceFormModel field) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Select Transport:",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 20),
//         Obx(() => DropdownButtonFormField<String>(
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//               isExpanded: true,
//               value: controller.selectedTransportName.value,
//               items: controller.filteredTransports.map((transport) {
//                 return DropdownMenuItem<String>(
//                   value: transport.name,
//                   child: Text(transport.name ?? ""),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 controller.selectedTransportName.value = value;
//                 controller.formFieldValues[field.fieldName ?? ""] = value;
//                 // Find the selected transport's details
//                 final selectedTransport =
//                     controller.filteredTransports.firstWhere(
//                   (transport) => transport.name == value,
//                   orElse: () => TransportModel(),
//                 );
//                 controller.formFieldValues["Transport Id"] =
//                     selectedTransport.id;
//
//                 if (kDebugMode) {
//                   print(controller.formFieldValues.values);
//                 }
//               },
//               hint: const Text("Select a transport"),
//             )),
//         const SizedBox(height: 20),
//         Obx(() => controller.selectedTransportName.value != null
//             ? Text(
//                 "Selected Transport: ${controller.selectedTransportName.value}",
//                 style:
//                     const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               )
//             : const SizedBox()),
//       ],
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/text_botton.dart';
import 'ServiceFormController.dart';

class ServiceForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formFieldValues = {};
  final ServiceFormController controller = Get.put(ServiceFormController());

  ServiceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Service Info"),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (controller.category == 'transport') _buildTransportForm(),
            if (controller.category == 'water_provider')_buildWaterProviderForm(),
            if (controller.category == 'domestic_and_professional') _buildDomesticAndProfessional(),
            if (controller.category == 'architect') _buildArchitectureForm(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() => textButton(
                    context: context,
                    title:
                        controller.isLoading.value ? "Loading..." : "Continue",
                    onClick: () {
                      if (_formKey.currentState?.validate() == true) {
                        _formKey.currentState?.save();
                        final allFormValues = {
                          ...formFieldValues,
                          ...controller.formFieldValues,
                        };
                        controller.uploadServicesForm(allFormValues);
                      } else {
                        if (kDebugMode) {
                          print("Form validation failed.");
                        }
                      }
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransportForm() {
    return Expanded(
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            _buildField("Vehicle Type", "multiple_select",
                fieldKey: "vehicle_type", isRequired: true, isNumber: true, dropdownOptions: [
                {'title': 'Bike', 'value': 'bike'},
                {'title': 'Truck', 'value': 'truck'},
              ],),
            const SizedBox(height: 16),
            _buildField("Vehicle Registration Number", "text",
                fieldKey: "vehicle_registration_number",
                isRequired: true,
                isNumber: false),
            const SizedBox(height: 16),
            _buildField("Max Load capacity", "text",
                fieldKey: "max_load_capacity",
                isRequired: true,
                isNumber: true),
            const SizedBox(height: 16),
            _buildField("Driving License Front", "image",
                fieldKey: "driving_license_front",
                isRequired: true,
                isNumber: false),
            const SizedBox(height: 16),
            _buildField("Driving License Back", "image",
                fieldKey: "driving_license_back",
                isRequired: true,
                isNumber: false,
            ),
            const SizedBox(height: 16),
            _buildField("Driver Selfie", "image",
                fieldKey: "driver_selfie", isRequired: true, isNumber: false),
            const SizedBox(height: 16),
            _buildField("Vehicle Front", "image",
                fieldKey: "vehicle_front", isRequired: true, isNumber: false),
            const SizedBox(height: 16),
            _buildField("Vehicle Back", "image",
                fieldKey: "vehicle_back", isRequired: true, isNumber: false),
            const SizedBox(height: 16),
            _buildField("Vehicle Left", "image",
                fieldKey: "vehicle_left", isRequired: true, isNumber: false),
            const SizedBox(height: 16),
            _buildField("Vehicle Right", "image",
                fieldKey: "vehicle_right", isRequired: true, isNumber: false),
            const SizedBox(height: 16),
            _buildField("Vehicle Interior", "image",
                fieldKey: "vehicle_interior",
                isRequired: true,
                isNumber: false),
            const SizedBox(height: 16),
            _buildField("Vehicle Trunk", "image",
                fieldKey: "vehicle_trunk", isRequired: true, isNumber: false),
            const SizedBox(height: 16),
            _buildField("Vehicle Registration", "image",
                fieldKey: "vehicle_registration",
                isRequired: true,
                isNumber: false),
            const SizedBox(height: 16),
            _buildField("Insurance Document", "image",
                fieldKey: "insurance_document",
                isRequired: true,
                isNumber: false),
            const SizedBox(height: 16),
            _buildField("Fitness Certificate", "image",
                fieldKey: "fitness_certificate",
                isRequired: true,
                isNumber: false),
          ],
        ),
      ),
    );
  }

  Widget _buildDomesticAndProfessional() {
    return Expanded(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildField("Years of Experience", "text",
                fieldKey: "work_experience_years",
                isRequired: true,
                isNumber: false),
            const SizedBox(height: 16),
            _buildField("Upload Experience Files", "image",
                fieldKey: "work_experience_files",
                isRequired: true,
                isNumber: false),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterProviderForm() {
    return Expanded(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildField(
              "Water Type",
              "multiple_select",
              fieldKey: "water_type",
              isRequired: true,
              isNumber: false,
              dropdownOptions: [
                {'title': 'Normal', 'value': 'normal'},
                {'title': 'Drinking', 'value': 'drinking'},
                {'title': 'Both', 'value': 'both'},
              ],
            ),
            const SizedBox(height: 16),
            _buildField("Delivery Radius KM", "text",
                fieldKey: "delivery_radius_km",
                isRequired: true,
                isNumber: false),
            _buildField("Water Quality Certificate", "image",
                fieldKey: "water_quality_certificate",
                isRequired: true,
                isNumber: false),
          ],
        ),
      ),
    );
  }
  Widget _buildArchitectureForm() {
    return Expanded(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildField(
              "Portfolio Url",
              "text",
              fieldKey: "portfolio_link",
              isRequired: true,
              isNumber: false,
            ),
            const SizedBox(height: 16),
            _buildField("Certifications", "image",
                fieldKey: "certifications",
                isRequired: true,
                isNumber: false),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String fieldType,
      {required String fieldKey,
      bool isRequired = false,
      required bool isNumber,
      List<Map<String, String>>? dropdownOptions}) {
    switch (fieldType) {
      case 'text':
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            keyboardType:
                isNumber == false ? TextInputType.text : TextInputType.number,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            validator: isRequired
                ? (value) => (value == null || value.isEmpty)
                    ? "This field is required"
                    : null
                : null,
            onSaved: (value) {
              formFieldValues[fieldKey] = value ?? "";
            },
          ),
        );

      case 'image':
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => controller.multiImagePick(fieldKey),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(label),
              ),
              const SizedBox(height: 8),
              Obx(() {
                final images =
                    controller.formFieldValues[fieldKey] as List<String>? ?? [];
                return images.isEmpty
                    ? const Text("No files selected.")
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
                                  ],
                                ))
                            .toList(),
                      );
              }),
            ],
          ),
        );
      case 'multiple_select':
        final RxString selectedValue =
            (controller.formFieldValues[fieldKey] ?? "").toString().obs;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Obx(() => DropdownButton<String>(
                    isExpanded: true,
                    value:
                        selectedValue.isNotEmpty ? selectedValue.value : null,
                    hint: Text("Select $label"),
                    items: dropdownOptions?.map((option) {
                      return DropdownMenuItem<String>(
                        value: option['value'],
                        child: Text(option['title']!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.formFieldValues[fieldKey] = value;
                        selectedValue.value = value;
                      }
                    },
                  )),
            ],
          ),
        );

      default:
        return const SizedBox();
    }
  }
}

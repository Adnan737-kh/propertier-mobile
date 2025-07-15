import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/extensions/localization_extension.dart';
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
        title: Text(context.local.upload_service_info),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (controller.category == 'transport') _buildTransportForm(context),
            if (controller.category == 'water_provider')_buildWaterProviderForm(context),
            if (controller.category == 'domestic_and_professional') _buildDomesticAndProfessional(context),
            if (controller.category == 'architect') _buildArchitectureForm(context),

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

  Widget _buildTransportForm(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            _buildField(context.local.vehicle_type, "multiple_select",
                fieldKey: "vehicle_type", isRequired: true, isNumber: true,
              dropdownOptions: [
                {'title': 'Bike', 'value': 'bike'},
                {'title': 'Truck', 'value': 'truck'},
              ],),
            const SizedBox(height: 16),
            _buildField(context.local.vehicle_registration_number, "text",
                fieldKey: "vehicle_registration_number",
                isRequired: true,
                isNumber: false),
            const SizedBox(height: 16),
            _buildField(context.local.max_load_capacity, "text",
                fieldKey: "max_load_capacity",
                isRequired: true,
                isNumber: true),
            const SizedBox(height: 16),
            _buildField(context.local.driving_license_front, "image",
                fieldKey: "driving_license_front",
                isRequired: true,
                isNumber: false),
            const SizedBox(height: 16),
            _buildField(context.local.driving_License_back, "image",
                fieldKey: "driving_license_back",
                isRequired: true,
                isNumber: false,
            ),
            const SizedBox(height: 16),
            _buildField(context.local.driver_selfie, "image",
                fieldKey: "driver_selfie", isRequired: true, isNumber: false),
            const SizedBox(height: 16),
            _buildField(context.local.vehicle_front, "image",
                fieldKey: "vehicle_front", isRequired: true, isNumber: false),
            const SizedBox(height: 16),
            _buildField(context.local.vehicle_back, "image",
                fieldKey: "vehicle_back", isRequired: true, isNumber: false),
            const SizedBox(height: 16),
            _buildField(context.local.vehicle_left, "image",
                fieldKey: "vehicle_left", isRequired: true, isNumber: false),
            const SizedBox(height: 16),
            _buildField(context.local.vehicle_right, "image",
                fieldKey: "vehicle_right", isRequired: true, isNumber: false),
            const SizedBox(height: 16),
            _buildField("Vehicle Interior", "image",
                fieldKey: "vehicle_interior",
                isRequired: true,
                isNumber: false),
            const SizedBox(height: 16),
            _buildField(context.local.vehicle_trunk, "image",
                fieldKey: "vehicle_trunk", isRequired: true, isNumber: false),
            const SizedBox(height: 16),
            _buildField(context.local.vehicle_registration, "image",
                fieldKey: "vehicle_registration",
                isRequired: true,
                isNumber: false),
            const SizedBox(height: 16),
            _buildField(context.local.insurance_document, "image",
                fieldKey: "insurance_document",
                isRequired: true,
                isNumber: false),
            const SizedBox(height: 16),
            _buildField(context.local.fitness_certificate, "image",
                fieldKey: "fitness_certificate",
                isRequired: true,
                isNumber: false),
          ],
        ),
      ),
    );
  }
  Widget _buildDomesticAndProfessional(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildField(context.local.years_of_experience, "text",
                fieldKey: "work_experience_years",
                isRequired: true,
                isNumber: false),
            const SizedBox(height: 16),
            _buildField(context.local.upload_experience_files, "image",
                fieldKey: "work_experience_files",
                isRequired: true,
                isNumber: false),
          ],
        ),
      ),
    );
  }
  Widget _buildWaterProviderForm(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildField(
              context.local.water_type,
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
            _buildField(context.local.water_quality_certificate, "image",
                fieldKey: "water_quality_certificate",
                isRequired: true,
                isNumber: false),
          ],
        ),
      ),
    );
  }
  Widget _buildArchitectureForm(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildField(
              context.local.portfolio_url,
              "text",
              fieldKey: "portfolio_link",
              isRequired: true,
              isNumber: false,
            ),
            const SizedBox(height: 16),
            _buildField(context.local.certifications, "image",
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
      List<Map<String, String>>? dropdownOptions
      }) {
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
                    value: selectedValue.isNotEmpty ? selectedValue.value : null,
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


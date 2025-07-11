import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/add_post/Model/add_post_model.dart';

import 'controller/dateandtime_picker_controller.dart';

class CustomDataTimePicker extends StatelessWidget {
  final void Function(List<WeeklyAvailabilityModel>) onSave;

  const CustomDataTimePicker({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final DateAndTimePickerController controller =
        Get.put(DateAndTimePickerController());

    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              ...controller.days.map((day) {
                final isSelected = controller.availability.containsKey(day);
                return Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(day.toUpperCase()),
                    trailing: Switch(
                      value: isSelected,
                      onChanged: (_) => controller.toggleDay(day),
                    ),
                    subtitle: isSelected
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () => selectTime(
                                      context, day, 'start_time', controller),
                                  child: Text(
                                      'Start: ${controller.formatTime(controller.availability[day]!['start_time']!)}'),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () => selectTime(
                                      context, day, 'end_time', controller),
                                  child: Text(
                                      'End: ${controller.formatTime(controller.availability[day]!['end_time']!)}'),
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
                );
              }),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (kDebugMode) {
                    print({
                      'schedule_type': 'recurring',
                      'timezone': 'Asia/Karachi',
                      'recurring_availability': controller.selectedModels
                          .map((e) => e.toJson())
                          .toList(),
                    });
                  }
                  onSave(controller.selectedModels);
                },
                child: const Text('Save Availability'),
              ),
            ],
          ),
        ));
  }

  Future<void> selectTime(BuildContext context, String day, String key,
      DateAndTimePickerController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: controller.availability[day]?[key] ??
          const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) {
      controller.setTime(day, key, picked);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/add_post/Model/add_post_model.dart';

class DateAndTimePickerController extends GetxController {
  final List<String> days = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
  final availability = <String, Map<String, TimeOfDay>>{}.obs;

  void toggleDay(String day) {
    if (availability.containsKey(day)) {
      availability.remove(day);
    } else {
      availability[day] = {
        'start_time': const TimeOfDay(hour: 9, minute: 0),
        'end_time': const TimeOfDay(hour: 17, minute: 0),
      };
    }
    availability.refresh(); // Force update
  }

  void setTime(String day, String key, TimeOfDay time) {
    availability[day]?[key] = time;
    availability.refresh();
  }

  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(dt);
  }

  List<WeeklyAvailabilityModel> get selectedModels {
    return availability.entries.map((entry) {
      return WeeklyAvailabilityModel.fromMap({
        'day': entry.key,
        'start_time': formatTime(entry.value['start_time']!),
        'end_time': formatTime(entry.value['end_time']!),
      });
    }).toList();
  }
}

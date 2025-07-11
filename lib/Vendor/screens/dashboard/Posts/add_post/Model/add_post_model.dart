import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

class AddPostModel {
  final String title;
  final String description;
  final List<File> images;
  final String youtubeVideoUrl;
  final Rx<File?> shortVideo;
  final String pricingType;
  final String price;
  final String visitingCharges;
  final String serviceRadius;
  // Domestic And Professional Specific Fields
  final bool? toolsProvided;
  final List<WeeklyAvailabilityModel>? availability;
  // Water Provider Specific Fields
  final String? waterType;
  final String? deliveryType;

  AddPostModel({
    required this.description,
    required this.title,
    required this.images,
    required this.youtubeVideoUrl,
    required this.shortVideo,
    required this.pricingType,
    required this.price,
    required this.visitingCharges,
    required this.serviceRadius,
    this.availability,
    this.toolsProvided,
    this.waterType,
    this.deliveryType,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'images': images, // to be handled in multipart
      'youtube_video_url': youtubeVideoUrl,
      'short_video': shortVideo.value?.path, // for reference
      'pricing_model': pricingType,
      'rate': price,
      'visiting_charges': visitingCharges,
      'service_radius': serviceRadius,
      'tools_provided': toolsProvided,
      'water_type': toolsProvided,
      'delivery_type': deliveryType,
      'availability': availability?.map((a) => a.toJson()).toList(),
    };
  }
}

class WeeklyAvailabilityModel {
  final String day;
  final String startTime;
  final String endTime;

  WeeklyAvailabilityModel({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory WeeklyAvailabilityModel.fromMap(Map<String, String> map) {
    return WeeklyAvailabilityModel(
      day: map['day']!,
      startTime: map['start_time']!,
      endTime: map['end_time']!,
    );
  }

  Map<String, dynamic> toJson() => {
        'day': day,
        'start_time': startTime,
        'end_time': endTime,
      };
}

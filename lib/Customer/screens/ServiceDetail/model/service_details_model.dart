class ServiceDetailsModel {
  final int? id;
  final String? title;
  final String? description;
  final String? serviceType;
  final List<String>? images;
  final Vendor? vendor;
  final Service? service;
  final List<ImageUrl>? imageUrls;
  final String? youtubeVideoUrl;
  final String? shortVideo;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? pricingModel;
  final String? rate;
  final String? visitingCharges;
  final bool? toolsProvided;
  final AvailabilitySchedule? availabilitySchedule;
  final int? serviceRadius;

  ServiceDetailsModel({
    this.id,
    this.title,
    this.description,
    this.serviceType,
    this.images,
    this.vendor,
    this.service,
    this.imageUrls,
    this.youtubeVideoUrl,
    this.shortVideo,
    this.createdAt,
    this.updatedAt,
    this.pricingModel,
    this.rate,
    this.visitingCharges,
    this.toolsProvided,
    this.availabilitySchedule,
    this.serviceRadius,
  });


  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) {
    return ServiceDetailsModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      serviceType: json['service_type'],
      images: List<String>.from(json['images']),
      vendor: Vendor.fromJson(json['vendor']),
      service: Service.fromJson(json['service']),
      imageUrls: (json['image_urls'] as List)
          .map((e) => ImageUrl.fromJson(e))
          .toList(),
      youtubeVideoUrl: json['youtube_video_url'],
      shortVideo: json['short_video'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      pricingModel: json['pricing_model'],
      rate: json['rate'],
      visitingCharges: json['visiting_charges'],
      toolsProvided: json['tools_provided'],
      availabilitySchedule:
      AvailabilitySchedule.fromJson(json['availability_schedule']),
      serviceRadius: json['service_radius'],
    );
  }
}

class Vendor {
  final int id;
  final String fullName;
  final String email;
  final String profilePicture;
  final String? phoneNumber;

  Vendor({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profilePicture,
    this.phoneNumber,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
      phoneNumber: json['phone_number'],
    );
  }
}

class Service {
  final int id;
  final String title;
  final String description;
  final String? image;

  Service({
    required this.id,
    required this.title,
    required this.description,
    this.image,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}

class ImageUrl {
  final String image;
  final DateTime createdAt;

  ImageUrl({
    required this.image,
    required this.createdAt,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) {
    return ImageUrl(
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class AvailabilitySchedule {
  final String scheduleType;
  final String timezone;
  final List<RecurringAvailability> recurringAvailability;
  final List<dynamic> specificDateAvailability;

  AvailabilitySchedule({
    required this.scheduleType,
    required this.timezone,
    required this.recurringAvailability,
    required this.specificDateAvailability,
  });

  factory AvailabilitySchedule.fromJson(Map<String, dynamic> json) {
    return AvailabilitySchedule(
      scheduleType: json['schedule_type'],
      timezone: json['timezone'],
      recurringAvailability: (json['recurring_availability'] as List)
          .map((e) => RecurringAvailability.fromJson(e))
          .toList(),
      specificDateAvailability: json['specific_date_availability'],
    );
  }
}

class RecurringAvailability {
  final String day;
  final String startTime;
  final String endTime;

  RecurringAvailability({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory RecurringAvailability.fromJson(Map<String, dynamic> json) {
    return RecurringAvailability(
      day: json['day'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}

class AllPropertiesModel {
  final List<Property>? properties;

  AllPropertiesModel({this.properties});

  factory AllPropertiesModel.fromJson(Map<String, dynamic> json) {
    return AllPropertiesModel(
      properties: (json['results'] as List)
          .map((item) => Property.fromJson(item))
          .toList(),
    );
  }
}

class Property {
  final int id;
  final Agent agent;
  final bool isFeatured;
  final String title;
  final String price;
  final String purpose;
  final String type;
  final String? imageUrl;
  final int bedroom;
  final int bathroom;
  final String city;
  final String slug;
  final String address;
  final double area;
  final String description;
  final String? video;
  final String? floorPlan;
  final double? locationLatitude;
  final double? locationLongitude;
  final String? nearby;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int status;
  final String? shortVideo;
  final int likes;
  final int floor;
  final String areaUnit;
  final String areaType;

  Property({
    required this.id,
    required this.agent,
    required this.isFeatured,
    required this.title,
    required this.price,
    required this.purpose,
    required this.type,
    this.imageUrl,
    required this.bedroom,
    required this.bathroom,
    required this.city,
    required this.slug,
    required this.address,
    required this.area,
    required this.description,
    this.video,
    this.floorPlan,
    this.locationLatitude,
    this.locationLongitude,
    this.nearby,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.shortVideo,
    required this.likes,
    required this.floor,
    required this.areaUnit,
    required this.areaType,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] ?? 0,
      agent: Agent.fromJson(json['agent'] ?? {}),
      isFeatured: json['is_featured'] ?? false,
      title: json['title'] ?? '',
      price: json['price'] ?? '',
      purpose: json['purpose'] ?? '',
      type: json['type'] ?? '',
      imageUrl: json['image'],
      bedroom: json['bedroom'] ?? 0,
      bathroom: json['bathroom'] ?? 0,
      city: json['city'] ?? '',
      slug: json['slug'] ?? '',
      address: json['address'] ?? '',
      area: json['area']?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      video: json['video'],
      floorPlan: json['floor_plan'],
      locationLatitude: json['location_latitude']?.toDouble(),
      locationLongitude: json['location_longitude']?.toDouble(),
      nearby: json['nearby'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      status: json['status'] ?? 0,
      shortVideo: json['short_video'],
      likes: json['likes'] ?? 0,
      floor: json['floor'] ?? 0,
      areaUnit: json['area_unit'] ?? '',
      areaType: json['area_type'] ?? '',
    );
  }
}

class Agent {
  final int id;
  final String fullName;
  final String phoneNumberCountryCode;
  final String phoneNumber;

  Agent({
    required this.id,
    required this.fullName,
    required this.phoneNumberCountryCode,
    required this.phoneNumber,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      phoneNumberCountryCode: json['phone_number_country_code'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}

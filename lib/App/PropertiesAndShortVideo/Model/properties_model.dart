class PropertyModel {
  final int? id;
  final int? agentId;
  final String? agentFullName;
  final String? agentPhoneNumberCountryCode;
  final String? agentPhoneNumber;
  final bool? isFeatured;
  final String? title;
  final double? price;
  final String? purpose;
  final String? type;
  final String? image;
  final int? bedroom;
  final int? bathroom;
  final String? city;
  final String? slug;
  final String? address;
  final double? area;
  final String? description;
  final String? video;
  final String? floorPlan;
  final double? locationLatitude;
  final double? locationLongitude;
  final String? nearby;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? status;
  final String? shortVideo;
  final int? likes;
  final int? floor;
  final String? areaUnit;
  final String? areaType;

  PropertyModel({
    this.id,
    this.agentId,
    this.agentFullName,
    this.agentPhoneNumberCountryCode,
    this.agentPhoneNumber,
    this.isFeatured,
    this.title,
    this.price,
    this.purpose,
    this.type,
    this.image,
    this.bedroom,
    this.bathroom,
    this.city,
    this.slug,
    this.address,
    this.area,
    this.description,
    this.video,
    this.floorPlan,
    this.locationLatitude,
    this.locationLongitude,
    this.nearby,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.shortVideo,
    this.likes,
    this.floor,
    this.areaUnit,
    this.areaType,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      agentId: json['agent']['id'],
      agentFullName: json['agent']['full_name'],
      agentPhoneNumberCountryCode: json['agent']['phone_number_country_code'] ?? '',
      agentPhoneNumber: json['agent']['phone_number'],
      isFeatured: json['is_featured'],
      title: json['title'],
      price: json['price']?.toDouble(),
      purpose: json['purpose'],
      type: json['type'],
      image: json['image'],
      bedroom: json['bedroom'],
      bathroom: json['bathroom'],
      city: json['city'],
      slug: json['slug'],
      address: json['address'],
      area: json['area']?.toDouble(),
      description: json['description'],
      video: json['video'],
      floorPlan: json['floor_plan'],
      locationLatitude: json['location_latitude']?.toDouble(),
      locationLongitude: json['location_longitude']?.toDouble(),
      nearby: json['nearby'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      status: json['status'],
      shortVideo: json['short_video'],
      likes: json['likes'],
      floor: json['floor'],
      areaUnit: json['area_unit'],
      areaType: json['area_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'agent': {
        'id': agentId,
        'full_name': agentFullName,
        'phone_number_country_code': agentPhoneNumberCountryCode,
        'phone_number': agentPhoneNumber,
      },
      'is_featured': isFeatured,
      'title': title,
      'price': price,
      'purpose': purpose,
      'type': type,
      'image': image,
      'bedroom': bedroom,
      'bathroom': bathroom,
      'city': city,
      'slug': slug,
      'address': address,
      'area': area,
      'description': description,
      'video': video,
      'floor_plan': floorPlan,
      'location_latitude': locationLatitude,
      'location_longitude': locationLongitude,
      'nearby': nearby,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'status': status,
      'short_video': shortVideo,
      'likes': likes,
      'floor': floor,
      'area_unit': areaUnit,
      'area_type': areaType,
    };
  }
}

class Property {
  Property({
    this.id,
    this.agent,
    this.title,
    this.slug,
    this.price,
    this.featured,
    this.purpose,
    this.type,
    this.image,
    this.bedroom,
    this.bathroom,
    this.city,
    this.citySlug,
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

  final int? id;
  final Agent? agent;
  final String? title;
  final String? slug;
  final String? price;
  final dynamic featured;
  final String? purpose;
  final String? type;
  final String? image;
  final int? bedroom;
  final int? bathroom;
  final String? city;
  final String? citySlug;
  final String? address;
  final int? area;
  final String? description;
  final String? video;
  final dynamic floorPlan;
  final dynamic locationLatitude;
  final dynamic locationLongitude;
  final String? nearby;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? status;
  final String? shortVideo;
  final int? likes;
  final int? floor;
  final String? areaUnit;
  final String? areaType;

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json["id"],
      agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
      title: json["title"],
      slug: json["slug"],
      price: json["price"],
      featured: json["featured"],
      purpose: json["purpose"],
      type: json["type"],
      image: json["image"],
      bedroom: json["bedroom"],
      bathroom: json["bathroom"],
      city: json["city"],
      citySlug: json["city_slug"],
      address: json["address"],
      area: json["area"],
      description: json["description"],
      video: json["video"],
      floorPlan: json["floor_plan"],
      locationLatitude: json["location_latitude"],
      locationLongitude: json["location_longitude"],
      nearby: json["nearby"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      status: json["status"],
      shortVideo: json["short_video"],
      likes: json["likes"],
      floor: json["floor"],
      areaUnit: json["area_unit"],
      areaType: json["area_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "agent": agent?.toJson(),
        "title": title,
        "slug": slug,
        "price": price,
        "featured": featured,
        "purpose": purpose,
        "type": type,
        "image": image,
        "bedroom": bedroom,
        "bathroom": bathroom,
        "city": city,
        "city_slug": citySlug,
        "address": address,
        "area": area,
        "description": description,
        "video": video,
        "floor_plan": floorPlan,
        "location_latitude": locationLatitude,
        "location_longitude": locationLongitude,
        "nearby": nearby,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "short_video": shortVideo,
        "likes": likes,
        "floor": floor,
        "area_unit": areaUnit,
        "area_type": areaType,
      };
}

class Agent {
  Agent({
    required this.id,
    required this.name,
    required this.phoneNumberCountryCode,
    required this.phoneNumber,
  });

  final int? id;
  final String? name;
  final String? phoneNumberCountryCode;
  final String? phoneNumber;

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      id: json["id"],
      name: json["full_name"],
      phoneNumberCountryCode: json["phone_number_country_code"],
      phoneNumber: json["phone_number"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": name,
        "phone_number_country_code": phoneNumberCountryCode,
        "phone_number": phoneNumber,
      };
}

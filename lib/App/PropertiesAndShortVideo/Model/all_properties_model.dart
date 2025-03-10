// class AllPropertiesModel {
//   AllPropertiesModel({
//     this.data,
//     this.status,
//   });
//
//   final Data? data;
//   final int? status;
//
//   factory AllPropertiesModel.fromJson(Map<String, dynamic> json) {
//     return AllPropertiesModel(
//       data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       status: json["status"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "data": data?.toJson(),
//         "status": status,
//       };
// }
//
// class Data {
//   Data({
//     required this.cities,
//     required this.properties,
//     required this.types,
//   });
//
//   final List<String> cities;
//   final List<Property> properties;
//   final List<String> types;
//
//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       cities: json["Cities"] == null
//           ? []
//           : List<String>.from(json["Cities"]!.map((x) => x)),
//       properties: json["properties"] == null
//           ? []
//           : List<Property>.from(
//               json["properties"]!.map((x) => Property.fromJson(x))),
//       types: json["types"] == null
//           ? []
//           : List<String>.from(json["types"]!.map((x) => x)),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "Cities": cities.map((x) => x).toList(),
//         "properties": properties.map((x) => x.toJson()).toList(),
//         "types": types.map((x) => x).toList(),
//       };
// }
//
// class Property {
//   Property({
//     required this.id,
//     required this.agent,
//     required this.title,
//     required this.slug,
//     required this.price,
//     required this.featured,
//     required this.purpose,
//     required this.type,
//     required this.imageUrl,
//     required this.bedroom,
//     required this.bathroom,
//     required this.city,
//     required this.citySlug,
//     required this.address,
//     required this.area,
//     required this.description,
//     required this.video,
//     required this.floorPlan,
//     required this.locationLatitude,
//     required this.locationLongitude,
//     required this.nearby,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.status,
//     required this.shortVideo,
//     required this.likes,
//     required this.floor,
//     required this.areaUnit,
//     required this.areaType,
//   });
//
//   final int? id;
//   final Agent? agent;
//   final String? title;
//   final String? slug;
//   final String? price;
//   final dynamic featured;
//   final String? purpose;
//   final String? type;
//   final String? imageUrl;
//   final int? bedroom;
//   final int? bathroom;
//   final String? city;
//   final String? citySlug;
//   final String? address;
//   final int? area;
//   final String? description;
//   final String? video;
//   final dynamic floorPlan;
//   final dynamic locationLatitude;
//   final dynamic locationLongitude;
//   final String? nearby;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? status;
//   final String? shortVideo;
//   final int? likes;
//   final int? floor;
//   final String? areaUnit;
//   final String? areaType;
//
//   factory Property.fromJson(Map<String, dynamic> json) {
//     return Property(
//       id: json["id"],
//       agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
//       title: json["title"],
//       slug: json["slug"],
//       price: json["price"],
//       featured: json["featured"],
//       purpose: json["purpose"],
//       type: json["type"],
//       imageUrl: json["image_url"],
//       bedroom: json["bedroom"],
//       bathroom: json["bathroom"],
//       city: json["city"],
//       citySlug: json["city_slug"],
//       address: json["address"],
//       area: json["area"],
//       description: json["description"],
//       video: json["video"],
//       floorPlan: json["floor_plan"],
//       locationLatitude: json["location_latitude"],
//       locationLongitude: json["location_longitude"],
//       nearby: json["nearby"],
//       createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
//       status: json["status"],
//       shortVideo: json["short_video"],
//       likes: json["likes"],
//       floor: json["floor"],
//       areaUnit: json["area_unit"],
//       areaType: json["area_type"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "agent": agent?.toJson(),
//         "title": title,
//         "slug": slug,
//         "price": price,
//         "featured": featured,
//         "purpose": purpose,
//         "type": type,
//         "bedroom": bedroom,
//         "image_url": imageUrl,
//         "bathroom": bathroom,
//         "city": city,
//         "city_slug": citySlug,
//         "address": address,
//         "area": area,
//         "description": description,
//         "video": video,
//         "floor_plan": floorPlan,
//         "location_latitude": locationLatitude,
//         "location_longitude": locationLongitude,
//         "nearby": nearby,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "status": status,
//         "short_video": shortVideo,
//         "likes": likes,
//         "floor": floor,
//         "area_unit": areaUnit,
//         "area_type": areaType,
//       };
// }
//
// class Agent {
//   Agent({
//     required this.id,
//     required this.name,
//     required this.phoneNumberCountryCode,
//     required this.phoneNumber,
//   });
//
//   final int? id;
//   final String? name;
//   final String? phoneNumberCountryCode;
//   final String? phoneNumber;
//
//   factory Agent.fromJson(Map<String, dynamic> json) {
//     return Agent(
//       id: json["id"],
//       name: json["name"],
//       phoneNumberCountryCode: json["phone_number_country_code"],
//       phoneNumber: json["phone_number"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "phone_number_country_code": phoneNumberCountryCode,
//         "phone_number": phoneNumber,
//       };
// }


class AllPropertiesModel {
  final List<Property>? properties;

  AllPropertiesModel({this.properties});

  factory AllPropertiesModel.fromJson(List<dynamic> json) {
    print('my json resp $json');
    return AllPropertiesModel(
      properties: json.map((e) => Property.fromJson(e)).toList(),
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


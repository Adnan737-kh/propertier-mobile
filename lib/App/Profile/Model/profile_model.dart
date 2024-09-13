import 'package:propertier/Model/property.dart';

class ProfileModel {
  ProfileModel({
    this.userProfile,
    this.awards,
    this.properties,
  });

  final UserProfile? userProfile;
  final List<Award>? awards;
  final List<Property>? properties;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userProfile: json["user_profile"] == null
          ? null
          : UserProfile.fromJson(json["user_profile"]),
      awards: json["awards"] == null
          ? []
          : List<Award>.from(json["awards"]!.map((x) => Award.fromJson(x))),
      properties: json["properties"] == null
          ? []
          : List<Property>.from(
              json["properties"]!.map((x) => Property.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "user_profile": userProfile?.toJson(),
        "awards": awards!.map((x) => x.toJson()).toList(),
        "properties": properties!.map((x) => x.toJson()).toList(),
      };
}

class Award {
  Award({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.agent,
  });

  final int? id;
  final String? title;
  final String? description;
  final DateTime? date;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? agent;

  factory Award.fromJson(Map<String, dynamic> json) {
    return Award(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      date: DateTime.tryParse(json["date"] ?? ""),
      image: json["image_url"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      agent: json["agent"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "agent": agent,
      };
}

// class Property {
//     Property({
//         required this.id,
//         required this.agent,
//         required this.title,
//         required this.slug,
//         required this.price,
//         required this.featured,
//         required this.purpose,
//         required this.type,
//         required this.image,
//         required this.bedroom,
//         required this.bathroom,
//         required this.city,
//         required this.citySlug,
//         required this.address,
//         required this.area,
//         required this.description,
//         required this.video,
//         required this.floorPlan,
//         required this.locationLatitude,
//         required this.locationLongitude,
//         required this.nearby,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.status,
//         required this.shortVideo,
//         required this.likes,
//         required this.floor,
//         required this.areaUnit,
//         required this.areaType,
//     });

//     final int? id;
//     final Agent? agent;
//     final String? title;
//     final String? slug;
//     final String? price;
//     final dynamic featured;
//     final String? purpose;
//     final String? type;
//     final String? image;
//     final int? bedroom;
//     final int? bathroom;
//     final String? city;
//     final String? citySlug;
//     final String? address;
//     final int? area;
//     final String? description;
//     final String? video;
//     final dynamic floorPlan;
//     final dynamic locationLatitude;
//     final dynamic locationLongitude;
//     final String? nearby;
//     final DateTime? createdAt;
//     final DateTime? updatedAt;
//     final int? status;
//     final String? shortVideo;
//     final int? likes;
//     final int? floor;
//     final String? areaUnit;
//     final String? areaType;

//     factory Property.fromJson(Map<String, dynamic> json){
//         return Property(
//             id: json["id"],
//             agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
//             title: json["title"],
//             slug: json["slug"],
//             price: json["price"],
//             featured: json["featured"],
//             purpose: json["purpose"],
//             type: json["type"],
//             image: json["image"],
//             bedroom: json["bedroom"],
//             bathroom: json["bathroom"],
//             city: json["city"],
//             citySlug: json["city_slug"],
//             address: json["address"],
//             area: json["area"],
//             description: json["description"],
//             video: json["video"],
//             floorPlan: json["floor_plan"],
//             locationLatitude: json["location_latitude"],
//             locationLongitude: json["location_longitude"],
//             nearby: json["nearby"],
//             createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//             updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
//             status: json["status"],
//             shortVideo: json["short_video"],
//             likes: json["likes"],
//             floor: json["floor"],
//             areaUnit: json["area_unit"],
//             areaType: json["area_type"],
//         );
//     }

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "agent": agent?.toJson(),
//         "title": title,
//         "slug": slug,
//         "price": price,
//         "featured": featured,
//         "purpose": purpose,
//         "type": type,
//         "image": image,
//         "bedroom": bedroom,
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
//     };

// }

// class Agent {
//     Agent({
//         required this.id,
//         required this.name,
//         required this.phoneNumberCountryCode,
//         required this.phoneNumber,
//     });

//     final int? id;
//     final String? name;
//     final String? phoneNumberCountryCode;
//     final String? phoneNumber;

//     factory Agent.fromJson(Map<String, dynamic> json){
//         return Agent(
//             id: json["id"],
//             name: json["name"],
//             phoneNumberCountryCode: json["phone_number_country_code"],
//             phoneNumber: json["phone_number"],
//         );
//     }

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "phone_number_country_code": phoneNumberCountryCode,
//         "phone_number": phoneNumber,
//     };

// }

class UserProfile {
  UserProfile({
    required this.id,
    required this.name,
    required this.phoneNumberCountryCode,
    required this.phoneNumber,
    required this.email,
    required this.about,
    required this.profilePictureUrl,
    required this.coverPhotoUrl,
    required this.address,
    required this.createdAt,
  });

  final int? id;
  final String? name;
  final String? phoneNumberCountryCode;
  final String? phoneNumber;
  final String? email;
  final dynamic about;
  final dynamic profilePictureUrl;
  final dynamic coverPhotoUrl;
  final String? address;
  final DateTime? createdAt;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json["id"],
      name: json["name"],
      phoneNumberCountryCode: json["phone_number_country_code"],
      phoneNumber: json["phone_number"],
      email: json["email"],
      about: json["about"],
      profilePictureUrl: json["profile_picture_url"],
      coverPhotoUrl: json["cover_photo_url"],
      address: json["address"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_number_country_code": phoneNumberCountryCode,
        "phone_number": phoneNumber,
        "email": email,
        "about": about,
        "profile_picture_url": profilePictureUrl,
        "cover_photo_url": coverPhotoUrl,
        "address": address,
        "created_at": createdAt?.toIso8601String(),
      };
}

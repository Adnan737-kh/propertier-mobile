
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
      image: json["image"],
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

class CompleteProfile {
  String? phoneNumber;
  String? address;
  String? profilePictureUrl;
  String? gender;

  CompleteProfile({
    this.phoneNumber,
    this.address,
    this.profilePictureUrl,
    this.gender,
  });

  factory CompleteProfile.fromJson(Map<String, dynamic> json) {
    return CompleteProfile(
      phoneNumber: json["phone_number"] ?? "",
      address: json["address"] ?? "",
      profilePictureUrl: json["profile_picture"] ?? "",
      gender: json["gender"] ?? "Male", // Default to Male if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "phone_number": phoneNumber,
      "address": address,
      "profile_picture": profilePictureUrl,
      "gender": gender,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "phone_number": phoneNumber,
      "address": address,
      "profile_picture": profilePictureUrl,
      "gender": gender,
    };
  }
  factory CompleteProfile.fromMap(Map<String, dynamic> map) {
    return CompleteProfile(
      phoneNumber: map["phone_number"] ?? "",
      address: map["address"] ?? "",
      profilePictureUrl: map["profile_picture"] ?? "",
      gender: map["gender"] ?? "Male",
    );
  }
}

class UserProfile {
  UserProfile({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.about,
    required this.profilePictureUrl,
    required this.coverPhotoUrl,
    required this.address,
    required this.verificationStatus,
    required this.vendor,
    required this.phoneNumberVerificationStatus,
    required this.emailVerificationStatus,
    required this.cnicVerificationStatus,
    required this.selfieVerificationStatus,
    required this.addressVerificationStatus,
    required this.profilePictureVerificationStatus,
    required this.createdAt,
  });

  final int? id;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final dynamic about;
  final dynamic profilePictureUrl;
  final dynamic coverPhotoUrl;
  final String? address;
  final String? verificationStatus;
  final Vendor? vendor;
  final String? phoneNumberVerificationStatus;
  final String? emailVerificationStatus;
  final String? cnicVerificationStatus;
  final String? selfieVerificationStatus;
  final String? addressVerificationStatus;
  final String? profilePictureVerificationStatus;
  final DateTime? createdAt;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json["id"],
      name: json["full_name"],
      phoneNumber: json["phone_number"],
      email: json["email"],
      about: json["about"],
      profilePictureUrl: json["profile_picture"],
      coverPhotoUrl: json["cover_photo"],
      address: json["address"],
      verificationStatus: json["general_verification_status"],
      vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
      emailVerificationStatus: json["email_verification_status"],
      phoneNumberVerificationStatus: json["phone_number_verification_status"],
      cnicVerificationStatus: json["cnic_verification_status"],
      selfieVerificationStatus: json["selfie_verification_status"],
      addressVerificationStatus: json["business_address_verification_status"],
      profilePictureVerificationStatus: json["profile_picture_verification_status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": name,
    "phone_number": phoneNumber,
    "email": email,
    "about": about,
    "profile_picture": profilePictureUrl,
    "cover_photo": coverPhotoUrl,
    "address": address,
    "general_verification_status": verificationStatus,
    "vendor": vendor?.toJson(),
    "email_verification_status": emailVerificationStatus,
    "phone_number_verification_status": phoneNumberVerificationStatus,
    "cnic_verification_status": cnicVerificationStatus,
    "selfie_verification_status": selfieVerificationStatus,
    "business_address_verification_status": addressVerificationStatus,
    "profile_picture_verification_status": profilePictureVerificationStatus,
    "created_at": createdAt?.toIso8601String(),
  };

  @override
  String toString() {
    return 'UserProfile(full_name: $name, email: $email, phoneNumber: $phoneNumber, '
        'address: $address, profilePictureUrl: $profilePictureUrl, about: $about)';
  }
}

class Vendor {
  final int? id;
  final String? profileDescription;
  final int? user;
  final SubmittedRequirements? submittedRequirements;
  final AssignedService? assignedService;

  Vendor({
    this.id,
    this.profileDescription,
    this.user,
    this.submittedRequirements,
    this.assignedService,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["id"],
    profileDescription: json["profile_description"],
    user: json["user"],
    submittedRequirements: json["submitted_requirements"] == null
        ? null
        : SubmittedRequirements.fromJson(json["submitted_requirements"]),
    assignedService: json["assigned_service"] == null
        ? null
        : AssignedService.fromJson(json["assigned_service"]), // ✅ NEW
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_description": profileDescription,
    "user": user,
    "submitted_requirements": submittedRequirements?.toJson(),
    "assigned_service": assignedService?.toJson(), // ✅ NEW
  };
}

class SubmittedRequirements {
  final int? id;
  final String? serviceType;
  final String? status;

  SubmittedRequirements({
    this.id,
    this.serviceType,
    this.status,
  });

  factory SubmittedRequirements.fromJson(Map<String, dynamic> json) =>
      SubmittedRequirements(
        id: json["id"],
        serviceType: json["service_type"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "service_type": serviceType,
    "status": status,
  };
}

class AssignedService {
  final int? id;
  final String? assignedServiceTitle;
  final String? mainCategory;

  AssignedService({
    this.id,
    this.assignedServiceTitle,
    this.mainCategory,
  });

  factory AssignedService.fromJson(Map<String, dynamic> json) =>
      AssignedService(
        id: json["id"],
        assignedServiceTitle: json["title"],
        mainCategory: json["main_category"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": assignedServiceTitle,
    "main_category": mainCategory,
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



// import 'dart:convert';
//
// import 'package:propertier/Model/property.dart';
//
// class ProfileModel {
//   ProfileModel({
//     this.userProfile,
//     this.awards,
//     this.properties,
//   });
//
//   final UserProfile? userProfile;
//   final List<Award>? awards;
//   final List<Property>? properties;
//
//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       userProfile: json.containsKey("email") // Check if the key exists
//           ? UserProfile.fromJson(
//               json) // Pass the entire JSON since it holds user profile details
//           : null,
//       awards: json["awards"] == null
//           ? []
//           : List<Award>.from(json["awards"]!.map((x) => Award.fromJson(x))),
//       properties: json["properties"] == null
//           ? []
//           : List<Property>.from(
//               json["properties"]!.map((x) => Property.fromJson(x))),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "user_profile": userProfile?.toJson(),
//         "awards": awards!.map((x) => x.toJson()).toList(),
//         "properties": properties!.map((x) => x.toJson()).toList(),
//       };
// }
//
// class Award {
//   Award({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.date,
//     required this.image,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.agent,
//   });
//
//   final int? id;
//   final String? title;
//   final String? description;
//   final DateTime? date;
//   final String? image;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? agent;
//
//   factory Award.fromJson(Map<String, dynamic> json) {
//     return Award(
//       id: json["id"],
//       title: json["title"],
//       description: json["description"],
//       date: DateTime.tryParse(json["date"] ?? ""),
//       image: json["image_url"],
//       createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
//       agent: json["agent"],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "description": description,
//         "date": date,
//         "image": image,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "agent": agent,
//       };
// }
//
// // class Property {
// //     Property({
// //         required this.id,
// //         required this.agent,
// //         required this.title,
// //         required this.slug,
// //         required this.price,
// //         required this.featured,
// //         required this.purpose,
// //         required this.type,
// //         required this.image,
// //         required this.bedroom,
// //         required this.bathroom,
// //         required this.city,
// //         required this.citySlug,
// //         required this.address,
// //         required this.area,
// //         required this.description,
// //         required this.video,
// //         required this.floorPlan,
// //         required this.locationLatitude,
// //         required this.locationLongitude,
// //         required this.nearby,
// //         required this.createdAt,
// //         required this.updatedAt,
// //         required this.status,
// //         required this.shortVideo,
// //         required this.likes,
// //         required this.floor,
// //         required this.areaUnit,
// //         required this.areaType,
// //     });
//
// //     final int? id;
// //     final Agent? agent;
// //     final String? title;
// //     final String? slug;
// //     final String? price;
// //     final dynamic featured;
// //     final String? purpose;
// //     final String? type;
// //     final String? image;
// //     final int? bedroom;
// //     final int? bathroom;
// //     final String? city;
// //     final String? citySlug;
// //     final String? address;
// //     final int? area;
// //     final String? description;
// //     final String? video;
// //     final dynamic floorPlan;
// //     final dynamic locationLatitude;
// //     final dynamic locationLongitude;
// //     final String? nearby;
// //     final DateTime? createdAt;
// //     final DateTime? updatedAt;
// //     final int? status;
// //     final String? shortVideo;
// //     final int? likes;
// //     final int? floor;
// //     final String? areaUnit;
// //     final String? areaType;
//
// //     factory Property.fromJson(Map<String, dynamic> json){
// //         return Property(
// //             id: json["id"],
// //             agent: json["agent"] == null ? null : Agent.fromJson(json["agent"]),
// //             title: json["title"],
// //             slug: json["slug"],
// //             price: json["price"],
// //             featured: json["featured"],
// //             purpose: json["purpose"],
// //             type: json["type"],
// //             image: json["image"],
// //             bedroom: json["bedroom"],
// //             bathroom: json["bathroom"],
// //             city: json["city"],
// //             citySlug: json["city_slug"],
// //             address: json["address"],
// //             area: json["area"],
// //             description: json["description"],
// //             video: json["video"],
// //             floorPlan: json["floor_plan"],
// //             locationLatitude: json["location_latitude"],
// //             locationLongitude: json["location_longitude"],
// //             nearby: json["nearby"],
// //             createdAt: DateTime.tryParse(json["created_at"] ?? ""),
// //             updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
// //             status: json["status"],
// //             shortVideo: json["short_video"],
// //             likes: json["likes"],
// //             floor: json["floor"],
// //             areaUnit: json["area_unit"],
// //             areaType: json["area_type"],
// //         );
// //     }
//
// //     Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "agent": agent?.toJson(),
// //         "title": title,
// //         "slug": slug,
// //         "price": price,
// //         "featured": featured,
// //         "purpose": purpose,
// //         "type": type,
// //         "image": image,
// //         "bedroom": bedroom,
// //         "bathroom": bathroom,
// //         "city": city,
// //         "city_slug": citySlug,
// //         "address": address,
// //         "area": area,
// //         "description": description,
// //         "video": video,
// //         "floor_plan": floorPlan,
// //         "location_latitude": locationLatitude,
// //         "location_longitude": locationLongitude,
// //         "nearby": nearby,
// //         "created_at": createdAt?.toIso8601String(),
// //         "updated_at": updatedAt?.toIso8601String(),
// //         "status": status,
// //         "short_video": shortVideo,
// //         "likes": likes,
// //         "floor": floor,
// //         "area_unit": areaUnit,
// //         "area_type": areaType,
// //     };
//
// // }
//
// // class Agent {
// //     Agent({
// //         required this.id,
// //         required this.name,
// //         required this.phoneNumberCountryCode,
// //         required this.phoneNumber,
// //     });
//
// //     final int? id;
// //     final String? name;
// //     final String? phoneNumberCountryCode;
// //     final String? phoneNumber;
//
// //     factory Agent.fromJson(Map<String, dynamic> json){
// //         return Agent(
// //             id: json["id"],
// //             name: json["name"],
// //             phoneNumberCountryCode: json["phone_number_country_code"],
// //             phoneNumber: json["phone_number"],
// //         );
// //     }
//
// //     Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "name": name,
// //         "phone_number_country_code": phoneNumberCountryCode,
// //         "phone_number": phoneNumber,
// //     };
//
// // }
//
// class UserProfile {
//   UserProfile({
//     required this.id,
//     required this.name,
//     required this.phoneNumberCountryCode,
//     required this.phoneNumber,
//     required this.email,
//     required this.about,
//     required this.profilePictureUrl,
//     required this.coverPhotoUrl,
//     required this.address,
//     required this.gender,
//     required this.createdAt,
//     required this.requiresProfileCompletion,
//   });
//
//   final int? id;
//   final String? name;
//   final String? phoneNumberCountryCode;
//   final String? phoneNumber;
//   final String? email;
//   final dynamic about;
//   final dynamic profilePictureUrl;
//   final dynamic coverPhotoUrl;
//   final String? address;
//   final String? gender;
//   final bool? requiresProfileCompletion;
//   final DateTime? createdAt;
//
//   factory UserProfile.fromJson(Map<String, dynamic> json) {
//     print('user phone_number!!!!! ${json["phone_number"]}');
//     return UserProfile(
//       id: json["id"],
//       name: json["full_name"],
//       phoneNumberCountryCode: json["phone_number_country_code"] ?? "0092",
//       phoneNumber: json["phone_number"],
//       email: json["email"],
//       about: json["about"],
//       profilePictureUrl: json["profile_picture"],
//       coverPhotoUrl: json["cover_photo"],
//       address: json["address"],
//       gender: json["gender"],
//       requiresProfileCompletion: json["requires_profile_completion"],
//       createdAt: DateTime.tryParse(json["created_at"] ?? ""),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "phone_number_country_code": phoneNumberCountryCode,
//         "phone_number": phoneNumber,
//         "email": email,
//         "about": about,
//         "profile_picture": profilePictureUrl,
//         "cover_photo": coverPhotoUrl,
//         "address": address,
//         "gender": gender,
//         "requires_profile_completion": requiresProfileCompletion,
//         "created_at": createdAt?.toIso8601String(),
//       };
// }
//
// class UpdateProfile {
//   String? phoneNumber;
//   String? address;
//   String? profilePictureUrl;
//   String? gender;
//
//   UpdateProfile({
//     this.phoneNumber,
//     this.address,
//     this.profilePictureUrl,
//     this.gender,
//   });
//
//   // Factory method to create UserProfile from JSON
//   factory UpdateProfile.fromJson(Map<String, dynamic> json) {
//     return UpdateProfile(
//       phoneNumber: json["phone_number"] ?? "",
//       address: json["address"] ?? "",
//       profilePictureUrl: json["profile_picture_url"] ?? "",
//       gender: json["gender"] ?? "Male", // Default to Male if null
//     );
//   }
//
//   // Convert UserProfile to JSON for API requests
//   Map<String, dynamic> toJson() {
//     return {
//       "phone_number": phoneNumber,
//       "address": address,
//       "profile_picture_url": profilePictureUrl,
//       "gender": gender,
//     };
//   }
//
//   // Convert UserProfile to a Map (useful for local storage)
//   Map<String, dynamic> toMap() {
//     return {
//       "phone_number": phoneNumber,
//       "address": address,
//       "profile_picture_url": profilePictureUrl,
//       "gender": gender,
//     };
//   }
//
//   // Create UserProfile from a Map (useful for local storage)
//   factory UpdateProfile.fromMap(Map<String, dynamic> map) {
//     return UpdateProfile(
//       phoneNumber: map["phone_number"] ?? "",
//       address: map["address"] ?? "",
//       profilePictureUrl: map["profile_picture_url"] ?? "",
//       gender: map["gender"] ?? "Male",
//     );
//   }
// }
//
// class EditUserModel {
//   String? fullName;
//   String? email;
//   String? phoneNumber;
//   String? address;
//   String? profilePictureUrl;
//   String? gender;
//   String? about;
//   String? coverPhotoUrl;
//   String? accountStatus;
//   bool? isStaff;
//   bool? isActive;
//   List<String>? languages;
//   String? designation;
//   double? longitudePosition;
//   double? latitudePosition;
//   List<String>? followers;
//   List<String>? likes;
//   Map<String, dynamic>? notificationsEnabled;
//
//   EditUserModel({
//     required this.fullName,
//     required this.email,
//     required this.phoneNumber,
//     required this.address,
//     this.profilePictureUrl,
//     this.gender,
//     this.about,
//     this.coverPhotoUrl,
//     this.accountStatus,
//     this.isStaff,
//     this.isActive,
//     this.languages,
//     this.designation,
//     this.longitudePosition,
//     this.latitudePosition,
//     this.followers,
//     this.likes,
//     this.notificationsEnabled,
//   });
//
//   /// Convert an object to a Map
//   Map<String, dynamic> toMap() {
//     return {
//       if (email != null && email!.isNotEmpty) "email": email,
//       if (fullName != null && fullName!.isNotEmpty) "full_name": fullName,
//       if (phoneNumber != null && phoneNumber!.isNotEmpty) "phone_number": phoneNumber,
//       if (address != null && address!.isNotEmpty) "address": address,
//       if (profilePictureUrl != null && profilePictureUrl!.isNotEmpty)
//         "profile_picture_url": profilePictureUrl,
//       if (gender != null && gender!.isNotEmpty) "gender": gender,
//       if (about != null && about!.isNotEmpty) "about": about,
//       if (coverPhotoUrl != null && coverPhotoUrl!.isNotEmpty)
//         "cover_photo": coverPhotoUrl,
//       if (accountStatus != null && accountStatus!.isNotEmpty)
//         "account_status": accountStatus,
//       if (isStaff != null) "is_staff": isStaff,
//       if (isActive != null) "is_active": isActive,
//       if (languages != null && languages!.isNotEmpty) "languages": languages,
//       if (designation != null && designation!.isNotEmpty) "designation": designation,
//       if (longitudePosition != null) "longitude_position": longitudePosition,
//       if (latitudePosition != null) "latitude_position": latitudePosition,
//       if (followers != null) "followers": followers,
//       if (likes != null) "likes": likes,
//       if (notificationsEnabled != null)
//         "notifications_enabled": notificationsEnabled,
//     };
//   }
//
//
//   /// Convert an object to a JSON string
//   String toJson() => jsonEncode(toMap());
//
//   /// Create an object from a Map
//   factory EditUserModel.fromMap(Map<String, dynamic> map) {
//     return EditUserModel(
//       email: map["email"] ?? "",
//       fullName: map["full_name"] ?? "",
//       phoneNumber: map["phone_number"] ?? "",
//       address: map["address"] ?? "",
//       profilePictureUrl: map["profile_picture_url"] ?? "",
//       gender: map["gender"] ?? "",
//       about: map["about"],
//       coverPhotoUrl: map["cover_photo"],
//       accountStatus: map["account_status"] ?? "inactive",
//       isStaff: map["is_staff"] ?? false,
//       isActive: map["is_active"] ?? false,
//       languages: List<String>.from(map["languages"] ?? []),
//       designation: map["designation"],
//       longitudePosition: map["longitude_position"]?.toDouble(),
//       latitudePosition: map["latitude_position"]?.toDouble(),
//       followers: List<String>.from(map["followers"] ?? []),
//       likes: List<String>.from(map["likes"] ?? []),
//       notificationsEnabled:
//           Map<String, dynamic>.from(map["notifications_enabled"] ?? {}),
//     );
//   }
//
//   /// Create an object from a JSON string
//   factory EditUserModel.fromJson(String source) =>
//       EditUserModel.fromMap(jsonDecode(source));
// }

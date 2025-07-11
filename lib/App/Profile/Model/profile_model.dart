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

class CompleteProfileModel {
  String? phoneNumber;
  String? address;
  String? profilePictureUrl;
  String? gender;

  CompleteProfileModel({
    this.phoneNumber,
    this.address,
    this.profilePictureUrl,
    this.gender,
  });

  factory CompleteProfileModel.fromJson(Map<String, dynamic> json) {
    return CompleteProfileModel(
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
  factory CompleteProfileModel.fromMap(Map<String, dynamic> map) {
    return CompleteProfileModel(
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
    required this.requiresProfileCompletion,
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
  final bool? requiresProfileCompletion;
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
      requiresProfileCompletion: json["requires_profile_completion"],
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
    "requires_profile_completion": requiresProfileCompletion,
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
        : AssignedService.fromJson(json["assigned_service"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "profile_description": profileDescription,
    "user": user,
    "submitted_requirements": submittedRequirements?.toJson(),
    "assigned_service": assignedService?.toJson(),
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




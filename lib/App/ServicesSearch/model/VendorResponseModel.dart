class VendorOfferModel {
  BidResponse? bidResponse;

  VendorOfferModel({this.bidResponse});

  VendorOfferModel.fromJson(Map<String, dynamic> json) {
    bidResponse = json['bid_response'] != null ?  BidResponse.fromJson(json['bid_response']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bidResponse != null) {
      data['bid_response'] =bidResponse!.toJson();
    }
    return data;
  }
}

class BidResponse {
  int? id;
  UserData? vendor;
  String? message;
  String? status;
  String? amount;
  String? createdAt;
  String? updatedAt;
  int? bid;

  BidResponse({this.id, this.vendor, this.message, this.status, this.amount, this.createdAt, this.updatedAt, this.bid});

  BidResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendor = json['vendor'] != null ?  UserData.fromJson(json['vendor']) : null;
    message = json['message'];
    status = json['status'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bid = json['bid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    if (vendor != null) {
      data['vendor'] =vendor!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['bid'] = bid;
    return data;
  }
}


class UserData {
  UserData({
    this.id,
    this.lastLogin,
    this.isSuperuser,
    this.firebaseId,
    this.name,
    this.about,
    this.phoneNumberCountryCode,
    this.phoneNumber,
    this.email,
    this.profilePictureUrl,
    this.coverPhotoUrl,
    this.type,
    this.accountStatus,
    this.isStaff,
    this.isActive,
    this.notificationsEnabled,
    this.createdAt,
    this.updatedAt,
    this.gender,
    this.language,
    this.designation,
    this.address,
    this.latitudePosition,
    this.longitudePosition,
    this.profileDescription,
    this.cnicFrontUrl,
    this.cnicBackUrl,
    this.groups,
    this.hashedPassword,
    this.userPermissions,
  });

  final int? id;
  final dynamic lastLogin;
  final bool? isSuperuser;
  final String? firebaseId;
  final String? name;
  final dynamic about;
  final String? phoneNumberCountryCode;
  final String? phoneNumber;
  final String? email;
  final dynamic profilePictureUrl;
  final dynamic coverPhotoUrl;
  final String? type;
  final String? accountStatus;
  final bool? isStaff;
  final bool? isActive;
  final NotificationsEnabled? notificationsEnabled;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic gender;
  final dynamic language;
  final dynamic designation;
  final String? address;
  String? hashedPassword;
  final dynamic latitudePosition;
  final dynamic longitudePosition;
  final dynamic profileDescription;
  final dynamic cnicFrontUrl;
  final dynamic cnicBackUrl;
  final List<dynamic>? groups;
  final List<dynamic>? userPermissions;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"],
      lastLogin: json["last_login"],
      isSuperuser: json["is_superuser"],
      firebaseId: json["firebase_id"],
      name: json["name"],
      about: json["about"],
      phoneNumberCountryCode: json["phone_number_country_code"],
      phoneNumber: json["phone_number"],
      email: json["email"],
      profilePictureUrl: json["profile_picture_url"],
      coverPhotoUrl: json["cover_photo_url"],
      type: json["type"],
      accountStatus: json["account_status"],
      isStaff: json["is_staff"],
      isActive: json["is_active"],
      notificationsEnabled: json["notifications_enabled"] == null
          ? null
          : NotificationsEnabled.fromJson(json["notifications_enabled"]),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      gender: json["gender"],
      language: json["language"],
      designation: json["designation"],
      address: json["address"],
      latitudePosition: json["latitude_position"],
      longitudePosition: json["longitude_position"],
      profileDescription: json["profile_description"],
      cnicFrontUrl: json["cnic_front_url"],
      cnicBackUrl: json["cnic_back_url"],
      hashedPassword: json["hashedPassword"],
      groups: json["groups"] == null
          ? []
          : List<dynamic>.from(json["groups"]!.map((x) => x)),
      userPermissions: json["user_permissions"] == null
          ? []
          : List<dynamic>.from(json["user_permissions"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "last_login": lastLogin,
    "is_superuser": isSuperuser,
    "firebase_id": firebaseId,
    "name": name,
    "hashedPassword": hashedPassword,
    "about": about,
    "phone_number_country_code": phoneNumberCountryCode,
    "phone_number": phoneNumber,
    "email": email,
    "profile_picture_url": profilePictureUrl,
    "cover_photo_url": coverPhotoUrl,
    "type": type,
    "account_status": accountStatus,
    "is_staff": isStaff,
    "is_active": isActive,
    "notifications_enabled": notificationsEnabled?.toJson(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "gender": gender,
    "language": language,
    "designation": designation,
    "address": address,
    "latitude_position": latitudePosition,
    "longitude_position": longitudePosition,
    "profile_description": profileDescription,
    "cnic_front_url": cnicFrontUrl,
    "cnic_back_url": cnicBackUrl,
    "groups": groups!.map((x) => x).toList(),
    "user_permissions": userPermissions!.map((x) => x).toList(),
  };
}

class NotificationsEnabled {
  NotificationsEnabled({required this.json});
  final Map<String, dynamic> json;

  factory NotificationsEnabled.fromJson(Map<String, dynamic> json) {
    return NotificationsEnabled(json: json);
  }

  Map<String, dynamic> toJson() => {};
}

class Like {
  Like({
    required this.id,
    required this.userId,
    required this.propertyId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? userId;
  final int? propertyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json["id"],
      userId: json["user_id"],
      propertyId: json["property_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "property_id": propertyId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

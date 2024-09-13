import 'dart:convert';

// LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

// String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

// class LoginResponseModel {
//     bool? success;
//     Data? data;
//     String? message;

//     LoginResponseModel({
//         this.success,
//         this.data,
//         this.message,
//     });

//     factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
//         success: json["success"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//         message: json["message"],
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data?.toJson(),
//         "message": message,
//     };
// }

// class Data {
//     UserData? user;

//     Data({
//         this.user,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         user: json["user"] == null ? null : UserData.fromJson(json["user"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "user": user?.toJson(),
//     };
// }

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

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  int? id;
  dynamic lastLogin;
  bool? isSuperuser;
  String? firebaseId;
  String? name;
  String? about;
  String? phoneNumberCountryCode;
  String? phoneNumber;
  String? email;
  dynamic profilePicture;
  dynamic coverPhoto;
  String? type;
  String? accountStatus;
  bool? isStaff;
  bool? isActive;
  NotificationsEnabled? notificationsEnabled;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? gender;
  String? language;
  String? designation;
  String? address;
  String? latitudePosition;
  String? longitudePosition;
  dynamic firebasePassword;
  List<dynamic>? groups;
  List<dynamic>? userPermissions;

  LoginResponseModel({
    this.id,
    this.lastLogin,
    this.isSuperuser,
    this.firebaseId,
    this.name,
    this.about,
    this.phoneNumberCountryCode,
    this.phoneNumber,
    this.email,
    this.profilePicture,
    this.coverPhoto,
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
    this.firebasePassword,
    this.groups,
    this.userPermissions,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        id: json["id"],
        lastLogin: json["last_login"],
        isSuperuser: json["is_superuser"],
        firebaseId: json["firebase_id"],
        name: json["name"],
        about: json["about"],
        phoneNumberCountryCode: json["phone_number_country_code"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        profilePicture: json["profile_picture"],
        coverPhoto: json["cover_photo"],
        type: json["type"],
        accountStatus: json["account_status"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        notificationsEnabled: json["notifications_enabled"] == null
            ? null
            : NotificationsEnabled.fromJson(json["notifications_enabled"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        gender: json["gender"],
        language: json["language"],
        designation: json["designation"],
        address: json["address"],
        latitudePosition: json["latitude_position"],
        longitudePosition: json["longitude_position"],
        firebasePassword: json["firebase_password"],
        groups: json["groups"] == null
            ? []
            : List<dynamic>.from(json["groups"]!.map((x) => x)),
        userPermissions: json["user_permissions"] == null
            ? []
            : List<dynamic>.from(json["user_permissions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_login": lastLogin,
        "is_superuser": isSuperuser,
        "firebase_id": firebaseId,
        "name": name,
        "about": about,
        "phone_number_country_code": phoneNumberCountryCode,
        "phone_number": phoneNumber,
        "email": email,
        "profile_picture": profilePicture,
        "cover_photo": coverPhoto,
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
        "firebase_password": firebasePassword,
        "groups":
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "user_permissions": userPermissions == null
            ? []
            : List<dynamic>.from(userPermissions!.map((x) => x)),
      };
}

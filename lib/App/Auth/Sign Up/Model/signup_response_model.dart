import 'dart:convert';

SignupResponseModel signupResponseModelFromJson(String str) =>
    SignupResponseModel.fromJson(json.decode(str));

String signupResponseModelToJson(SignupResponseModel data) =>
    json.encode(data.toJson());

class SignupResponseModel {
  int? id;
  dynamic lastLogin;
  bool? isSuperuser;
  String? firebaseId;
  String? name;
  dynamic about;
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
  dynamic gender;
  dynamic language;
  dynamic designation;
  dynamic address;
  dynamic latitudePosition;
  dynamic longitudePosition;
  dynamic cnicFront;
  dynamic cnicBack;
  int? totalSpending;
  int? monthlySpending;
  List<dynamic>? groups;
  List<dynamic>? userPermissions;

  SignupResponseModel({
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
    this.cnicFront,
    this.cnicBack,
    this.totalSpending,
    this.monthlySpending,
    this.groups,
    this.userPermissions,
  });

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) =>
      SignupResponseModel(
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
        cnicFront: json["cnic_front"],
        cnicBack: json["cnic_back"],
        totalSpending: json["total_spending"],
        monthlySpending: json["monthly_spending"],
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
        "cnic_front": cnicFront,
        "cnic_back": cnicBack,
        "total_spending": totalSpending,
        "monthly_spending": monthlySpending,
        "groups":
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "user_permissions": userPermissions == null
            ? []
            : List<dynamic>.from(userPermissions!.map((x) => x)),
      };
}

class NotificationsEnabled {
  NotificationsEnabled();

  factory NotificationsEnabled.fromJson(Map<String, dynamic> json) =>
      NotificationsEnabled();

  Map<String, dynamic> toJson() => {};
}

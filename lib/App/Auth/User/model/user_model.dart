import 'dart:convert';

class UserModelGlobal {
  String? fullName;
  String? email;
  String? phoneNumber;
  String? address;
  String? profilePictureUrl;
  String? gender;
  String? about;
  String? coverPhotoUrl;
  String? accountStatus;
  bool? isStaff;
  bool? isActive;
  List<String>? languages;
  String? designation;
  double? longitudePosition;
  double? latitudePosition;
  List<String>? followers;
  List<String>? likes;
  Map<String, dynamic>? notificationsEnabled;

  UserModelGlobal({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    this.profilePictureUrl,
    this.gender,
    this.about,
    this.coverPhotoUrl,
    this.accountStatus,
    this.isStaff,
    this.isActive,
    this.languages,
    this.designation,
    this.longitudePosition,
    this.latitudePosition,
    this.followers,
    this.likes,
    this.notificationsEnabled,
  });

  /// Convert an object to a Map
  Map<String, dynamic> toMap() {
    return {
      if (email != null && email!.isNotEmpty) "email": email,
      if (fullName != null && fullName!.isNotEmpty) "full_name": fullName,
      if (phoneNumber != null && phoneNumber!.isNotEmpty) "phone_number": phoneNumber,
      if (address != null && address!.isNotEmpty) "address": address,
      if (profilePictureUrl != null && profilePictureUrl!.isNotEmpty)
        "profile_picture_url": profilePictureUrl,
      if (gender != null && gender!.isNotEmpty) "gender": gender,
      if (about != null && about!.isNotEmpty) "about": about,
      if (coverPhotoUrl != null && coverPhotoUrl!.isNotEmpty)
        "cover_photo_url": coverPhotoUrl,
      if (accountStatus != null && accountStatus!.isNotEmpty)
        "account_status": accountStatus,
      if (isStaff != null) "is_staff": isStaff,
      if (isActive != null) "is_active": isActive,
      if (languages != null && languages!.isNotEmpty) "languages": languages,
      if (designation != null && designation!.isNotEmpty) "designation": designation,
      if (longitudePosition != null) "longitude_position": longitudePosition,
      if (latitudePosition != null) "latitude_position": latitudePosition,
      if (followers != null) "followers": followers,
      if (likes != null) "likes": likes,
      if (notificationsEnabled != null)
        "notifications_enabled": notificationsEnabled,
    };
  }


  /// Convert an object to a JSON string
  String toJson() => jsonEncode(toMap());

  /// Create an object from a Map
  factory UserModelGlobal.fromMap(Map<String, dynamic> map) {
    return UserModelGlobal(
      email: map["email"] ?? "",
      fullName: map["full_name"] ?? "",
      phoneNumber: map["phone_number"] ?? "",
      address: map["address"] ?? "",
      profilePictureUrl: map["profile_picture_url"] ?? "",
      gender: map["gender"] ?? "",
      about: map["about"],
      coverPhotoUrl: map["cover_photo_url"],
      accountStatus: map["account_status"] ?? "inactive",
      isStaff: map["is_staff"] ?? false,
      isActive: map["is_active"] ?? false,
      languages: map["languages"] != null ? List<String>.from(map["languages"]) : [],
      designation: map["designation"],

      // ✅ Safe conversion to double
      longitudePosition: map["longitude_position"] != null
          ? double.tryParse(map["longitude_position"].toString()) ?? 0.0
          : 0.0,

      latitudePosition: map["latitude_position"] != null
          ? double.tryParse(map["latitude_position"].toString()) ?? 0.0
          : 0.0,

      followers: map["followers"] != null ? List<String>.from(map["followers"]) : [],
      likes: map["likes"] != null ? List<String>.from(map["likes"]) : [],
      notificationsEnabled: map["notifications_enabled"] != null
          ? Map<String, dynamic>.from(map["notifications_enabled"])
          : {},
    );
  }

  /// Create an object from a JSON string
  factory UserModelGlobal.fromJson(Map<String, dynamic> json) =>
      UserModelGlobal.fromMap(json);
}
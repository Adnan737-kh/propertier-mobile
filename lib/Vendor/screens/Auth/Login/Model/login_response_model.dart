import 'dart:convert';

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
  final List<int>? groups;
  final List<int>? userPermissions;

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
          : List<int>.from(json["groups"]!.map((x) => x)),
      userPermissions: json["user_permissions"] == null
          ? []
          : List<int>.from(json["user_permissions"]!.map((x) => x)),
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
  int? suspensionDays; // Add if required
  bool? isStaff;
  bool? isActive;
  NotificationsEnabled? notificationsEnabled;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic gender;
  List<String>? languages; // Update to List<String>
  String? designation;
  String? address;
  dynamic latitudePosition;
  dynamic longitudePosition;
  String? profileDescription; // Update to profileDescription
  dynamic cnicFront;
  dynamic cnicBack;
  double? totalIncome; // Add if required
  double? monthlyIncome; // Add if required
  double? deductions; // Add if required
  double? rating; // Add if required
  double? visitingCharges; // Add if required
  dynamic availabilityHours; // Update to appropriate type
  String? level; // Add if required
  double? balance; // Add if required
  dynamic bankDetails;
  bool? onlineStatus; // Add if required
  String? facebookLink;
  String? instagramLink;
  String? twitterLink;
  bool? letterHeadVerified;
  bool? cnicVerified;
  bool? profilePictureVerified;
  bool? shopVisitingCardVerified;
  bool? emailVerified;
  bool? certificateOfIncorporationVerified;
  bool? artificialOfAssociationVerified;
  bool? memberOfAssociationVerified;
  bool? incorporateDocumentVerified;
  bool? soleProprietorDocumentVerified;
  String? letterHeadUrl; // Add if required
  String? shopVisitingCardUrl; // Add if required
  String? certificateOfIncorporationUrl; // Add if required
  String? artificialOfAssociationUrl; // Add if required
  String? memberOfAssociationUrl; // Add if required
  String? incorporateDocumentUrl; // Add if required
  String? soleProprietorDocumentUrl; // Add if required
  List<int>? groups;
  List<int>? userPermissions;

  var firebasePassword;

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
    this.languages,
    this.designation,
    this.address,
    this.latitudePosition,
    this.longitudePosition,
    this.firebasePassword,
    this.groups,
    this.userPermissions,
    required profileDescription,
    required suspensionDays,
    required cnicFront,
    required cnicBack,
    required totalIncome,
    required monthlyIncome,
    required deductions,
    required visitingCharges,
    required rating,
    required availabilityHours,
    required level,
    required bankDetails,
    required balance,
    required onlineStatus,
    required instagramLink,
    required facebookLink,
    required twitterLink,
    required cnicVerified,
    required letterHeadVerified,
    required shopVisitingCardVerified,
    required emailVerified,
    required artificialOfAssociationVerified,
    required certificateOfIncorporationVerified,
    required profilePictureVerified,
    required incorporateDocumentVerified,
    required memberOfAssociationVerified,
    required soleProprietorDocumentVerified,
    required letterHeadUrl,
    required shopVisitingCardUrl,
    required certificateOfIncorporationUrl,
    required artificialOfAssociationUrl,
    required memberOfAssociationUrl,
    required incorporateDocumentUrl,
    required soleProprietorDocumentUrl,
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
        suspensionDays: json["suspension_days"], // Add if required
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
        languages: json["languages"] == null
            ? []
            : List<String>.from(json["languages"]!.map((x) => x.toString())),
        designation: json["designation"],
        address: json["address"],
        latitudePosition: json["latitude_position"],
        longitudePosition: json["longitude_position"],
        profileDescription:
            json["profile_description"], // Update to profileDescription
        cnicFront: json["cnic_front"],
        cnicBack: json["cnic_back"],
        totalIncome: json["total_income"], // Add if required
        monthlyIncome: json["monthly_income"], // Add if required
        deductions: json["deductions"], // Add if required
        rating: json["rating"], // Add if required
        visitingCharges: json["visiting_charges"], // Add if required
        availabilityHours:
            json["availability_hours"], // Update to appropriate type
        level: json["level"], // Add if required
        balance: json["balance"], // Add if required
        bankDetails: json["bank_details"],
        onlineStatus: json["online_status"], // Add if required
        facebookLink: json["facebook_link"],
        instagramLink: json["instagram_link"],
        twitterLink: json["twitter_link"],
        letterHeadVerified: json["letter_head_verified"],
        cnicVerified: json["cnic_verified"],
        profilePictureVerified: json["profile_picture_verified"],
        shopVisitingCardVerified: json["shop_visiting_card_verified"],
        emailVerified: json["email_verified"],
        certificateOfIncorporationVerified:
            json["certificate_of_incorporation_verified"],
        artificialOfAssociationVerified:
            json["artificial_of_association_verified"],
        memberOfAssociationVerified: json["member_of_association_verified"],
        incorporateDocumentVerified: json["incorporate_document_verified"],
        soleProprietorDocumentVerified:
            json["sole_proprietor_document_verified"],
        letterHeadUrl: json["letter_head_url"], // Add if required
        shopVisitingCardUrl: json["shop_visiting_card_url"], // Add if required
        certificateOfIncorporationUrl:
            json["certificate_of_incorporation_url"], // Add if required
        artificialOfAssociationUrl:
            json["artificial_of_association_url"], // Add if required
        memberOfAssociationUrl:
            json["member_of_association_url"], // Add if required
        incorporateDocumentUrl:
            json["incorporate_document_url"], // Add if required
        soleProprietorDocumentUrl:
            json["sole_proprietor_document_url"], // Add if required
        groups: json["groups"] == null
            ? []
            : List<int>.from(json["groups"]!.map((x) => x)),
        userPermissions: json["user_permissions"] == null
            ? []
            : List<int>.from(json["user_permissions"]!.map((x) => x)),
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
        "suspension_days": suspensionDays, // Add if required
        "is_staff": isStaff,
        "is_active": isActive,
        "notifications_enabled": notificationsEnabled?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "gender": gender,
        "languages": languages == null
            ? []
            : List<dynamic>.from(languages!.map((x) => x)),
        "designation": designation,
        "address": address,
        "latitude_position": latitudePosition,
        "longitude_position": longitudePosition,
        "profile_description":
            profileDescription, // Update to profileDescription
        "cnic_front": cnicFront,
        "cnic_back": cnicBack,
        "total_income": totalIncome, // Add if required
        "monthly_income": monthlyIncome, // Add if required
        "deductions": deductions, // Add if required
        "rating": rating, // Add if required
        "visiting_charges": visitingCharges, // Add if required
        "availability_hours": availabilityHours, // Update to appropriate type
        "level": level, // Add if required
        "balance": balance, // Add if required
        "bank_details": bankDetails,
        "online_status": onlineStatus, // Add if required
        "facebook_link": facebookLink,
        "instagram_link": instagramLink,
        "twitter_link": twitterLink,
        "letter_head_verified": letterHeadVerified,
        "cnic_verified": cnicVerified,
        "profile_picture_verified": profilePictureVerified,
        "shop_visiting_card_verified": shopVisitingCardVerified,
        "email_verified": emailVerified,
        "certificate_of_incorporation_verified":
            certificateOfIncorporationVerified,
        "artificial_of_association_verified": artificialOfAssociationVerified,
        "member_of_association_verified": memberOfAssociationVerified,
        "incorporate_document_verified": incorporateDocumentVerified,
        "sole_proprietor_document_verified": soleProprietorDocumentVerified,
        "letter_head_url": letterHeadUrl, // Add if required
        "shop_visiting_card_url": shopVisitingCardUrl, // Add if required
        "certificate_of_incorporation_url":
            certificateOfIncorporationUrl, // Add if required
        "artificial_of_association_url":
            artificialOfAssociationUrl, // Add if required
        "member_of_association_url": memberOfAssociationUrl, // Add if required
        "incorporate_document_url": incorporateDocumentUrl, // Add if required
        "sole_proprietor_document_url":
            soleProprietorDocumentUrl, // Add if required
        "groups":
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "user_permissions": userPermissions == null
            ? []
            : List<dynamic>.from(userPermissions!.map((x) => x)),
      };
}

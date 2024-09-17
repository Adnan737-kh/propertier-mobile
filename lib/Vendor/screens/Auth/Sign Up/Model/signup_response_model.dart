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
  String? identifier;
  String? profilePicture;
  String? coverPhoto;
  String? type;
  String? accountStatus;
  int? suspensionDays;
  bool? isStaff;
  bool? isActive;
  NotificationsEnabled? notificationsEnabled;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? gender;
  List<String>? languages;
  String? designation;
  String? address;
  String? latitudePosition;
  String? longitudePosition;
  String? profiledescription;
  String? cnicFront;
  String? cnicBack;
  int? totalIncome;
  int? monthlyIncome;
  int? deductions;
  int? rating;
  int? visitingCharges;
  String? availabilityHours;
  int? level;
  int? balance;
  String? bankDetails;
  bool? onlineStatus;
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
  String? letterHeadUrl; // New field
  String? shopVisitingCardUrl; // New field
  String? certificateOfIncorporationUrl; // New field
  String? artificialOfAssociationUrl; // New field
  String? memberOfAssociationUrl; // New field
  String? incorporateDocumentUrl; // New field
  String? soleProprietorDocumentUrl; // New field
  List<int>? groups;
  List<int>? userPermissions;

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
    this.identifier,
    this.profilePicture,
    this.coverPhoto,
    this.type,
    this.accountStatus,
    this.suspensionDays,
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
    this.profiledescription,
    this.cnicFront,
    this.cnicBack,
    this.totalIncome,
    this.monthlyIncome,
    this.deductions,
    this.rating,
    this.visitingCharges,
    this.availabilityHours,
    this.level,
    this.balance,
    this.bankDetails,
    this.onlineStatus,
    this.facebookLink,
    this.instagramLink,
    this.twitterLink,
    this.letterHeadVerified,
    this.cnicVerified,
    this.profilePictureVerified,
    this.shopVisitingCardVerified,
    this.emailVerified,
    this.certificateOfIncorporationVerified,
    this.artificialOfAssociationVerified,
    this.memberOfAssociationVerified,
    this.incorporateDocumentVerified,
    this.soleProprietorDocumentVerified,
    this.letterHeadUrl, // New field
    this.shopVisitingCardUrl, // New field
    this.certificateOfIncorporationUrl, // New field
    this.artificialOfAssociationUrl, // New field
    this.memberOfAssociationUrl, // New field
    this.incorporateDocumentUrl, // New field
    this.soleProprietorDocumentUrl, // New field
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
        identifier: json["identifier"],
        profilePicture: json["profile_picture_url"],
        coverPhoto: json["cover_photo_url"],
        type: json["type"],
        accountStatus: json["account_status"],
        suspensionDays: json["suspension_days"],
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
            : List<String>.from(json["languages"]!.map((x) => x)),
        designation: json["designation"],
        address: json["address"],
        latitudePosition: json["latitude_position"],
        longitudePosition: json["longitude_position"],
        profiledescription: json["profile_description"],
        cnicFront: json["cnic_front_url"],
        cnicBack: json["cnic_back_url"],
        totalIncome: json["total_income"],
        monthlyIncome: json["monthly_income"],
        deductions: json["deductions"],
        rating: json["rating"],
        visitingCharges: json["visiting_charges"],
        availabilityHours: json["availability_hours"],
        level: json["level"],
        balance: json["balance"],
        bankDetails: json["bank_account_details"],
        onlineStatus: json["online_status"],
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
        letterHeadUrl: json["letter_head_url"], // New field
        shopVisitingCardUrl: json["shop_visiting_card_url"], // New field
        certificateOfIncorporationUrl:
            json["certificate_of_incorporation_url"], // New field
        artificialOfAssociationUrl:
            json["artificial_of_association_url"], // New field
        memberOfAssociationUrl: json["member_of_association_url"], // New field
        incorporateDocumentUrl: json["incorporate_document_url"], // New field
        soleProprietorDocumentUrl:
            json["sole_proprietor_document_url"], // New field
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
        "identifier": identifier,
        "profile_picture_url": profilePicture,
        "cover_photo_url": coverPhoto,
        "type": type,
        "account_status": accountStatus,
        "suspension_days": suspensionDays,
        "is_staff": isStaff,
        "is_active": isActive,
        "notifications_enabled": notificationsEnabled?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "gender": gender,
        "languages": languages == null
            ? []
            : List<String>.from(languages!.map((x) => x)),
        "designation": designation,
        "address": address,
        "latitude_position": latitudePosition,
        "longitude_position": longitudePosition,
        "profile_description": profiledescription,
        "cnic_front_url": cnicFront,
        "cnic_back_url": cnicBack,
        "total_income": totalIncome,
        "monthly_income": monthlyIncome,
        "deductions": deductions,
        "rating": rating,
        "visiting_charges": visitingCharges,
        "availability_hours": availabilityHours,
        "level": level,
        "balance": balance,
        "bank_account_details": bankDetails,
        "online_status": onlineStatus,
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
        "letter_head_url": letterHeadUrl, // New field
        "shop_visiting_card_url": shopVisitingCardUrl, // New field
        "certificate_of_incorporation_url":
            certificateOfIncorporationUrl, // New field
        "artificial_of_association_url":
            artificialOfAssociationUrl, // New field
        "member_of_association_url": memberOfAssociationUrl, // New field
        "incorporate_document_url": incorporateDocumentUrl, // New field
        "sole_proprietor_document_url": soleProprietorDocumentUrl, // New field
        "groups": groups == null ? [] : List<int>.from(groups!.map((x) => x)),
        "user_permissions": userPermissions == null
            ? []
            : List<int>.from(userPermissions!.map((x) => x)),
      };
}

class NotificationsEnabled {
  NotificationsEnabled();

  factory NotificationsEnabled.fromJson(Map<String, dynamic> json) =>
      NotificationsEnabled();

  Map<String, dynamic> toJson() => {};
}

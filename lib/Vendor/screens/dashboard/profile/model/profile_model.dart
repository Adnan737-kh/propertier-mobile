// class ProfileModel {
//   int? id;

//   String? name;
//   String? about;
//   String? phoneNumberCountryCode;
//   String? phoneNumber;
//   String? email;
//   String? profilePictureUrl;
//   String? coverPhotoUrl;
//   String? type;
//   String? accountStatus;
//   bool? isStaff;
//   bool? isActive;
//   // NotificationsEnabled? notificationsEnabled;
//   String? createdAt;
//   String? updatedAt;
//   String? gender;
//   String? language;
//   String? designation;
//   String? address;
//   String? latitudePosition;
//   String? longitudePosition;
//   String? profileDescription;
//   String? cnicFrontUrl;
//   String? cnicBackUrl;

//   String? bankAccountDetails;
//   int? totalIncome;
//   int? monthlyIncome;
//   int? deductions;
//   int? rating;
//   int? visitingCharges;
//   String? availabilityHours;
//   int? level;
//   int? balance;
//   bool? onlineStatus;
//   String? facebookLink;
//   String? instagramLink;
//   String? twitterLink;
//   bool? letterHeadVerified;
//   bool? cnicVerified;
//   bool? profilePictureVerified;
//   bool? shopVisitingCardVerified;
//   List<int>? followers;
//   List<int>? likes;

//   ProfileModel(
//       {this.id,
//       this.name,
//       this.about,
//       this.phoneNumberCountryCode,
//       this.phoneNumber,
//       this.email,
//       this.profilePictureUrl,
//       this.coverPhotoUrl,
//       this.type,
//       this.accountStatus,
//       this.isStaff,
//       this.isActive,
//       // this.notificationsEnabled,
//       this.createdAt,
//       this.updatedAt,
//       this.gender,
//       this.language,
//       this.designation,
//       this.address,
//       this.latitudePosition,
//       this.longitudePosition,
//       this.profileDescription,
//       this.cnicFrontUrl,
//       this.cnicBackUrl,
//       this.bankAccountDetails,
//       this.totalIncome,
//       this.monthlyIncome,
//       this.deductions,
//       this.rating,
//       this.visitingCharges,
//       this.availabilityHours,
//       this.level,
//       this.balance,
//       this.onlineStatus,
//       this.facebookLink,
//       this.instagramLink,
//       this.twitterLink,
//       this.letterHeadVerified,
//       this.cnicVerified,
//       this.profilePictureVerified,
//       this.shopVisitingCardVerified,
//       this.followers,
//       this.likes});

//   ProfileModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];

//     name = json['name'];
//     about = json['about'];
//     phoneNumberCountryCode = json['phone_number_country_code'];
//     phoneNumber = json['phone_number'];
//     email = json['email'];
//     profilePictureUrl = json['profile_picture_url'];
//     coverPhotoUrl = json['cover_photo_url'];
//     type = json['type'];
//     accountStatus = json['account_status'];
//     isStaff = json['is_staff'];
//     isActive = json['is_active'];
//     // notificationsEnabled = json['notifications_enabled'] != null ? NotificationsEnabled.fromJson(json['notifications_enabled']) : null;
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     gender = json['gender'];
//     language = json['language'];
//     designation = json['designation'];
//     address = json['address'];
//     latitudePosition = json['latitude_position'];
//     longitudePosition = json['longitude_position'];
//     profileDescription = json['profile_description'];
//     cnicFrontUrl = json['cnic_front_url'];
//     cnicBackUrl = json['cnic_back_url'];
//     bankAccountDetails = json['bank_account_details'];
//     totalIncome = json['total_income'];
//     monthlyIncome = json['monthly_income'];
//     deductions = json['deductions'];
//     rating = json['rating'];
//     visitingCharges = json['visiting_charges'];
//     availabilityHours = json['availability_hours'];
//     level = json['level'];
//     balance = json['balance'];
//     onlineStatus = json['online_status'];
//     facebookLink = json['facebook_link'];
//     instagramLink = json['instagram_link'];
//     twitterLink = json['twitter_link'];
//     letterHeadVerified = json['letter_head_verified'];
//     cnicVerified = json['cnic_verified'];
//     profilePictureVerified = json['profile_picture_verified'];
//     shopVisitingCardVerified = json['shop_visiting_card_verified'];

//     followers = json['followers'].cast<int>();
//     likes = json['likes'].cast<int>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['id'] = id;

//     data['name'] = name;
//     data['about'] = about;
//     data['phone_number_country_code'] = phoneNumberCountryCode;
//     data['phone_number'] = phoneNumber;
//     data['email'] = email;
//     data['profile_picture_url'] = profilePictureUrl;
//     data['cover_photo_url'] = coverPhotoUrl;
//     data['type'] = type;
//     data['account_status'] = accountStatus;
//     data['is_staff'] = isStaff;
//     data['is_active'] = isActive;
//     // if (notificationsEnabled != null) {
//     //   data['notifications_enabled'] = notificationsEnabled!.toJson();
//     // }
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['gender'] = gender;
//     data['language'] = language;
//     data['designation'] = designation;
//     data['address'] = address;
//     data['latitude_position'] = latitudePosition;
//     data['longitude_position'] = longitudePosition;
//     data['profile_description'] = profileDescription;
//     data['cnic_front_url'] = this.cnicFrontUrl;
//     data['cnic_back_url'] = this.cnicBackUrl;

//     data['bank_account_details'] = bankAccountDetails;
//     data['total_income'] = totalIncome;
//     data['monthly_income'] = monthlyIncome;
//     data['deductions'] = deductions;
//     data['rating'] = rating;
//     data['visiting_charges'] = visitingCharges;
//     data['availability_hours'] = availabilityHours;
//     data['level'] = level;
//     data['balance'] = balance;
//     data['online_status'] = onlineStatus;
//     data['facebook_link'] = facebookLink;
//     data['instagram_link'] = instagramLink;
//     data['twitter_link'] = twitterLink;
//     data['letter_head_verified'] = letterHeadVerified;
//     data['cnic_verified'] = cnicVerified;
//     data['profile_picture_verified'] = profilePictureVerified;
//     data['shop_visiting_card_verified'] = shopVisitingCardVerified;
//     data['followers'] = followers;
//     data['likes'] = likes;
//     return data;
//   }
// }

// // class NotificationsEnabled {

// // 	NotificationsEnabled({super.key});

// // 	NotificationsEnabled.fromJson(Map<String, dynamic> json) {
// // 	}

// // 	Map<String, dynamic> toJson() {
// // 		final Map<String, dynamic> data = Map<String, dynamic>();
// // 		return data;
// // 	}
// // }
class ProfileModel {
  int? id;
  bool? isSuperuser;
  String? firebaseId;
  String? name;
  String? about;
  String? phoneNumberCountryCode;
  String? phoneNumber;
  String? email;
  String? profilePictureUrl;
  String? coverPhotoUrl;
  String? type;
  String? accountStatus;
  bool? isStaff;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? gender;
  String? language;
  String? designation;
  String? address;
  String? latitudePosition;
  String? longitudePosition;
  String? profileDescription;
  String? cnicFrontUrl;
  String? cnicBackUrl;
  String? letterHeadUrl;
  String? shopVisitingCardUrl;
  String? certificateOfIncorporationUrl;
  String? artificialOfAssociationUrl;
  String? memberOfAssociationUrl;
  String? incorporateDocumentUrl;
  String? solePropertiierDocumentUrl;
  String? bankAccountDetails;
  int? totalIncome;
  int? monthlyIncome;
  int? deductions;
  int? rating;
  int? visitingCharges;
  String? availabilityHours;
  int? level;
  int? balance;
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
  bool? solePropertiierDocumentVerified;
  List<int>? followers;
  List<int>? likes;

  ProfileModel({
    this.id,
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
    this.letterHeadUrl,
    this.shopVisitingCardUrl,
    this.certificateOfIncorporationUrl,
    this.artificialOfAssociationUrl,
    this.memberOfAssociationUrl,
    this.incorporateDocumentUrl,
    this.solePropertiierDocumentUrl,
    this.bankAccountDetails,
    this.totalIncome,
    this.monthlyIncome,
    this.deductions,
    this.rating,
    this.visitingCharges,
    this.availabilityHours,
    this.level,
    this.balance,
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
    this.solePropertiierDocumentVerified,
    this.followers,
    this.likes,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSuperuser = json['is_superuser'];
    firebaseId = json['firebase_id'];
    name = json['name'];
    about = json['about'];
    phoneNumberCountryCode = json['phone_number_country_code'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    profilePictureUrl = json['profile_picture_url'];
    coverPhotoUrl = json['cover_photo_url'];
    type = json['type'];
    accountStatus = json['account_status'];
    isStaff = json['is_staff'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    gender = json['gender'];
    language = json['language'];
    designation = json['designation'];
    address = json['address'];
    latitudePosition = json['latitude_position'];
    longitudePosition = json['longitude_position'];
    profileDescription = json['profile_description'];
    cnicFrontUrl = json['cnic_front_url'];
    cnicBackUrl = json['cnic_back_url'];
    letterHeadUrl = json['letter_head_url'];
    shopVisitingCardUrl = json['shop_visiting_card_url'];
    certificateOfIncorporationUrl = json['certificate_of_incorporation_url'];
    artificialOfAssociationUrl = json['artificial_of_association_url'];
    memberOfAssociationUrl = json['member_of_association_url'];
    incorporateDocumentUrl = json['incorporate_document_url'];
    solePropertiierDocumentUrl = json['sole_propertiier_document_url'];
    bankAccountDetails = json['bank_account_details'];
    totalIncome = json['total_income'];
    monthlyIncome = json['monthly_income'];
    deductions = json['deductions'];
    rating = json['rating'];
    visitingCharges = json['visiting_charges'];
    availabilityHours = json['availability_hours'];
    level = json['level'];
    balance = json['balance'];
    onlineStatus = json['online_status'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    twitterLink = json['twitter_link'];
    letterHeadVerified = json['letter_head_verified'];
    cnicVerified = json['cnic_verified'];
    profilePictureVerified = json['profile_picture_verified'];
    shopVisitingCardVerified = json['shop_visiting_card_verified'];
    emailVerified = json['email_verified'];
    certificateOfIncorporationVerified =
        json['certificate_of_incorporation_verified'];
    artificialOfAssociationVerified =
        json['artificial_of_association_verified'];
    memberOfAssociationVerified = json['member_of_association_verified'];
    incorporateDocumentVerified = json['incorporate_document_verified'];
    solePropertiierDocumentVerified =
        json['sole_propertiier_document_verified'];

    followers =
        json['followers'] != null ? List<int>.from(json['followers']) : [];
    likes = json['likes'] != null ? List<int>.from(json['likes']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_superuser'] = isSuperuser;
    data['firebase_id'] = firebaseId;
    data['name'] = name;
    data['about'] = about;
    data['phone_number_country_code'] = phoneNumberCountryCode;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['profile_picture_url'] = profilePictureUrl;
    data['cover_photo_url'] = coverPhotoUrl;
    data['type'] = type;
    data['account_status'] = accountStatus;
    data['is_staff'] = isStaff;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['gender'] = gender;
    data['language'] = language;
    data['designation'] = designation;
    data['address'] = address;
    data['latitude_position'] = latitudePosition;
    data['longitude_position'] = longitudePosition;
    data['profile_description'] = profileDescription;
    data['cnic_front_url'] = cnicFrontUrl;
    data['cnic_back_url'] = cnicBackUrl;
    data['letter_head_url'] = letterHeadUrl;
    data['shop_visiting_card_url'] = shopVisitingCardUrl;
    data['certificate_of_incorporation_url'] = certificateOfIncorporationUrl;
    data['artificial_of_association_url'] = artificialOfAssociationUrl;
    data['member_of_association_url'] = memberOfAssociationUrl;
    data['incorporate_document_url'] = incorporateDocumentUrl;
    data['sole_propertiier_document_url'] = solePropertiierDocumentUrl;
    data['bank_account_details'] = bankAccountDetails;
    data['total_income'] = totalIncome;
    data['monthly_income'] = monthlyIncome;
    data['deductions'] = deductions;
    data['rating'] = rating;
    data['visiting_charges'] = visitingCharges;
    data['availability_hours'] = availabilityHours;
    data['level'] = level;
    data['balance'] = balance;
    data['online_status'] = onlineStatus;
    data['facebook_link'] = facebookLink;
    data['instagram_link'] = instagramLink;
    data['twitter_link'] = twitterLink;
    data['letter_head_verified'] = letterHeadVerified;
    data['cnic_verified'] = cnicVerified;
    data['profile_picture_verified'] = profilePictureVerified;
    data['shop_visiting_card_verified'] = shopVisitingCardVerified;
    data['email_verified'] = emailVerified;
    data['certificate_of_incorporation_verified'] =
        certificateOfIncorporationVerified;
    data['artificial_of_association_verified'] =
        artificialOfAssociationVerified;
    data['member_of_association_verified'] = memberOfAssociationVerified;
    data['incorporate_document_verified'] = incorporateDocumentVerified;
    data['sole_propertiier_document_verified'] =
        solePropertiierDocumentVerified;

    data['followers'] = followers;
    data['likes'] = likes;
    return data;
  }
}

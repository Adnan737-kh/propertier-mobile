import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  @JsonKey(name: 'last_login')
  final dynamic lastLogin;
  @JsonKey(name: 'is_superuser')
  final bool? isSuperuser;
  @JsonKey(name: 'firebase_id')
  final String? firebaseId;
  @JsonKey(name: 'full_name')
  final String? name;
  final dynamic about;
  @JsonKey(name: 'phone_number_country_code')
  final String? phoneNumberCountryCode;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? email;
  final dynamic identifier;
  @JsonKey(name: 'profile_picture_url')
  final String? profilePictureUrl;
  @JsonKey(name: 'cover_photo_url')
  final String? coverPhotoUrl;
  @JsonKey(name: 'type')
  final String? type;
  @JsonKey(name: 'account_status')
  final String? accountStatus;
  @JsonKey(name: 'suspension_days')
  final dynamic suspensionDays;
  @JsonKey(name: 'is_staff')
  final bool? isStaff;
  @JsonKey(name: 'is_active')
  final bool? isActive;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'gender')
  final dynamic gender;
  final List<dynamic>? languages;
  final dynamic designation;
  final String? address;
  @JsonKey(name: 'latitude_position')
  final String? latitudePosition;
  @JsonKey(name: 'longitude_position')
  final String? longitudePosition;
  @JsonKey(name: 'profile_description')
  final dynamic profileDescription;
  @JsonKey(name: 'cnic_front_url')
  final dynamic cnicFrontUrl;
  @JsonKey(name: 'cnic_back_url')
  final dynamic cnicBackUrl;
  @JsonKey(name: 'total_income')
  final int? totalIncome;
  @JsonKey(name: 'monthly_income')
  final int? monthlyIncome;
  @JsonKey(name: 'deductions')
  final int? deductions;
  @JsonKey(name: 'rating')
  final int? rating;
  @JsonKey(name: 'visiting_charges')
  final int? visitingCharges;
  @JsonKey(name: 'availability_hours')
  final String? availabilityHours;
  final int? level;
  final int? balance;
  @JsonKey(name: 'bank_details')
  final String? bankDetails;
  @JsonKey(name: 'online_status')
  final bool? onlineStatus;
  @JsonKey(name: 'facebook_link')
  final String? facebookLink;
  @JsonKey(name: 'instagram_link')
  final String? instagramLink;
  @JsonKey(name: 'twitter_link')
  final String? twitterLink;
  @JsonKey(name: 'letter_head_verified')
  final bool? letterHeadVerified;
  @JsonKey(name: 'cnic_verified')
  final bool? cnicVerified;
  @JsonKey(name: 'profile_picture_verified')
  final bool? profilePictureVerified;
  @JsonKey(name: 'shop_visiting_card_verified')
  final bool? shopVisitingCardVerified;
  @JsonKey(name: 'email_verified')
  final bool? emailVerified;
  @JsonKey(name: 'certificate_of_incorporation_verified')
  final bool? certificateOfIncorporationVerified;
  @JsonKey(name: 'artificial_of_association_verified')
  final bool? artificialOfAssociationVerified;
  @JsonKey(name: 'member_of_association_verified')
  final bool? memberOfAssociationVerified;
  @JsonKey(name: 'incorporate_document_verified')
  final bool? incorporateDocumentVerified;
  @JsonKey(name: 'sole_proprietor_document_verified')
  final bool? soleProprietorDocumentVerified;
  @JsonKey(name: 'letter_head_url')
  final String? letterHeadUrl;
  @JsonKey(name: 'shop_visiting_card_url')
  final String? shopVisitingCardUrl;
  @JsonKey(name: 'certificate_of_incorporation_url')
  final String? certificateOfIncorporationUrl;
  @JsonKey(name: 'artificial_of_association_url')
  final String? artificialOfAssociationUrl;
  @JsonKey(name: 'member_of_association_url')
  final String? memberOfAssociationUrl;
  @JsonKey(name: 'incorporate_document_url')
  final String? incorporateDocumentUrl;
  @JsonKey(name: 'sole_proprietor_document_url')
  final String? soleProprietorDocumentUrl;
  @JsonKey(name: 'notifications_enabled')
  final bool? notificationsEnabled;
  final List<int>? groups;
  @JsonKey(name: 'user_permissions')
  final List<int>? userPermissions;
  final  List<int>? followers;
  final List<int>? likes;

  const User({
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
    this.profilePictureUrl,
    this.coverPhotoUrl,
    this.type,
    this.accountStatus,
    this.suspensionDays,
    this.isStaff,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.gender,
    this.languages,
    this.designation,
    this.address,
    this.latitudePosition,
    this.longitudePosition,
    this.profileDescription,
    this.cnicFrontUrl,
    this.cnicBackUrl,
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
    this.letterHeadUrl,
    this.shopVisitingCardUrl,
    this.certificateOfIncorporationUrl,
    this.artificialOfAssociationUrl,
    this.memberOfAssociationUrl,
    this.incorporateDocumentUrl,
    this.soleProprietorDocumentUrl,
    this.notificationsEnabled,
    this.groups,
    this.userPermissions,
    this.followers,
    this.likes,
  });

  @override
  String toString() {
    return 'User(id: $id, lastLogin: $lastLogin, isSuperuser: $isSuperuser, firebaseId: $firebaseId, full_name: $name, about: $about, phoneNumberCountryCode: $phoneNumberCountryCode, phoneNumber: $phoneNumber, email: $email, identifier: $identifier, profilePictureUrl: $profilePictureUrl, coverPhotoUrl: $coverPhotoUrl, type: $type, accountStatus: $accountStatus, suspensionDays: $suspensionDays, isStaff: $isStaff, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, gender: $gender, languages: $languages, designation: $designation, address: $address, latitudePosition: $latitudePosition, longitudePosition: $longitudePosition, profileDescription: $profileDescription, cnicFrontUrl: $cnicFrontUrl, cnicBackUrl: $cnicBackUrl, totalIncome: $totalIncome, monthlyIncome: $monthlyIncome, deductions: $deductions, rating: $rating, visitingCharges: $visitingCharges, availabilityHours: $availabilityHours, level: $level, balance: $balance, bankDetails: $bankDetails, onlineStatus: $onlineStatus, facebookLink: $facebookLink, instagramLink: $instagramLink, twitterLink: $twitterLink, letterHeadVerified: $letterHeadVerified, cnicVerified: $cnicVerified, profilePictureVerified: $profilePictureVerified, shopVisitingCardVerified: $shopVisitingCardVerified, emailVerified: $emailVerified, certificateOfIncorporationVerified: $certificateOfIncorporationVerified, artificialOfAssociationVerified: $artificialOfAssociationVerified, memberOfAssociationVerified: $memberOfAssociationVerified, incorporateDocumentVerified: $incorporateDocumentVerified, soleProprietorDocumentVerified: $soleProprietorDocumentVerified, letterHeadUrl: $letterHeadUrl, shopVisitingCardUrl: $shopVisitingCardUrl, certificateOfIncorporationUrl: $certificateOfIncorporationUrl, artificialOfAssociationUrl: $artificialOfAssociationUrl, memberOfAssociationUrl: $memberOfAssociationUrl, incorporateDocumentUrl: $incorporateDocumentUrl, soleProprietorDocumentUrl: $soleProprietorDocumentUrl, notificationsEnabled: $notificationsEnabled, groups: $groups, userPermissions: $userPermissions, followers: $followers, likes: $likes)';
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    int? id,
    dynamic lastLogin,
    bool? isSuperuser,
    String? firebaseId,
    String? name,
    dynamic about,
    String? phoneNumberCountryCode,
    String? phoneNumber,
    String? email,
    dynamic identifier,
    String? profilePictureUrl,
    String? coverPhotoUrl,
    String? type,
    String? accountStatus,
    dynamic suspensionDays,
    bool? isStaff,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    dynamic gender,
    List<dynamic>? languages,
    dynamic designation,
    String? address,
    String? latitudePosition,
    String? longitudePosition,
    dynamic profileDescription,
    dynamic cnicFrontUrl,
    dynamic cnicBackUrl,
    int? totalIncome,
    int? monthlyIncome,
    int? deductions,
    int? rating,
    int? visitingCharges,
    String? availabilityHours,
    int? level,
    int? balance,
    String? bankDetails,
    bool? onlineStatus,
    String? facebookLink,
    String? instagramLink,
    String? twitterLink,
    bool? letterHeadVerified,
    bool? cnicVerified,
    bool? profilePictureVerified,
    bool? shopVisitingCardVerified,
    bool? emailVerified,
    bool? certificateOfIncorporationVerified,
    bool? artificialOfAssociationVerified,
    bool? memberOfAssociationVerified,
    bool? incorporateDocumentVerified,
    bool? soleProprietorDocumentVerified,
    String? letterHeadUrl,
    String? shopVisitingCardUrl,
    String? certificateOfIncorporationUrl,
    String? artificialOfAssociationUrl,
    String? memberOfAssociationUrl,
    String? incorporateDocumentUrl,
    String? soleProprietorDocumentUrl,
    bool? notificationsEnabled,
    List<int>? groups,
    List<int>? userPermissions,
    List<int>? followers,
    List<int>? likes,
  }) {
    return User(
      id: id ?? this.id,
      lastLogin: lastLogin ?? this.lastLogin,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      firebaseId: firebaseId ?? this.firebaseId,
      name: name ?? this.name,
      about: about ?? this.about,
      phoneNumberCountryCode: phoneNumberCountryCode ?? this.phoneNumberCountryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      identifier: identifier ?? this.identifier,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      coverPhotoUrl: coverPhotoUrl ?? this.coverPhotoUrl,
      type: type ?? this.type,
      accountStatus: accountStatus ?? this.accountStatus,
      suspensionDays: suspensionDays ?? this.suspensionDays,
      isStaff: isStaff ?? this.isStaff,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      gender: gender ?? this.gender,
      languages: languages ?? this.languages,
      designation: designation ?? this.designation,
      address: address ?? this.address,
      latitudePosition: latitudePosition ?? this.latitudePosition,
      longitudePosition: longitudePosition ?? this.longitudePosition,
      profileDescription: profileDescription ?? this.profileDescription,
      cnicFrontUrl: cnicFrontUrl ?? this.cnicFrontUrl,
      cnicBackUrl: cnicBackUrl ?? this.cnicBackUrl,
      totalIncome: totalIncome ?? this.totalIncome,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      deductions: deductions ?? this.deductions,
      rating: rating ?? this.rating,
      visitingCharges: visitingCharges ?? this.visitingCharges,
      availabilityHours: availabilityHours ?? this.availabilityHours,
      level: level ?? this.level,
      balance: balance ?? this.balance,
      bankDetails: bankDetails ?? this.bankDetails,
      onlineStatus: onlineStatus ?? this.onlineStatus,
      facebookLink: facebookLink ?? this.facebookLink,
      instagramLink: instagramLink ?? this.instagramLink,
      twitterLink: twitterLink ?? this.twitterLink,
      letterHeadVerified: letterHeadVerified ?? this.letterHeadVerified,
      cnicVerified: cnicVerified ?? this.cnicVerified,
      profilePictureVerified: profilePictureVerified ?? this.profilePictureVerified,
      shopVisitingCardVerified: shopVisitingCardVerified ?? this.shopVisitingCardVerified,
      emailVerified: emailVerified ?? this.emailVerified,
      certificateOfIncorporationVerified: certificateOfIncorporationVerified ?? this.certificateOfIncorporationVerified,
      artificialOfAssociationVerified: artificialOfAssociationVerified ?? this.artificialOfAssociationVerified,
      memberOfAssociationVerified: memberOfAssociationVerified ?? this.memberOfAssociationVerified,
      incorporateDocumentVerified: incorporateDocumentVerified ?? this.incorporateDocumentVerified,
      soleProprietorDocumentVerified: soleProprietorDocumentVerified ?? this.soleProprietorDocumentVerified,
      letterHeadUrl: letterHeadUrl ?? this.letterHeadUrl,
      shopVisitingCardUrl: shopVisitingCardUrl ?? this.shopVisitingCardUrl,
      certificateOfIncorporationUrl: certificateOfIncorporationUrl ?? this.certificateOfIncorporationUrl,
      artificialOfAssociationUrl: artificialOfAssociationUrl ?? this.artificialOfAssociationUrl,
      memberOfAssociationUrl: memberOfAssociationUrl ?? this.memberOfAssociationUrl,
      incorporateDocumentUrl: incorporateDocumentUrl ?? this.incorporateDocumentUrl,
      soleProprietorDocumentUrl: soleProprietorDocumentUrl ?? this.soleProprietorDocumentUrl,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      groups: groups ?? this.groups,
      userPermissions: userPermissions ?? this.userPermissions,
      followers: followers ?? this.followers,
      likes: likes ?? this.likes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! User) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      lastLogin.hashCode ^
      isSuperuser.hashCode ^
      firebaseId.hashCode ^
      name.hashCode ^
      about.hashCode ^
      phoneNumberCountryCode.hashCode ^
      phoneNumber.hashCode ^
      email.hashCode ^
      identifier.hashCode ^
      profilePictureUrl.hashCode ^
      coverPhotoUrl.hashCode ^
      type.hashCode ^
      accountStatus.hashCode ^
      suspensionDays.hashCode ^
      isStaff.hashCode ^
      isActive.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      gender.hashCode ^
      languages.hashCode ^
      designation.hashCode ^
      address.hashCode ^
      latitudePosition.hashCode ^
      longitudePosition.hashCode ^
      profileDescription.hashCode ^
      cnicFrontUrl.hashCode ^
      cnicBackUrl.hashCode ^
      totalIncome.hashCode ^
      monthlyIncome.hashCode ^
      deductions.hashCode ^
      rating.hashCode ^
      visitingCharges.hashCode ^
      availabilityHours.hashCode ^
      level.hashCode ^
      balance.hashCode ^
      bankDetails.hashCode ^
      onlineStatus.hashCode ^
      facebookLink.hashCode ^
      instagramLink.hashCode ^
      twitterLink.hashCode ^
      letterHeadVerified.hashCode ^
      cnicVerified.hashCode ^
      profilePictureVerified.hashCode ^
      shopVisitingCardVerified.hashCode ^
      emailVerified.hashCode ^
      certificateOfIncorporationVerified.hashCode ^
      artificialOfAssociationVerified.hashCode ^
      memberOfAssociationVerified.hashCode ^
      incorporateDocumentVerified.hashCode ^
      soleProprietorDocumentVerified.hashCode ^
      letterHeadUrl.hashCode ^
      shopVisitingCardUrl.hashCode ^
      certificateOfIncorporationUrl.hashCode ^
      artificialOfAssociationUrl.hashCode ^
      memberOfAssociationUrl.hashCode ^
      incorporateDocumentUrl.hashCode ^
      soleProprietorDocumentUrl.hashCode ^
      notificationsEnabled.hashCode ^
      groups.hashCode ^
      userPermissions.hashCode ^
      followers.hashCode ^
      likes.hashCode;
}

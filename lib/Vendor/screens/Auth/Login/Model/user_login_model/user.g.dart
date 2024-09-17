// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      lastLogin: json['last_login'],
      isSuperuser: json['is_superuser'] as bool?,
      firebaseId: json['firebase_id'] as String?,
      name: json['name'] as String?,
      about: json['about'],
      phoneNumberCountryCode: json['phone_number_country_code'] as String?,
      phoneNumber: json['phone_number'] as String?,
      email: json['email'] as String?,
      identifier: json['identifier'],
      profilePictureUrl: json['profile_picture_url'] as String?,
      coverPhotoUrl: json['cover_photo_url'] as String?,
      type: json['type'] as String?,
      accountStatus: json['account_status'] as String?,
      suspensionDays: json['suspension_days'],
      isStaff: json['is_staff'] as bool?,
      isActive: json['is_active'] as bool?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      gender: json['gender'],
      languages: json['languages'] as List<dynamic>?,
      designation: json['designation'],
      address: json['address'] as String?,
      latitudePosition: json['latitude_position'] as String?,
      longitudePosition: json['longitude_position'] as String?,
      profileDescription: json['profile_description'],
      cnicFrontUrl: json['cnic_front_url'],
      cnicBackUrl: json['cnic_back_url'],
      totalIncome: (json['total_income'] as num?)?.toInt(),
      monthlyIncome: (json['monthly_income'] as num?)?.toInt(),
      deductions: (json['deductions'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toInt(),
      visitingCharges: (json['visiting_charges'] as num?)?.toInt(),
      availabilityHours: json['availability_hours'] as String?,
      level: (json['level'] as num?)?.toInt(),
      balance: (json['balance'] as num?)?.toInt(),
      bankDetails: json['bank_details'] as String?,
      onlineStatus: json['online_status'] as bool?,
      facebookLink: json['facebook_link'] as String?,
      instagramLink: json['instagram_link'] as String?,
      twitterLink: json['twitter_link'] as String?,
      letterHeadVerified: json['letter_head_verified'] as bool?,
      cnicVerified: json['cnic_verified'] as bool?,
      profilePictureVerified: json['profile_picture_verified'] as bool?,
      shopVisitingCardVerified: json['shop_visiting_card_verified'] as bool?,
      emailVerified: json['email_verified'] as bool?,
      certificateOfIncorporationVerified:
          json['certificate_of_incorporation_verified'] as bool?,
      artificialOfAssociationVerified:
          json['artificial_of_association_verified'] as bool?,
      memberOfAssociationVerified:
          json['member_of_association_verified'] as bool?,
      incorporateDocumentVerified:
          json['incorporate_document_verified'] as bool?,
      soleProprietorDocumentVerified:
          json['sole_proprietor_document_verified'] as bool?,
      letterHeadUrl: json['letter_head_url'] as String?,
      shopVisitingCardUrl: json['shop_visiting_card_url'] as String?,
      certificateOfIncorporationUrl:
          json['certificate_of_incorporation_url'] as String?,
      artificialOfAssociationUrl:
          json['artificial_of_association_url'] as String?,
      memberOfAssociationUrl: json['member_of_association_url'] as String?,
      incorporateDocumentUrl: json['incorporate_document_url'] as String?,
      soleProprietorDocumentUrl:
          json['sole_proprietor_document_url'] as String?,
      notificationsEnabled: json['notifications_enabled'] as bool?,
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      userPermissions: (json['user_permissions'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      followers: (json['followers'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      likes: (json['likes'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'last_login': instance.lastLogin,
      'is_superuser': instance.isSuperuser,
      'firebase_id': instance.firebaseId,
      'name': instance.name,
      'about': instance.about,
      'phone_number_country_code': instance.phoneNumberCountryCode,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'identifier': instance.identifier,
      'profile_picture_url': instance.profilePictureUrl,
      'cover_photo_url': instance.coverPhotoUrl,
      'type': instance.type,
      'account_status': instance.accountStatus,
      'suspension_days': instance.suspensionDays,
      'is_staff': instance.isStaff,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'gender': instance.gender,
      'languages': instance.languages,
      'designation': instance.designation,
      'address': instance.address,
      'latitude_position': instance.latitudePosition,
      'longitude_position': instance.longitudePosition,
      'profile_description': instance.profileDescription,
      'cnic_front_url': instance.cnicFrontUrl,
      'cnic_back_url': instance.cnicBackUrl,
      'total_income': instance.totalIncome,
      'monthly_income': instance.monthlyIncome,
      'deductions': instance.deductions,
      'rating': instance.rating,
      'visiting_charges': instance.visitingCharges,
      'availability_hours': instance.availabilityHours,
      'level': instance.level,
      'balance': instance.balance,
      'bank_details': instance.bankDetails,
      'online_status': instance.onlineStatus,
      'facebook_link': instance.facebookLink,
      'instagram_link': instance.instagramLink,
      'twitter_link': instance.twitterLink,
      'letter_head_verified': instance.letterHeadVerified,
      'cnic_verified': instance.cnicVerified,
      'profile_picture_verified': instance.profilePictureVerified,
      'shop_visiting_card_verified': instance.shopVisitingCardVerified,
      'email_verified': instance.emailVerified,
      'certificate_of_incorporation_verified':
          instance.certificateOfIncorporationVerified,
      'artificial_of_association_verified':
          instance.artificialOfAssociationVerified,
      'member_of_association_verified': instance.memberOfAssociationVerified,
      'incorporate_document_verified': instance.incorporateDocumentVerified,
      'sole_proprietor_document_verified':
          instance.soleProprietorDocumentVerified,
      'letter_head_url': instance.letterHeadUrl,
      'shop_visiting_card_url': instance.shopVisitingCardUrl,
      'certificate_of_incorporation_url':
          instance.certificateOfIncorporationUrl,
      'artificial_of_association_url': instance.artificialOfAssociationUrl,
      'member_of_association_url': instance.memberOfAssociationUrl,
      'incorporate_document_url': instance.incorporateDocumentUrl,
      'sole_proprietor_document_url': instance.soleProprietorDocumentUrl,
      'notifications_enabled': instance.notificationsEnabled,
      'groups': instance.groups,
      'user_permissions': instance.userPermissions,
      'followers': instance.followers,
      'likes': instance.likes,
    };

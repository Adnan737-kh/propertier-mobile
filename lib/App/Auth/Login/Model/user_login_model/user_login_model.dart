class UserLoginModel {
  final String? message;
  final List<User>? users;

  UserLoginModel({this.message, this.users});

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      message: json['message'],
      users: json['users'] != null
          ? (json['users'] as List).map((e) => User.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'users': users?.map((e) => e.toJson()).toList(),
    };
  }
}

class User {
  final int? id;
  final String? lastLogin;
  final bool? isSuperuser;
  final String? firebaseId;
  final String? name;
  final String? about;
  final String? phoneNumberCountryCode;
  final String? phoneNumber;
  final String? email;
  final dynamic identifier;
  final String? profilePictureUrl;
  final String? coverPhotoUrl;
  final String? type;
  final String? accountStatus;
  final dynamic suspensionDays;
  final bool? isStaff;
  final bool? isActive;
  final Map<String, dynamic>? notificationsEnabled;
  final String? createdAt;
  final String? updatedAt;
  final String? gender;
  final List<dynamic>? languages;
  final String? designation;
  final String? address;
  final String? latitudePosition;
  final String? longitudePosition;
  final bool? isErpAdmin;
  final Map<String, dynamic>? erpAdminPrivileges;
  final String? profileDescription;
  final String? cnicFrontUrl;
  final String? cnicBackUrl;
  final int? totalSpending;
  final int? monthlySpending;
  final SavedAddresses? savedAddresses;
  final List<dynamic>? groups;
  final List<dynamic>? userPermissions;
  final List<dynamic>? followers;
  final List<dynamic>? likes;
  final List<dynamic>? erpProjects;

  User({
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
    this.notificationsEnabled,
    this.createdAt,
    this.updatedAt,
    this.gender,
    this.languages,
    this.designation,
    this.address,
    this.latitudePosition,
    this.longitudePosition,
    this.isErpAdmin,
    this.erpAdminPrivileges,
    this.profileDescription,
    this.cnicFrontUrl,
    this.cnicBackUrl,
    this.totalSpending,
    this.monthlySpending,
    this.savedAddresses,
    this.groups,
    this.userPermissions,
    this.followers,
    this.likes,
    this.erpProjects,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      lastLogin: json['last_login'],
      isSuperuser: json['is_superuser'],
      firebaseId: json['firebase_id'],
      name: json['name'],
      about: json['about'],
      phoneNumberCountryCode: json['phone_number_country_code'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      identifier: json['identifier'],
      profilePictureUrl: json['profile_picture_url'],
      coverPhotoUrl: json['cover_photo_url'],
      type: json['type'],
      accountStatus: json['account_status'],
      suspensionDays: json['suspension_days'],
      isStaff: json['is_staff'],
      isActive: json['is_active'],
      notificationsEnabled: json['notifications_enabled'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      gender: json['gender'],
      languages: json['languages'],
      designation: json['designation'],
      address: json['address'],
      latitudePosition: json['latitude_position'],
      longitudePosition: json['longitude_position'],
      isErpAdmin: json['is_erp_admin'],
      erpAdminPrivileges: json['erp_admin_privileges'],
      profileDescription: json['profile_description'],
      cnicFrontUrl: json['cnic_front_url'],
      cnicBackUrl: json['cnic_back_url'],
      totalSpending: json['total_spending'],
      monthlySpending: json['monthly_spending'],
      savedAddresses: json['saved_addresses'] != null
          ? SavedAddresses.fromJson(json['saved_addresses'])
          : null,
      groups: json['groups'] != [] ? null : json['groups'],
      userPermissions:
          json['user_permissions'] != [] ? null : json['user_permissions'],
      followers: json['followers'] != [] ? null : json['followers'],
      likes: json['likes'] != [] ? null : json['likes'],
      erpProjects: json['erp_projects'] != [] ? null : json['erp_projects'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'last_login': lastLogin,
      'is_superuser': isSuperuser,
      'firebase_id': firebaseId,
      'name': name,
      'about': about,
      'phone_number_country_code': phoneNumberCountryCode,
      'phone_number': phoneNumber,
      'email': email,
      'identifier': identifier,
      'profile_picture_url': profilePictureUrl,
      'cover_photo_url': coverPhotoUrl,
      'type': type,
      'account_status': accountStatus,
      'suspension_days': suspensionDays,
      'is_staff': isStaff,
      'is_active': isActive,
      'notifications_enabled': notificationsEnabled,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'gender': gender,
      'languages': languages,
      'designation': designation,
      'address': address,
      'latitude_position': latitudePosition,
      'longitude_position': longitudePosition,
      'is_erp_admin': isErpAdmin,
      'erp_admin_privileges': erpAdminPrivileges,
      'profile_description': profileDescription,
      'cnic_front_url': cnicFrontUrl,
      'cnic_back_url': cnicBackUrl,
      'total_spending': totalSpending,
      'monthly_spending': monthlySpending,
      'saved_addresses': savedAddresses?.toJson(),
      'groups': groups,
      'user_permissions': userPermissions,
      'followers': followers,
      'likes': likes,
      'erp_projects': erpProjects,
    };
  }
}

class SavedAddresses {
  final String? defaultAddress;

  SavedAddresses({this.defaultAddress});

  factory SavedAddresses.fromJson(Map<String, dynamic> json) {
    return SavedAddresses(
      defaultAddress: json['default'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'default': defaultAddress,
    };
  }
}

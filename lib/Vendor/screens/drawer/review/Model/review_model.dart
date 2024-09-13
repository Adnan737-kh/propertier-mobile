class Customer {
  final int id;
  final String? lastLogin;
  final bool isSuperuser;
  final String? firebaseId;
  final String name;
  final String about;
  final String phoneNumberCountryCode;
  final String phoneNumber;
  final String email;
  final String? identifier;
  final String? profilePictureUrl;
  final String? coverPhotoUrl;
  final String type;
  final String accountStatus;
  final int? suspensionDays;
  final bool isStaff;
  final bool isActive;
  final Map<String, dynamic> notificationsEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String gender;
  final List<String> languages;
  final String designation;
  final String address;
  final String latitudePosition;
  final String longitudePosition;
  final String profileDescription;
  final String? cnicFrontUrl;
  final String? cnicBackUrl;
  final double totalSpending;
  final double monthlySpending;
  final Map<String, dynamic> savedAddresses;
  final List<int> followers;
  final List<int> likes;

  Customer({
    required this.id,
    this.lastLogin,
    required this.isSuperuser,
    this.firebaseId,
    required this.name,
    required this.about,
    required this.phoneNumberCountryCode,
    required this.phoneNumber,
    required this.email,
    this.identifier,
    this.profilePictureUrl,
    this.coverPhotoUrl,
    required this.type,
    required this.accountStatus,
    this.suspensionDays,
    required this.isStaff,
    required this.isActive,
    required this.notificationsEnabled,
    required this.createdAt,
    required this.updatedAt,
    required this.gender,
    required this.languages,
    required this.designation,
    required this.address,
    required this.latitudePosition,
    required this.longitudePosition,
    required this.profileDescription,
    this.cnicFrontUrl,
    this.cnicBackUrl,
    required this.totalSpending,
    required this.monthlySpending,
    required this.savedAddresses,
    required this.followers,
    required this.likes,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
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
      notificationsEnabled: json['notifications_enabled'] ?? {},
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      gender: json['gender'],
      languages: List<String>.from(json['languages']),
      designation: json['designation'],
      address: json['address'],
      latitudePosition: json['latitude_position'],
      longitudePosition: json['longitude_position'],
      profileDescription: json['profile_description'],
      cnicFrontUrl: json['cnic_front_url'],
      cnicBackUrl: json['cnic_back_url'],
      totalSpending: (json['total_spending'] as num).toDouble(),
      monthlySpending: (json['monthly_spending'] as num).toDouble(),
      savedAddresses: json['saved_addresses'] ?? {},
      followers: List<int>.from(json['followers']),
      likes: List<int>.from(json['likes']),
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'gender': gender,
      'languages': languages,
      'designation': designation,
      'address': address,
      'latitude_position': latitudePosition,
      'longitude_position': longitudePosition,
      'profile_description': profileDescription,
      'cnic_front_url': cnicFrontUrl,
      'cnic_back_url': cnicBackUrl,
      'total_spending': totalSpending,
      'monthly_spending': monthlySpending,
      'saved_addresses': savedAddresses,
      'followers': followers,
      'likes': likes,
    };
  }
}

class Review {
  final int id;
  final Customer customer;
  final String feedbackType;
  final String message;
  final double rating;
  final bool goodBehaviour;
  final bool workCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int vendor;
  final int order;

  Review({
    required this.id,
    required this.customer,
    required this.feedbackType,
    required this.message,
    required this.rating,
    required this.goodBehaviour,
    required this.workCompleted,
    required this.createdAt,
    required this.updatedAt,
    required this.vendor,
    required this.order,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      customer: Customer.fromJson(json['customer']),
      feedbackType: json['feedback_type'],
      message: json['message'],
      rating: (json['rating'] as num).toDouble(),
      goodBehaviour: json['good_behaviour'],
      workCompleted: json['work_completed'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      vendor: json['vendor'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer.toJson(),
      'feedback_type': feedbackType,
      'message': message,
      'rating': rating,
      'good_behaviour': goodBehaviour,
      'work_completed': workCompleted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'vendor': vendor,
      'order': order,
    };
  }
}

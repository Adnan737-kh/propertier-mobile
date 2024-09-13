class FeatureAd {
  final int id;
  final VendorService vendorService;
  final FeaturePackage featurePackage;
  final String? coverImageUrl;
  final String status;
  final int likes;
  final DateTime createdAt;
  final DateTime updatedAt;

  FeatureAd({
    required this.id,
    required this.vendorService,
    required this.featurePackage,
    required this.coverImageUrl,
    required this.status,
    required this.likes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FeatureAd.fromJson(Map<String, dynamic> json) {
    return FeatureAd(
      id: json['id'],
      vendorService: VendorService.fromJson(json['vendor_service']),
      featurePackage: FeaturePackage.fromJson(json['feature_package']),
      coverImageUrl: json['cover_image_url'],
      status: json['status'],
      likes: json['likes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class VendorService {
  final int id;
  final Vendor vendor;
  final Service service;
  final bool isFeatured;
  final String title;
  final List<String> imageUrls;
  final String? videoUrl;
  final String shortVideoUrl;
  final int likes;
  final String fixedPrice;
  final String visitingCharges;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<int> selectedSubServices;

  VendorService({
    required this.id,
    required this.vendor,
    required this.service,
    required this.isFeatured,
    required this.title,
    required this.imageUrls,
    this.videoUrl,
    required this.shortVideoUrl,
    required this.likes,
    required this.fixedPrice,
    required this.visitingCharges,
    required this.createdAt,
    required this.updatedAt,
    required this.selectedSubServices,
  });

  factory VendorService.fromJson(Map<String, dynamic> json) {
    return VendorService(
      id: json['id'],
      vendor: Vendor.fromJson(json['vendor']),
      service: Service.fromJson(json['service']),
      isFeatured: json['is_featured'],
      title: json['title'],
      imageUrls: List<String>.from(json['image_urls']),
      videoUrl: json['video_url'],
      shortVideoUrl: json['short_video_url'],
      likes: json['likes'],
      fixedPrice: json['fixed_price'],
      visitingCharges: json['visiting_charges'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      selectedSubServices: List<int>.from(json['selected_sub_services']),
    );
  }
}

class Vendor {
  final int id;
  final String name;
  final String profilePictureUrl;
  final String phoneNumber;
  final String email;

  Vendor({
    required this.id,
    required this.name,
    required this.profilePictureUrl,
    required this.phoneNumber,
    required this.email,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'],
      name: json['name'],
      profilePictureUrl: json['profile_picture_url'],
      phoneNumber: json['phone_number'],
      email: json['email'],
    );
  }
}

class Service {
  final int id;
  final String title;
  final String description;
  final String? coverImageUrl;
  final String? imageUrl;
  final String rating;

  Service({
    required this.id,
    required this.title,
    required this.description,
    this.coverImageUrl,
    this.imageUrl,
    required this.rating,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      coverImageUrl: json['cover_image_url'],
      imageUrl: json['image_url'],
      rating: json['rating'],
    );
  }
}

class FeaturePackage {
  final int id;
  final String title;
  final String price;
  final String featureDuration;
  final String status;
  final String type;
  final String? imageUrl;

  FeaturePackage({
    required this.id,
    required this.title,
    required this.price,
    required this.featureDuration,
    required this.status,
    required this.type,
    this.imageUrl,
  });

  factory FeaturePackage.fromJson(Map<String, dynamic> json) {
    return FeaturePackage(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      featureDuration: json['feature_duration'],
      status: json['status'],
      type: json['type'],
      imageUrl: json['image_url'],
    );
  }
}

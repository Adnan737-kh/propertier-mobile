class ServiceDashboard {
  final List<Slider> latestSliders;
  final List<Service> randomServices;
  final List<VendorService> topSellingServices;
  final List<VendorService> nearbyServices;
  final List<VendorService> shortVideos;
  final List<VendorService> videos;

  ServiceDashboard({
    required this.latestSliders,
    required this.randomServices,
    required this.topSellingServices,
    required this.nearbyServices,
    required this.shortVideos,
    required this.videos,
  });

  factory ServiceDashboard.fromJson(Map<String, dynamic> json) {
    return ServiceDashboard(
      latestSliders: (json['latest_sliders'] as List)
          .map((e) => Slider.fromJson(e))
          .toList(),
      randomServices: (json['random_services'] as List)
          .map((e) => Service.fromJson(e))
          .toList(),
      topSellingServices: (json['top_selling_services'] as List)
          .map((e) => VendorService.fromJson(e))
          .toList(),
      nearbyServices: (json['nearby_services'] as List)
          .map((e) => VendorService.fromJson(e))
          .toList(),
      shortVideos: (json['short_videos'] as List)
          .map((e) => VendorService.fromJson(e))
          .toList(),
      videos: (json['videos'] as List)
          .map((e) => VendorService.fromJson(e))
          .toList(),
    );
  }
}

class Slider {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final bool isMobile;
  final String? link;
  final String createdAt;
  final String updatedAt;

  Slider({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.isMobile,
    this.link,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Slider.fromJson(Map<String, dynamic> json) {
    return Slider(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      isMobile: json['is_mobile'],
      link: json['link'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Service {
  final int id;
  final List<SubService> subservices;
  final String title;
  final String description;
  final String? coverImageUrl;
  final String? imageUrl;
  final String rating;
  final String createdAt;
  final String updatedAt;
  final List<int> vendors;

  Service({
    required this.id,
    required this.subservices,
    required this.title,
    required this.description,
    this.coverImageUrl,
    this.imageUrl,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.vendors,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      subservices: (json['subservices'] as List)
          .map((e) => SubService.fromJson(e))
          .toList(),
      title: json['title'],
      description: json['description'],
      coverImageUrl: json['cover_image_url'],
      imageUrl: json['image_url'],
      rating: json['rating'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      vendors: List<int>.from(json['vendors']),
    );
  }
}

class SubService {
  final int id;
  final String parentServiceName;
  final String title;
  final String description;
  final String coverImageUrl;
  final String iconUrl;
  final String createdAt;
  final String updatedAt;
  final int parentService;

  SubService({
    required this.id,
    required this.parentServiceName,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.iconUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.parentService,
  });

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      id: json['id'],
      parentServiceName: json['parent_service_name'],
      title: json['title'],
      description: json['description'],
      coverImageUrl: json['cover_image_url'],
      iconUrl: json['icon_url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      parentService: json['parent_service'],
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
  final String? shortVideoUrl;
  final int likes;
  final String? fixedPrice;
  final String? visitingCharges;
  final String createdAt;
  final String updatedAt;
  final List<dynamic> selectedSubServices;

  VendorService({
    required this.id,
    required this.vendor,
    required this.service,
    required this.isFeatured,
    required this.title,
    required this.imageUrls,
    this.videoUrl,
    this.shortVideoUrl,
    required this.likes,
    this.fixedPrice,
    this.visitingCharges,
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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      selectedSubServices: json['selected_sub_services'],
    );
  }
}

class Vendor {
  final int id;
  final String name;
  final String? profilePictureUrl;
  final String phoneNumber;
  final String email;

  Vendor({
    required this.id,
    required this.name,
    this.profilePictureUrl,
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

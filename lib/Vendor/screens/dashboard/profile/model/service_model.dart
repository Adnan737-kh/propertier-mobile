class ServiceModel {
  Service? service;
  bool? isFeatured;
  String? title;
  List<String>? imageUrls;
  String? videoUrl;
  String? shortVideoUrl;
  int? likes;
  String? fixedPrice;
  String? visitingCharges;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<int>? selectedSubServices;

  ServiceModel({
    this.service,
    this.isFeatured,
    this.title,
    this.imageUrls,
    this.videoUrl,
    this.shortVideoUrl,
    this.likes,
    this.fixedPrice,
    this.visitingCharges,
    this.createdAt,
    this.updatedAt,
    this.selectedSubServices,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    service = json['service'] != null ? Service.fromJson(json['service']) : null;
    isFeatured = json['is_featured'];
    title = json['title'];
    imageUrls = json['image_urls'] != null ? List<String>.from(json['image_urls']) : [];
    videoUrl = json['video_url'];
    shortVideoUrl = json['short_video_url'];
    likes = json['likes'];
    fixedPrice = json['fixed_price'];
    visitingCharges = json['visiting_charges'];
    createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
    selectedSubServices = json['selected_sub_services'] != null ? List<int>.from(json['selected_sub_services']) : [];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (service != null) {
      data['service'] = service!.toJson();
    }
    data['is_featured'] = isFeatured;
    data['title'] = title;
    data['image_urls'] = imageUrls;
    data['video_url'] = videoUrl;
    data['short_video_url'] = shortVideoUrl;
    data['likes'] = likes;
    data['fixed_price'] = fixedPrice;
    data['visiting_charges'] = visitingCharges;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    data['selected_sub_services'] = selectedSubServices;
    return data;
  }
}

class Service {
  int? id;
  String? title;
  String? description;
  String? coverImageUrl;
  String? imageUrl;
  String? rating;

  Service({
    this.id,
    this.title,
    this.description,
    this.coverImageUrl,
    this.imageUrl,
    this.rating,
  });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    coverImageUrl = json['cover_image_url'];
    imageUrl = json['image_url'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['cover_image_url'] = coverImageUrl;
    data['image_url'] = imageUrl;
    data['rating'] = rating;
    return data;
  }
}

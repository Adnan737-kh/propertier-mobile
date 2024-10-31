class FixedServicesModel {
  int? id;
  Vendor? vendor;
  Service? service;
  bool? isFeatured;
  String? title;
  List<String>? imageUrls;
  String? videoUrl;
  String? shortVideoUrl;
  int? likes;
  String? fixedPrice;
  String? visitingCharges;
  String? createdAt;
  String? updatedAt;
  List<int>? selectedSubServices;

  FixedServicesModel(
      {this.id,
        this.vendor,
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
        this.selectedSubServices});

  FixedServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendor =
    json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    isFeatured = json['is_featured'];
    title = json['title'];
    imageUrls = json['image_urls'].cast<String>();
    videoUrl = json['video_url'];
    shortVideoUrl = json['short_video_url'];
    likes = json['likes'];
    fixedPrice = json['fixed_price'];
    visitingCharges = json['visiting_charges'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    selectedSubServices = json['selected_sub_services'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['is_featured'] = this.isFeatured;
    data['title'] = this.title;
    data['image_urls'] = this.imageUrls;
    data['video_url'] = this.videoUrl;
    data['short_video_url'] = this.shortVideoUrl;
    data['likes'] = this.likes;
    data['fixed_price'] = this.fixedPrice;
    data['visiting_charges'] = this.visitingCharges;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['selected_sub_services'] = this.selectedSubServices;
    return data;
  }
}

class Vendor {
  int? id;
  String? name;
  String? profilePictureUrl;
  String? phoneNumber;
  String? email;

  Vendor(
      {this.id,
        this.name,
        this.profilePictureUrl,
        this.phoneNumber,
        this.email});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profilePictureUrl = json['profile_picture_url'];
    phoneNumber = json['phone_number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_picture_url'] = this.profilePictureUrl;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
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

  Service(
      {this.id,
        this.title,
        this.description,
        this.coverImageUrl,
        this.imageUrl,
        this.rating});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    coverImageUrl = json['cover_image_url'];
    imageUrl = json['image_url'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['cover_image_url'] = this.coverImageUrl;
    data['image_url'] = this.imageUrl;
    data['rating'] = this.rating;
    return data;
  }
}

class FixedServicesModel {
  int? id;
  Vendor? vendor;
  Service? service;
  bool? isFeatured;
  String? title;
  String? description;
  List<String>? imageUrls;
  String? videoUrl;
  String? shortVideoUrl;
  int? likes;
  String? fixedPrice;
  String? visitingCharges;
  String? createdAt;
  String? updatedAt;
  // List<int>? selectedSubServices;

  FixedServicesModel({
    this.id,
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
    // this.selectedSubServices
  });

  FixedServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendor = json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
    isFeatured = json['is_featured'];
    title = json['title'];
    imageUrls = json['images'].cast<String>();
    videoUrl = json['youtube_video_url'];
    shortVideoUrl = json['short_video'];
    // likes = json['likes'];
    // fixedPrice = json['fixed_price'];
    // visitingCharges = json['visiting_charges'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // selectedSubServices = json['selected_sub_services'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    data['is_featured'] = isFeatured;
    data['title'] = title;
    // data['image'] = imageUrls;
    data['youtube_video_url'] = videoUrl;
    data['short_video'] = shortVideoUrl;
    // data['likes'] = likes;
    // data['fixed_price'] = fixedPrice;
    // data['visiting_charges'] = visitingCharges;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    // data['selected_sub_services'] = selectedSubServices;
    return data;
  }
}

class Vendor  {
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
    name = json['full_name'];
    profilePictureUrl = json['profile_picture'];
    phoneNumber = json['phone_number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = name;
    data['profile_picture'] = profilePictureUrl;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    return data;
  }
}

class Service {
  int? id;
  String? title;
  String? description;
  // String? coverImageUrl;
  String? imageUrl;
  String? rating;

  Service(
      {this.id,
      this.title,
      this.description,
      // this.coverImageUrl,
      this.imageUrl,
      this.rating});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    // coverImageUrl = json['cover_image_url'];
    imageUrl = json['image'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    // data['cover_image_url'] = coverImageUrl;
    data['image'] = imageUrl;
    data['rating'] = rating;
    return data;
  }
}

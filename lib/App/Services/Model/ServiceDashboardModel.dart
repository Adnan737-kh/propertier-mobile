import 'package:propertier/App/Services/Model/services_model.dart';

// Model
class ServiceDashboardModel {
  List<ParentServicesModel>? randomServices;
  List<SellingServices>? topsellingServices;
  List<SellingServices>? nearbyServices;

  ServiceDashboardModel(
      {this.randomServices, this.topsellingServices, this.nearbyServices});

  ServiceDashboardModel.fromJson(Map<String, dynamic> json) {
    if (json['random_services'] != null) {
      randomServices = <ParentServicesModel>[];
      json['random_services'].forEach((v) {
        randomServices!.add(new ParentServicesModel.fromJson(v));
      });
    }
    if (json['top_selling_services'] != null) {
      topsellingServices = <SellingServices>[];
      json['top_selling_services'].forEach((v) {
        topsellingServices!.add(new SellingServices.fromJson(v));
      });
    }
    if (json['nearby_services'] != null) {
      nearbyServices = <SellingServices>[];
      json['nearby_services'].forEach((v) {
        nearbyServices!.add(new SellingServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.randomServices != null) {
      data['random_services'] =
          this.randomServices!.map((v) => v.toJson()).toList();
    }
    if (this.topsellingServices != null) {
      data['top_selling_services'] =
          this.topsellingServices!.map((v) => v.toJson()).toList();
    }
    if (this.nearbyServices != null) {
      data['nearby_services'] =
          this.nearbyServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


//Model
class ServicePaginationModel {
  int? total;
  int? page;
  int? limit;
  int? totalPages;
  List<SellingServices>? results;

  ServicePaginationModel(
      {this.total, this.page, this.limit, this.totalPages, this.results});

  ServicePaginationModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = <SellingServices>[];
      json['results'].forEach((v) {
        results!.add(new SellingServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




class Subservices {
  int? id;
  String? title;
  String? description;
  String? coverImageUrl;
  String? iconUrl;
  String? createdAt;
  String? updatedAt;
  String? parentServiceName;
  int? parentService;

  Subservices(
      {this.id,
        this.title,
        this.description,
        this.coverImageUrl,
        this.iconUrl,
        this.createdAt,
        this.updatedAt,
        this.parentServiceName,
        this.parentService});

  Subservices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    coverImageUrl = json['cover_image_url'];
    iconUrl = json['icon_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    parentServiceName = json['parent_service_name'];
    parentService = json['parent_service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['cover_image_url'] = this.coverImageUrl;
    data['icon_url'] = this.iconUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['parent_service_name'] = this.parentServiceName;
    data['parent_service'] = this.parentService;
    return data;
  }
}

class SellingServices {
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

  SellingServices(
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

  SellingServices.fromJson(Map<String, dynamic> json) {
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

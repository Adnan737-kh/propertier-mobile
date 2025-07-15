import 'package:propertier/App/Services/Model/services_model.dart';

// Model
class ServiceDashboardModel {
  List<ParentServicesModel>? randomServices;
  List<SellingServices>? topSellingServices;
  List<SellingServices>? nearbyServices;

  ServiceDashboardModel(
      {this.randomServices, this.topSellingServices, this.nearbyServices});

  ServiceDashboardModel.fromJson(Map<String, dynamic> json) {
    if (json['random_services'] != null) {
      randomServices = <ParentServicesModel>[];
      json['random_services'].forEach((v) {
        randomServices!.add( ParentServicesModel.fromJson(v));
      });
    }
    if (json['top_selling_services'] != null) {
      topSellingServices = <SellingServices>[];
      json['top_selling_services'].forEach((v) {
        topSellingServices!.add( SellingServices.fromJson(v));
      });
    }
    if (json['nearby_services'] != null) {
      nearbyServices = <SellingServices>[];
      json['nearby_services'].forEach((v) {
        nearbyServices!.add( SellingServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (randomServices != null) {
      data['random_services'] =
          randomServices!.map((v) => v.toJson()).toList();
    }
    if (topSellingServices != null) {
      data['top_selling_services'] =
          topSellingServices!.map((v) => v.toJson()).toList();
    }
    if (nearbyServices != null) {
      data['nearby_services'] =
          nearbyServices!.map((v) => v.toJson()).toList();
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
        results!.add( SellingServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    data['total_pages'] = totalPages;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




class SubServices {
  int? id;
  String? title;
  String? description;
  String? coverImageUrl;
  String? iconUrl;
  String? createdAt;
  String? updatedAt;
  String? parentServiceName;
  int? parentService;

  SubServices(
      {this.id,
        this.title,
        this.description,
        this.coverImageUrl,
        this.iconUrl,
        this.createdAt,
        this.updatedAt,
        this.parentServiceName,
        this.parentService});

  SubServices.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['cover_image_url'] = coverImageUrl;
    data['icon_url'] = iconUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['parent_service_name'] = parentServiceName;
    data['parent_service'] = parentService;
    return data;
  }
}

class SellingServices {
  int? id;
  Vendor? vendor;
  Service? service;
  bool? isFeatured;
  String? title;
  List<String>? images;
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
        this.images,
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
    json['vendor'] != null ?  Vendor.fromJson(json['vendor']) : null;
    service =
    json['service'] != null ? Service.fromJson(json['service']) : null;
    isFeatured = json['is_featured'];
    title = json['title'];
    images = (json['images'] ?? []).cast<String>();
    videoUrl = json['video_url'];
    shortVideoUrl = json['short_video_url'];
    likes = json['likes'];
    fixedPrice = json['fixed_price'];
    visitingCharges = json['visiting_charges'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    selectedSubServices = (json['selected_sub_services'] ?? []).cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    data['is_featured'] = isFeatured;
    data['title'] = title;
    data['image_urls'] = images;
    data['video_url'] = videoUrl;
    data['short_video_url'] = shortVideoUrl;
    data['likes'] = likes;
    data['fixed_price'] = fixedPrice;
    data['visiting_charges'] = visitingCharges;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['selected_sub_services'] = selectedSubServices;
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['profile_picture_url'] = profilePictureUrl;
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
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    // data['cover_image_url'] = coverImageUrl;
    data['image'] = imageUrl;
    data['rating'] = rating;
    return data;
  }
}

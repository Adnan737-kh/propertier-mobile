class ServicesModel {
  final String _title;
  final String? _icon;
  ServicesModel({
    required String title,
    String? icon,
  })  : _icon = icon,
        _title = title;
  String get title => _title;
  String get icon => _icon!;
}

class ParentServicesModel {
  int? id;
  List<Subservices>? subServices;
  String? title;
  String? description;
  // String? coverImageUrl;
  String? image;
  String? rating;
  String? createdAt;
  String? updatedAt;
  List<int>? vendors;
  String? mainCategory;

  ParentServicesModel(
      {this.id,
      // this.subservices,
      this.title,
      this.description,
      // this.coverImageUrl,
      this.image,
      this.rating,
      this.createdAt,
      this.updatedAt,
      this.vendors});

  ParentServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['subservices'] != null) {
      subServices = <Subservices>[];
      json['subservices'].forEach((v) {
        subServices!.add( Subservices.fromJson(v));
      });
    }
    title = json['title'];
    description = json['description'];
    // coverImageUrl = json['cover_image_url'];
    image = json['image'];
    rating = json['rating'];
    mainCategory = json['main_category'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vendors = json['vendors'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    // if (this.subservices != null) {
    //   data['subservices'] = this.subservices!.map((v) => v.toJson()).toList();
    // }
    data['title'] = title;
    data['description'] = description;
    // data['cover_image_url'] = this.coverImageUrl;
    data['image'] = image;
    data['rating'] = rating;
    data['main_category'] = rating;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['vendors'] = vendors;
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
    final Map<String, dynamic> data =  <String, dynamic>{};
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

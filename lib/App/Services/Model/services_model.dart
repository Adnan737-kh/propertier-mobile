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
  List<Subservices>? subservices;
  String? title;
  String? description;
  String? coverImageUrl;
  String? imageUrl;
  String? rating;
  String? createdAt;
  String? updatedAt;
  List<int>? vendors;

  ParentServicesModel(
      {this.id,
        this.subservices,
        this.title,
        this.description,
        this.coverImageUrl,
        this.imageUrl,
        this.rating,
        this.createdAt,
        this.updatedAt,
        this.vendors});

  ParentServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['subservices'] != null) {
      subservices = <Subservices>[];
      json['subservices'].forEach((v) {
        subservices!.add(new Subservices.fromJson(v));
      });
    }
    title = json['title'];
    description = json['description'];
    coverImageUrl = json['cover_image_url'];
    imageUrl = json['image'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vendors = json['vendors'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.subservices != null) {
      data['subservices'] = this.subservices!.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    data['cover_image_url'] = this.coverImageUrl;
    data['image'] = this.imageUrl;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['vendors'] = this.vendors;
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


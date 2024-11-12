class VehicleModel {
  int? id;
  String? make;
  String? model;
  int? year;
  String? registrationNumber;
  String? color;
  String? ownerName;
  String? capacity;
  String? fuelType;
  String? transmissionType;
  int? vendor;
  List<Images>? images;
  String? createdAt;
  String? updatedAt;

  VehicleModel(
      {this.id,
        this.make,
        this.model,
        this.year,
        this.registrationNumber,
        this.color,
        this.ownerName,
        this.capacity,
        this.fuelType,
        this.transmissionType,
        this.vendor,
        this.images,
        this.createdAt,
        this.updatedAt});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    make = json['make'];
    model = json['model'];
    year = json['year'];
    registrationNumber = json['registration_number'];
    color = json['color'];
    ownerName = json['owner_name'];
    capacity = json['capacity'];
    fuelType = json['fuel_type'];
    transmissionType = json['transmission_type'];
    vendor = json['vendor'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['make'] = this.make;
    data['model'] = this.model;
    data['year'] = this.year;
    data['registration_number'] = this.registrationNumber;
    data['color'] = this.color;
    data['owner_name'] = this.ownerName;
    data['capacity'] = this.capacity;
    data['fuel_type'] = this.fuelType;
    data['transmission_type'] = this.transmissionType;
    data['vendor'] = this.vendor;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Images {
  int? id;
  String? imageUrl;
  Null? description;
  String? uploadedAt;

  Images({this.id, this.imageUrl, this.description, this.uploadedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    description = json['description'];
    uploadedAt = json['uploaded_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['description'] = this.description;
    data['uploaded_at'] = this.uploadedAt;
    return data;
  }
}

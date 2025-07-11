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
        images!.add( Images.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['make'] = make;
    data['model'] = model;
    data['year'] = year;
    data['registration_number'] = registrationNumber;
    data['color'] = color;
    data['owner_name'] = ownerName;
    data['capacity'] = capacity;
    data['fuel_type'] =fuelType;
    data['transmission_type'] = transmissionType;
    data['vendor'] = vendor;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Images {
  int? id;
  String? imageUrl;
  Null description;
  String? uploadedAt;

  Images({this.id, this.imageUrl, this.description, this.uploadedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    description = json['description'];
    uploadedAt = json['uploaded_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['description'] = description;
    data['uploaded_at'] = uploadedAt;
    return data;
  }
}

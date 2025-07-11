class TransportModel {
  int? id;
  String? name;
  String? pricePerKm;
  String? description;
  String? createdAt;
  String? updatedAt;

  TransportModel(
      {this.id,
        this.name,
        this.pricePerKm,
        this.description,
        this.createdAt,
        this.updatedAt});

  TransportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pricePerKm = json['price_per_km'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['price_per_km'] = pricePerKm;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

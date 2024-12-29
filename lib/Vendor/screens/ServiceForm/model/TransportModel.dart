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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price_per_km'] = this.pricePerKm;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

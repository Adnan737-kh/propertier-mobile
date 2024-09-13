class DemandModel {
  DemandModel({
    this.success,
    this.data,
    this.message,
  });

  final bool? success;
  final Data? data;
  final String? message;

  factory DemandModel.fromJson(Map<String, dynamic> json) {
    return DemandModel(
      success: json["success"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    required this.demandProperties,
  });

  final List<DemandProperty> demandProperties;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      demandProperties: json["demandProperties"] == null
          ? []
          : List<DemandProperty>.from(
              json["demandProperties"]!.map((x) => DemandProperty.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "demandProperties": demandProperties.map((x) => x.toJson()).toList(),
      };
}

class DemandProperty {
  DemandProperty({
    required this.id,
    required this.city,
    required this.area,
    required this.price,
    required this.size,
    required this.type,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? city;
  final String? area;
  final String? price;
  final String? size;
  final String? type;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final dynamic note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory DemandProperty.fromJson(Map<String, dynamic> json) {
    return DemandProperty(
      id: json["id"],
      city: json["city"],
      area: json["area"],
      price: json["price"],
      size: json["size"],
      type: json["type"],
      name: json["name"],
      phoneNumber: json["phone_number"],
      email: json["email"],
      note: json["note"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "area": area,
        "price": price,
        "size": size,
        "type": type,
        "name": name,
        "phone_number": phoneNumber,
        "email": email,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class CRequests {
  CRequests({
    this.nearbyRequests,
    this.agentRequests,
  });

  final List<Request>? nearbyRequests;
  final List<Request>? agentRequests;

  factory CRequests.fromJson(Map<String, dynamic> json) {
    return CRequests(
      nearbyRequests: json["nearby_requests"] == null
          ? []
          : List<Request>.from(
              json["nearby_requests"]!.map((x) => Request.fromJson(x))),
      agentRequests: json["agent_requests"] == null
          ? []
          : List<Request>.from(
              json["agent_requests"]!.map((x) => Request.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "nearby_requests": nearbyRequests!.map((x) => x.toJson()).toList(),
        "agent_requests": agentRequests!.map((x) => x.toJson()).toList(),
      };
}

class Request {
  Request({
    required this.id,
    required this.city,
    required this.area,
    required this.areaUnit,
    required this.areaType,
    required this.purpose,
    required this.longitude,
    required this.latitude,
    required this.minPrice,
    required this.maxPrice,
    required this.size,
    required this.type,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.agent,
  });

  final int? id;
  final String? city;
  final String? area;
  final String? areaUnit;
  final String? areaType;
  final String? purpose;
  final String? longitude;
  final String? latitude;
  final String? minPrice;
  final String? maxPrice;
  final dynamic size;
  final String? type;
  final dynamic name;
  final String? phoneNumber;
  final String? email;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? agent;

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json["id"],
      city: json["city"],
      area: json["area"],
      areaUnit: json["area_unit"],
      areaType: json["area_type"],
      purpose: json["purpose"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      minPrice: json["min_price"],
      maxPrice: json["max_price"],
      size: json["size"],
      type: json["type"],
      name: json["name"],
      phoneNumber: json["phone_number"],
      email: json["email"],
      description: json["description"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      agent: json["agent"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "area": area,
        "area_unit": areaUnit,
        "area_type": areaType,
        "purpose": purpose,
        "longitude": longitude,
        "latitude": latitude,
        "min_price": minPrice,
        "max_price": maxPrice,
        "size": size,
        "type": type,
        "name": name,
        "phone_number": phoneNumber,
        "email": email,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "agent": agent,
      };
}

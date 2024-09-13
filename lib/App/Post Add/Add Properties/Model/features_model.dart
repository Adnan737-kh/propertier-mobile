class Features {
  Features({
    this.data,
    this.status,
  });

  final Data? data;
  final int? status;

  factory Features.fromJson(Map<String, dynamic> json) {
    return Features(
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
      };
}

class Data {
  Data({
    required this.features,
  });

  final List<Feature> features;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      features: json["Features"] == null
          ? []
          : List<Feature>.from(
              json["Features"]!.map((x) => Feature.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "Features": features.map((x) => x.toJson()).toList(),
      };
}

class Feature {
  Feature({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

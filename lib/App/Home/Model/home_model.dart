import '../../../Model/property.dart';

class HomeModel {
  HomeModel({
    this.data,
    this.message,
    this.status,
  });

  final Data? data;
  final String? message;
  final int? status;

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      message: json["message"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
        "message": message,
        "status": status,
      };
}

class Data {
  Data({
    required this.sliders,
    required this.properties,
    required this.shortVideos,
    required this.propertiesWithVideos,
  });

  final List<Slider> sliders;
  final List<Property> properties;
  final List<Property> shortVideos;
  final List<Property> propertiesWithVideos;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      sliders: json["sliders"] == null
          ? []
          : List<Slider>.from(json["sliders"]!.map((x) => Slider.fromJson(x))),
      properties: json["properties"] == null
          ? []
          : List<Property>.from(
              json["properties"]!.map((x) => Property.fromJson(x))),
      shortVideos: json["shortVideos"] == null
          ? []
          : List<Property>.from(
              json["shortVideos"]!.map((x) => Property.fromJson(x))),
      propertiesWithVideos: json["properties_with_videos"] == null
          ? []
          : List<Property>.from(
              json["properties_with_videos"]!.map((x) => Property.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "sliders": sliders.map((x) => x.toJson()).toList(),
        "properties": properties.map((x) => x.toJson()).toList(),
        "shortVideos": shortVideos.map((x) => x.toJson()).toList(),
        "properties_with_videos":
            propertiesWithVideos.map((x) => x.toJson()).toList(),
      };
}

class Slider {
  Slider({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.mobile,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final dynamic mobile;
  final dynamic link;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Slider.fromJson(Map<String, dynamic> json) {
    return Slider(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      image: json["image_url"],
      mobile: json["mobile"],
      link: json["link"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image_url": image,
        "mobile": mobile,
        "link": link,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

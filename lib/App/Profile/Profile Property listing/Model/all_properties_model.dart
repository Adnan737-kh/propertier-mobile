import 'dart:convert';

AllPropertiesModel allPropertiesModelFromJson(String str) =>
    AllPropertiesModel.fromJson(json.decode(str));

String allPropertiesModelToJson(AllPropertiesModel data) =>
    json.encode(data.toJson());

class AllPropertiesModel {
  bool? success;
  Data? data;
  String? message;

  AllPropertiesModel({
    this.success,
    this.data,
    this.message,
  });

  factory AllPropertiesModel.fromJson(Map<String, dynamic> json) =>
      AllPropertiesModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  List<String>? cities;
  List<SpecificProperty>? properties;

  Data({
    this.cities,
    this.properties,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cities: json["cities"] == null
            ? []
            : List<String>.from(json["cities"]!.map((x) => x)),
        properties: json["properties"] == null
            ? []
            : List<SpecificProperty>.from(
                json["properties"]!.map((x) => SpecificProperty.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cities":
            cities == null ? [] : List<dynamic>.from(cities!.map((x) => x)),
        "properties": properties == null
            ? []
            : List<dynamic>.from(properties!.map((x) => x.toJson())),
      };
}

class SpecificProperty {
  int? id;
  String? title;
  String? slug;
  String? price;
  int? featured;
  Purpose? purpose;
  String? type;
  String? image;
  int? bedroom;
  int? bathroom;
  String? city;
  String? citySlug;
  String? address;
  int? area;
  int? agentId;
  String? description;
  String? video;
  FloorPlan? floorPlan;
  String? locationLatitude;
  String? locationLongitude;
  String? nearby;
  String? areaUnit;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;
  String? shortVideo;
  int? likes;

  SpecificProperty({
    this.id,
    this.title,
    this.slug,
    this.price,
    this.featured,
    this.purpose,
    this.type,
    this.image,
    this.bedroom,
    this.bathroom,
    this.city,
    this.citySlug,
    this.address,
    this.area,
    this.agentId,
    this.description,
    this.video,
    this.floorPlan,
    this.areaUnit,
    this.locationLatitude,
    this.locationLongitude,
    this.nearby,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.shortVideo,
    this.likes,
  });

  factory SpecificProperty.fromJson(Map<String, dynamic> json) =>
      SpecificProperty(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        price: json["price"],
        featured: json["featured"],
        purpose: purposeValues.map[json["purpose"]]!,
        type: json["type"],
        image: json["image"],
        bedroom: json["bedroom"],
        bathroom: json["bathroom"],
        city: json["city"],
        citySlug: json["city_slug"],
        address: json["address"],
        area: json["area"],
        agentId: json["agent_id"],
        description: json["description"],
        video: json["video"],
        floorPlan: floorPlanValues.map[json["floor_plan"]]!,
        locationLatitude: json["location_latitude"],
        locationLongitude: json["location_longitude"],
        nearby: json["nearby"],
        areaUnit: json['area_unit'],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        status: json["status"],
        shortVideo: json["short_video"],
        likes: json["likes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "price": price,
        "featured": featured,
        "purpose": purposeValues.reverse[purpose],
        "type": type,
        "image": image,
        "bedroom": bedroom,
        "bathroom": bathroom,
        "city": city,
        "city_slug": citySlug,
        "address": address,
        "area": area,
        "agent_id": agentId,
        "area_unit": areaUnit,
        "description": description,
        "video": video,
        "floor_plan": floorPlanValues.reverse[floorPlan],
        "location_latitude": locationLatitude,
        "location_longitude": locationLongitude,
        "nearby": nearby,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "short_video": shortVideo,
        "likes": likes,
      };
}

enum FloorPlan { DEFAULT_PNG }

final floorPlanValues = EnumValues({"default.png": FloorPlan.DEFAULT_PNG});

enum Purpose { RENT, SALE }

final purposeValues = EnumValues({"rent": Purpose.RENT, "sale": Purpose.SALE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

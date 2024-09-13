import 'dart:convert';

VideosModel videosModelFromJson(String str) =>
    VideosModel.fromJson(json.decode(str));

String videosModelToJson(VideosModel data) => json.encode(data.toJson());

class VideosModel {
  bool? success;
  VideoData? data;
  String? message;

  VideosModel({
    this.success,
    this.data,
    this.message,
  });

  factory VideosModel.fromJson(Map<String, dynamic> json) => VideosModel(
        success: json["success"],
        data: json["data"] == null ? null : VideoData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class VideoData {
  List<Video>? videos;

  VideoData({
    this.videos,
  });

  factory VideoData.fromJson(Map<String, dynamic> json) => VideoData(
        videos: json["videos"] == null
            ? []
            : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "videos": videos == null
            ? []
            : List<dynamic>.from(videos!.map((x) => x.toJson())),
      };
}

class Video {
  int? id;
  String? title;
  String? slug;
  String? price;
  int? featured;
  String? purpose;
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
  String? floorPlan;
  dynamic locationLatitude;
  dynamic locationLongitude;
  dynamic nearby;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;
  String? shortVideo;
  int? likes;

  Video({
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
    this.locationLatitude,
    this.locationLongitude,
    this.nearby,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.shortVideo,
    this.likes,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        price: json["price"],
        featured: json["featured"],
        purpose: json["purpose"],
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
        floorPlan: json["floor_plan"],
        locationLatitude: json["location_latitude"],
        locationLongitude: json["location_longitude"],
        nearby: json["nearby"],
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
        "purpose": purpose,
        "type": type,
        "image": image,
        "bedroom": bedroom,
        "bathroom": bathroom,
        "city": city,
        "city_slug": citySlug,
        "address": address,
        "area": area,
        "agent_id": agentId,
        "description": description,
        "video": video,
        "floor_plan": floorPlan,
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

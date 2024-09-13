import '../../../Model/property.dart';

class SpecificPropertyModel {
  SpecificPropertyModel({
    this.detailDataModel,
    this.status,
  });

  final DetailDataModel? detailDataModel;
  final int? status;

  factory SpecificPropertyModel.fromJson(Map<String, dynamic> json) {
    return SpecificPropertyModel(
      detailDataModel: json["DetailDataModel"] == null
          ? null
          : DetailDataModel.fromJson(json["DetailDataModel"]),
      status: json["Status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "DetailDataModel": detailDataModel?.toJson(),
        "Status": status,
      };
}

class DetailDataModel {
  DetailDataModel({
    required this.property,
    required this.galleryImages,
    required this.features,
    required this.relatedProperties,
  });

  final Property? property;
  final List<GalleryImage> galleryImages;
  final List<Feature> features;
  final List<Property> relatedProperties;

  factory DetailDataModel.fromJson(Map<String, dynamic> json) {
    return DetailDataModel(
      property:
          json["Property"] == null ? null : Property.fromJson(json["Property"]),
      galleryImages: json["Gallery_images"] == null
          ? []
          : List<GalleryImage>.from(
              json["Gallery_images"]!.map((x) => GalleryImage.fromJson(x))),
      features: json["Features"] == null
          ? []
          : List<Feature>.from(
              json["Features"]!.map((x) => Feature.fromJson(x))),
      relatedProperties: json["Related_Properties"] == null
          ? []
          : List<Property>.from(
              json["Related_Properties"]!.map((x) => Property.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "Property": property?.toJson(),
        "Gallery_images": galleryImages.map((x) => x.toJson()).toList(),
        "Features": features.map((x) => x.toJson()).toList(),
        "Related_Properties": relatedProperties.map((x) => x.toJson()).toList(),
      };
}

class Feature {
  Feature({
    required this.featureId,
  });

  final FeatureId? featureId;

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      featureId: json["feature_id"] == null
          ? null
          : FeatureId.fromJson(json["feature_id"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "feature_id": featureId?.toJson(),
      };
}

class FeatureId {
  FeatureId({
    required this.name,
  });

  final String? name;

  factory FeatureId.fromJson(Map<String, dynamic> json) {
    return FeatureId(
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class GalleryImage {
  GalleryImage({
    required this.imageUrl,
  });

  final String imageUrl;

  factory GalleryImage.fromJson(Map<String, dynamic> json) {
    return GalleryImage(
      imageUrl: json["image_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
      };
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_pakages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeaturedPakages _$FeaturedPakagesFromJson(Map<String, dynamic> json) =>
    FeaturedPakages(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      price: json['price'] as String?,
      featureDuration: json['feature_duration'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      priorityType: json['ad_type'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$FeaturedPakagesToJson(FeaturedPakages instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'feature_duration': instance.featureDuration,
      'status': instance.status,
      'type': instance.type,
      'ad_type': instance.priorityType,
      'image_url': instance.imageUrl,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

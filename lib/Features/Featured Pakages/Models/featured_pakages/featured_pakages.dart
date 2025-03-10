import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'featured_pakages.g.dart';

@JsonSerializable()
class FeaturedPakages {
  final int? id;
  final String? title;
  final String? price;
  @JsonKey(name: 'feature_duration')
  final String? featureDuration;
  final String? status;
  final String? type;
  @JsonKey(name: 'ad_type')
  final String? priorityType;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  const FeaturedPakages({
    this.id,
    this.title,
    this.price,
    this.featureDuration,
    this.status,
    this.type,
    this.priorityType,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'FeaturedPakages(id: $id, title: $title, price: $price, featureDuration: $featureDuration, status: $status, type: $type, priorityType: $priorityType, imageUrl: $imageUrl, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  factory FeaturedPakages.fromJson(Map<String, dynamic> json) {
    return _$FeaturedPakagesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FeaturedPakagesToJson(this);

  FeaturedPakages copyWith({
    int? id,
    String? title,
    String? price,
    String? featureDuration,
    String? status,
    String? type,
    String? priorityType,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FeaturedPakages(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      featureDuration: featureDuration ?? this.featureDuration,
      status: status ?? this.status,
      type: type ?? this.type,
      priorityType: priorityType ?? this.priorityType,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! FeaturedPakages) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      price.hashCode ^
      featureDuration.hashCode ^
      status.hashCode ^
      type.hashCode ^
      priorityType.hashCode ^
      imageUrl.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}

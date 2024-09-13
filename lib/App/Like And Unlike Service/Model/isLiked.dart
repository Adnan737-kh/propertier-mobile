import '../../../Model/property.dart';

class IsLiked {
  IsLiked({
    this.status,
    this.liked,
    this.property,
  });

  final String? status;
  bool? liked;
  final Property? property;

  factory IsLiked.fromJson(Map<String, dynamic> json) {
    return IsLiked(
      status: json["status"],
      liked: json["liked"],
      property:
          json["Property"] == null ? null : Property.fromJson(json["Property"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "liked": liked,
        "Property": property?.toJson(),
      };
}

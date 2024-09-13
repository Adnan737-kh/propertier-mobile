class Featureadd {
  final String featureDuration;
  final int price;
  final String status;
  final String? title;
  final String? type;
  final String? image;

  Featureadd({
    required this.featureDuration,
    required this.price,
    required this.status,
    this.title,
    this.type,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'feature_duration': featureDuration,
      'price': price,
      'status': status,
      'title': title,
      'type': type,
      'image_url': image,
    };
  }
}

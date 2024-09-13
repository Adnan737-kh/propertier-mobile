class TitleModel {
  final String title;
  final String id;

  TitleModel({required this.title, required this.id});

  factory TitleModel.fromJson(Map<String, dynamic> json) {
    return TitleModel(
      title: json['title'] ?? '',
      id: json['id'] ?? '',
    );
  }
}

class SubService {
  final int id;
  final String parentServiceName;
  final String title;
  final String description;
  final String coverImageUrl;
  final String iconUrl;
  final int parentService;

  SubService({
    required this.id,
    required this.parentServiceName,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.iconUrl,
    required this.parentService,
  });

  // Factory method to create a SubService from JSON
  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      id: json['id'],
      parentServiceName: json['parent_service_name'],
      title: json['title'],
      description: json['description'],
      coverImageUrl: json['cover_image_url'],
      iconUrl: json['icon_url'],
      parentService: json['parent_service'],
    );
  }

  // Method to convert a SubService to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_service_name': parentServiceName,
      'title': title,
      'description': description,
      'cover_image_url': coverImageUrl,
      'icon_url': iconUrl,
      'parent_service': parentService,
    };
  }
}

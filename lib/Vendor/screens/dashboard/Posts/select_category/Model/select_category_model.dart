class ParentService {
  final String parentServiceName;
  final List<Subservice>
      subservices; // Assuming subservices are part of ParentService

  ParentService({
    required this.parentServiceName,
    this.subservices = const [], // Default to empty list if no subservices
  });

  factory ParentService.fromJson(Map<String, dynamic> json) {
    return ParentService(
      parentServiceName: json['parent_service_name'] ?? '',
      subservices: (json['subservices'] as List<dynamic>?)
              ?.map((item) => Subservice.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [], // Handle the subservices if available
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parent_service_name': parentServiceName,
      'subservices':
          subservices.map((subservice) => subservice.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'ParentService(parentServiceName: $parentServiceName, subservices: $subservices)';
  }
}

class Subservice {
  final String title;
  final String parentServiceName;

  Subservice({
    required this.title,
    required this.parentServiceName,
  });

  factory Subservice.fromJson(Map<String, dynamic> json) {
    return Subservice(
      title: json['title'] ?? '',
      parentServiceName: json['parent_service_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'parent_service_name': parentServiceName,
    };
  }

  @override
  String toString() {
    return 'Subservice(title: $title, parentServiceName: $parentServiceName)';
  }
}

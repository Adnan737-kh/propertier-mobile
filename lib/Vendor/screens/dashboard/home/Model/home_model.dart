class Bid {
  final int id;
  final String location;
  final String latitude;
  final String longitude;
  final String description;
  final List<dynamic> imageUrls;
  final String? amount;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int customer;
  final int? vendor; 
  final int? service; // Change service to nullable
  final List<SubService> selectedSubServices; // Now it's a list of SubService objects

  Bid({
    required this.id,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.imageUrls,
    this.amount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.customer,
    this.vendor,
    this.service,
    required this.selectedSubServices,
  });

  factory Bid.fromJson(Map<String, dynamic> json) {
    return Bid(
      id: json['id'] ?? 0,
      location: json['location'] ?? 'Unknown location',
      latitude: json['latitude'] ?? '0.0',
      longitude: json['longitude'] ?? '0.0',
      description: json['description'] ?? 'No description',
      imageUrls: json['image_urls'] ?? [],
      amount: json['amount'] ?? "",
      status: json['status'] ?? 'Unknown status',
      createdAt: json['created_at'] ?? DateTime.now().toString(),
      updatedAt: json['updated_at'] ?? DateTime.now().toString(),
      customer: json['customer'] ?? 0,
      vendor: json['vendor'], // Handle nullable vendor
      service: json['service'], // Can be null
      selectedSubServices: (json['selected_sub_services'] as List)
          .map((e) => SubService.fromJson(e))
          .toList(), // Map sub-services to a list of SubService objects
    );
  }
}

class SubService {
  final int id;
  final String title;

  SubService({
    required this.id,
    required this.title,
  });

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown title',
    );
  }
}

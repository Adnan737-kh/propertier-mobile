class VendorRegistrationModel {
  final int id;
  final String? serviceMainCategory;
  final String? serviceTitle;
  final String? profileDescription;
  final int user;
  final dynamic submittedRequirements;
  final int assignedService;

  VendorRegistrationModel({
    required this.id,
    this.serviceMainCategory,
    this.serviceTitle,
    this.profileDescription,
    required this.user,
    this.submittedRequirements,
    required this.assignedService,
  });

  factory VendorRegistrationModel.fromJson(Map<String, dynamic> json) {
    return VendorRegistrationModel(
      id: json['id'] ?? -1,
      serviceMainCategory: json['service_main_category'],
      serviceTitle: json['service_title'],
      profileDescription: json['profile_description'],
      user: json['user'] ?? 0,
      submittedRequirements: json['submitted_requirements'],
      assignedService: json['assigned_service'] ?? 0,
    );
  }
}

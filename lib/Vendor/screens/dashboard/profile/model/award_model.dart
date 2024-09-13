class AwardModel {
  int? id;
  Vendor? vendor;
  String? title;
  String? date;
  String? description;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  final String imagePath;
  String vendorId;

  AwardModel({
    this.id,
    this.vendor,
    this.title,
    this.date,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    required this.imagePath,
    required this.vendorId,
  });

  // Factory constructor to create an AwardModel from JSON
  factory AwardModel.fromJson(Map<String, dynamic> json) {
    return AwardModel(
      id: json['id'],
      vendor: json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null,
      title: json['title'],
      date: json['date'],
      description: json['description'],
      imageUrl: json['image_url'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      vendorId: json['vendor_id'] ?? '',
      imagePath: '',
    );
  }

  get imageUrlss => null;
  // Method to convert AwardModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendor': vendor?.toJson(),
      'title': title,
      'date': date,
      'description': description,
      'image_url': imageUrl,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'vendor_id': vendorId,
    };
  }
}

// Vendor class to represent the vendor details
class Vendor {
  int? id;
  String? name;
  String? email;
  String? profilePictureUrl;

  Vendor({
    this.id,
    this.name,
    this.email,
    this.profilePictureUrl,
  });

  // Factory constructor to create a Vendor from JSON
  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePictureUrl: json['profile_picture_url'],
    );
  }

  // Method to convert Vendor to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_picture_url': profilePictureUrl,
    };
  }
}

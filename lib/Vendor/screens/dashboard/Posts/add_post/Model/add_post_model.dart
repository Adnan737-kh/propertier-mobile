
import 'dart:io';

class AddPostModel {
  final String vendorId;
  final String serviceId;
  final String title;
  final List<String> selectedSubServices;
  final List<File> images; // This can be handled in the request separately
  final String videoUrl;
  final String shortVideo;
  final String visitingCharges;
  final String fixedPrice;

  AddPostModel({
    required this.vendorId,
    required this.serviceId,
    required this.title,
    required this.selectedSubServices,
    required this.images,
    required this.videoUrl,
    required this.shortVideo,
    required this.visitingCharges,
    required this.fixedPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'vendor_id': vendorId,
      'service_id': serviceId,
      'title': title,
      'selected_sub_services': selectedSubServices,
      'images': images, // This might be handled separately in the request
      'video_url': videoUrl,
      'short_video': shortVideo,
      'visiting_charges': visitingCharges,
      'fixed_price': fixedPrice,
    };
  }
}

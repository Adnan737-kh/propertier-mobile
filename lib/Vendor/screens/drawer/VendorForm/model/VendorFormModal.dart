import 'package:propertier/Vendor/screens/ServiceForm/model/ServiceFormModel.dart';

class VendorFormModal {
  int? id;
  ServiceFormModel? requirementDetails;
  var value;
  String? createdAt;
  String? updatedAt;
  int? vendorId;
  int? requirement;

  VendorFormModal(
      {this.id,
        this.requirementDetails,
        this.value,
        this.createdAt,
        this.updatedAt,
        this.vendorId,
        this.requirement});

  VendorFormModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requirementDetails = json['requirement_details'] != null
        ?  ServiceFormModel.fromJson(json['requirement_details'])
        : null;
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    vendorId = json['vendor_id'];
    requirement = json['requirement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (requirementDetails != null) {
      data['requirement_details'] = requirementDetails!.toJson();
    }
    data['value'] = value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['vendor_id'] = vendorId;
    data['requirement'] =requirement;
    return data;
  }
}
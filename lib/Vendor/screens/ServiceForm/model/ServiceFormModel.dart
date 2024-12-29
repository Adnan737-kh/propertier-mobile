class ServiceFormModel {
  int? id;
  String? fieldName;
  String? fieldType;
  bool? isRequired;
  List<dynamic>? options;
  ValidationRules? validationRules;
  String? createdAt;
  String? updatedAt;
  int? service;

  ServiceFormModel({
    this.id,
    this.fieldName,
    this.fieldType,
    this.isRequired,
    this.options,
    this.validationRules,
    this.createdAt,
    this.updatedAt,
    this.service,
  });

  ServiceFormModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    fieldName = json['field_name'] as String?;
    fieldType = json['field_type'] as String?;
    isRequired = json['is_required'] as bool?;
    options = json['options'] as List<dynamic>?;
    validationRules = json['validation_rules'] != null
        ? ValidationRules.fromJson(json['validation_rules'] as Map<String, dynamic>)
        : null;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    service = json['service'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['field_name'] = fieldName;
    data['field_type'] = fieldType;
    data['is_required'] = isRequired;
    data['options'] = options;
    if (validationRules != null) {
      data['validation_rules'] = validationRules!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['service'] = service;
    return data;
  }
}

class ValidationRules {
  List<String>? allowedTypes;
  String? maxFileSize;

  ValidationRules({this.allowedTypes, this.maxFileSize});

  ValidationRules.fromJson(Map<String, dynamic> json) {
    allowedTypes = (json['allowed_types'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList();
    maxFileSize = json['max_file_size'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allowed_types'] = allowedTypes;
    data['max_file_size'] = maxFileSize;
    return data;
  }
}



// class ServiceFormModel {
//   int? id;
//   String? fieldName;
//   String? fieldType;
//   bool? isRequired;
//   List? options;
//   ValidationRules? validationRules;
//   String? createdAt;
//   String? updatedAt;
//   int? service;
//
//   ServiceFormModel(
//       {this.id,
//         this.fieldName,
//         this.fieldType,
//         this.isRequired,
//         this.options,
//         this.validationRules,
//         this.createdAt,
//         this.updatedAt,
//         this.service});
//
//   ServiceFormModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     fieldName = json['field_name'];
//     fieldType = json['field_type'];
//     isRequired = json['is_required'];
//     options = json['options'];
//     validationRules = json['validation_rules'] != null
//         ? new ValidationRules.fromJson(json['validation_rules'])
//         : null;
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     service = json['service'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['field_name'] = this.fieldName;
//     data['field_type'] = this.fieldType;
//     data['is_required'] = this.isRequired;
//     data['options'] = this.options;
//     if (this.validationRules != null) {
//       data['validation_rules'] = this.validationRules!.toJson();
//     }
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['service'] = this.service;
//     return data;
//   }
// }
//
// class ValidationRules {
//   List? allowedTypes;
//   String? maxFileSize;
//
//   ValidationRules({this.allowedTypes, this.maxFileSize});
//
//   ValidationRules.fromJson(Map<String, dynamic> json) {
//     allowedTypes = json['allowed_types'];
//     maxFileSize = json['max_file_size'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['allowed_types'] = this.allowedTypes;
//     data['max_file_size'] = this.maxFileSize;
//     return data;
//   }
// }

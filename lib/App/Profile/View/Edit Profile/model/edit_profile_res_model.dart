import 'package:propertier/App/Auth/Login/Model/login_response_model.dart';

class EditProfileResponse {
  EditProfileResponse({
    this.status,
    this.data,
    this.message,
  });

  final String? status;
  final UserData? data;
  final String? message;

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) {
    return EditProfileResponse(
      status: json["status"],
      data: json["Data"] == null ? null : UserData.fromJson(json["Data"]),
      message: json["Message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "Data": data?.toJson(),
        "Message": message,
      };
}

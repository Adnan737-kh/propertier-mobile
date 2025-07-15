import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String token;
  DateTime expiration;
  String email;
  List<String> userRoles;
  String? phoneNumber;
  String? fName;
  String? lName;
  String id;
  int timeSheetType;

  UserModel({
    required this.token,
    required this.expiration,
    required this.email,
    required this.userRoles,
    this.phoneNumber,
    this.fName,
    this.lName,
    required this.id,
    required this.timeSheetType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"] ?? "",
        expiration: json["expiration"] != null
            ? DateTime.parse(json["expiration"])
            : DateTime.now(),
        email: json["email"] ?? "",
        userRoles: json["userRoles"] != null
            ? List<String>.from(json["userRoles"].map((x) => x))
            : [],
        phoneNumber: json["phonenumber"]?.toString(),
        fName: json["fname"],
        lName: json["lname"],
        id: json["id"] ?? "",
        timeSheetType: json["timeSheettype"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expiration": expiration.toIso8601String(),
        "email": email,
        "userRoles": List<dynamic>.from(userRoles.map((x) => x)),
        "phonenumber": phoneNumber,
        "fname": fName,
        "lname": lName,
        "id": id,
        "timeSheettype": timeSheetType,
      };
}

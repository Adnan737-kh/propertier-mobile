import 'dart:convert';

UserModelOld UserModelFromJson(String str) => UserModelOld.fromJson(json.decode(str));

String UserModelToJson(UserModelOld data) => json.encode(data.toJson());

class UserModelOld {
  String token;
  DateTime expiration;
  String email;
  List<String>? userRoles;
  dynamic phoneNumber;
  String fname;
  String lname;
  String id;
  int timeSheetType;

  UserModelOld({
    required this.token,
    required this.expiration,
    required this.email,
    required this.userRoles,
    required this.phoneNumber,
    required this.fname,
    required this.lname,
    required this.id,
    required this.timeSheetType,
  });

  factory UserModelOld.fromJson(Map<String, dynamic> json) => UserModelOld(
        token: json["token"] ?? "",
        expiration: json["expiration"] == null
            ? DateTime.parse(
                json["expiration"] ?? DateTime.now().toIso8601String())
            : DateTime.parse(DateTime.now().toIso8601String()),
        email: json["email"] ?? "",
        userRoles: json["userRoles"] != null
            ? List<String>.from(json["userRoles"].map((x) => x))
            : [],
        phoneNumber: json["phonenumber"] ?? "",
        fname: json["fname"] ?? "",
        lname: json["lname"] ?? "",
        id: json["id"] ?? "",
        timeSheetType: json["timeSheettype"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expiration": expiration.toIso8601String(),
        "email": email,
        "userRoles": List<dynamic>.from(userRoles!.map((x) => x)),
        "phonenumber": phoneNumber,
        "fname": fname,
        "lname": lname,
        "id": id,
        "timeSheettype": timeSheetType,
      };
}

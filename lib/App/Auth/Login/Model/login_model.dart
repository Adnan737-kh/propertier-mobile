import 'dart:convert';

UserModelOld UserModelFromJson(String str) => UserModelOld.fromJson(json.decode(str));

String UserModelToJson(UserModelOld data) => json.encode(data.toJson());

class UserModelOld {
  String token;
  DateTime expiration;
  String email;
  List<String>? userRoles;
  dynamic phonenumber;
  String fname;
  String lname;
  String id;
  int timeSheettype;

  UserModelOld({
    required this.token,
    required this.expiration,
    required this.email,
    required this.userRoles,
    required this.phonenumber,
    required this.fname,
    required this.lname,
    required this.id,
    required this.timeSheettype,
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
        phonenumber: json["phonenumber"] ?? "",
        fname: json["fname"] ?? "",
        lname: json["lname"] ?? "",
        id: json["id"] ?? "",
        timeSheettype: json["timeSheettype"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expiration": expiration.toIso8601String(),
        "email": email,
        "userRoles": List<dynamic>.from(userRoles!.map((x) => x)),
        "phonenumber": phonenumber,
        "fname": fname,
        "lname": lname,
        "id": id,
        "timeSheettype": timeSheettype,
      };
}

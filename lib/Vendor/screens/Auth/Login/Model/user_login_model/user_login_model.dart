import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'user_login_model.g.dart';

@JsonSerializable()
class UserLoginModel {
  final String? message;
  final List<User>? users;

  const UserLoginModel({this.message, this.users});

  @override
  String toString() => 'UserLoginModel(message: $message, users: $users)';

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return _$UserLoginModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserLoginModelToJson(this);

  UserLoginModel copyWith({
    String? message,
    List<User>? users,
  }) {
    return UserLoginModel(
      message: message ?? this.message,
      users: users ?? this.users,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserLoginModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => message.hashCode ^ users.hashCode;
}

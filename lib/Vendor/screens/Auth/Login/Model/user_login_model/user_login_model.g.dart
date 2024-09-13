part of 'user_login_model.dart';

UserLoginModel _$UserLoginModelFromJson(Map<String, dynamic> json) {
  return UserLoginModel(
    message: json['message'] as String?,
    users: (json['users'] as List<dynamic>?)?.map((e) {
      if (e is Map<String, dynamic>) {
        // If it's a Map, convert it to a User object
        return User.fromJson(e);
      } else if (e is User) {
        // If it's already a User object, return it directly
        return e;
      } else {
        throw Exception(
            'Expected Map<String, dynamic> but got ${e.runtimeType}');
      }
    }).toList(),
  );
}

Map<String, dynamic> _$UserLoginModelToJson(UserLoginModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'users': instance.users?.map((user) => user.toJson()).toList(),
    };

class SignUpModel {
  String fullName;
  String email;
  String password;
  String passwordConfirm;

  // Constructor
  SignUpModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.passwordConfirm,
  });

  // Convert model to Map for API request
  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'email': email,
      'password': password,
      'password_confirm': passwordConfirm,
    };
  }

  // Optionally, you can implement a factory constructor to create an instance from JSON data
  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      fullName: json['full_name'],
      email: json['email'],
      password: json['password'],
      passwordConfirm: json['password_confirm'],
    );
  }
}

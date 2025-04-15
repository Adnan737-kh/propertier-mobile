class SignInModel {
  final String email;
  final String password;

  // Constructor
  SignInModel({
    required this.email,
    required this.password,
  });


  // Convert model to Map for API request
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Convert model to Map for API request (toJson)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Optional: Create a factory constructor to initialize from JSON (if needed)
  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      email: json['email'],
      password: json['password'],
    );
  }
}

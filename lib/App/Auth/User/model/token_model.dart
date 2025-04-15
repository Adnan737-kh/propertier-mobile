class TokenModel {
  final String? accessToken;
  final String? refreshToken;

  // Constructor
  TokenModel({this.accessToken, this.refreshToken});

  // Convert JSON map to a SaveUserModel instance (fromJson)
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['token']['access'],  // Corrected key path
      refreshToken: json['token']['refresh'],  // Added refresh token
    );
  }

  // Convert SaveUserModel instance to JSON map (toJson)
  Map<String, dynamic> toJson() {
    return {
      'access': accessToken,
      'refresh': refreshToken,
    };
  }
}

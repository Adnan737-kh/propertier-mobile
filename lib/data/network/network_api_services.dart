import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../app_exception.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {
  @override
  Future getApi(String url, {String? authToken}) async {
    dynamic responseJson;
    try {
      final headers = {
        "Content-Type": "application/json",
        if (authToken != null) "Authorization": "Bearer $authToken",
      };
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 15));
      responseJson = returnResponse(response);
      if (kDebugMode) {
        print('get Response is ${response.body}');
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw TimeoutException('');
    }
    return responseJson;
  }

  @override
  Future<Map<String, dynamic>> postApi(var data, String url,
      {String? authToken}) async {
    if (kDebugMode) {
      print('postApi $data');
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          if (authToken != null) "Authorization": "Bearer $authToken",
        },
        body: jsonEncode(data),
      );

      dynamic responseJson = returnResponse(response);
      if (kDebugMode) {
        print('The JSON response: $responseJson');
      }

      return {
        'statusCode': response.statusCode,
        'body': responseJson,
      };
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw TimeoutException('');
    }
  }

  @override
  Future<Map<String, dynamic>> patchApi(var data, String url,
      {String? authToken}) async {
    if (kDebugMode) {
      print('🔹 The data: $data');
      print('🔹 The URL: $url');
      print('🔹 The authToken: $authToken');
    }

    try {
      final headers = {
        "Content-Type": "application/json",
        if (authToken != null) "Authorization": "Bearer $authToken",
      };

      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (kDebugMode) {
        print('🔹 Response Status Code: ${response.statusCode}');
        print('🔹 Response Body: ${response.body}');
      }

      final decodedBody = jsonDecode(response.body);

      return {
        'statusCode': response.statusCode,
        'body': decodedBody,
      };
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw TimeoutException('');
    } catch (e) {
      if (kDebugMode) print('🔺 Unexpected error: $e');
      rethrow;
    }
  }

  @override
  Future putApi(var data, String url, {String? authToken}) async {
    if (kDebugMode) {
      print('🔹 PUT data: $data');
      print('🔹 PUT URL: $url');
      print('🔹 PUT authToken: $authToken');
    }

    try {
      final headers = {
        "Content-Type": "application/json",
        if (authToken != null) "Authorization": "Bearer $authToken",
      };

      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (kDebugMode) {
        print('🔹 PUT Response Status Code: ${response.statusCode}');
        print('🔹 PUT Response Body: ${response.body}');
      }

      final decodedBody = jsonDecode(response.body);

      return {
        'statusCode': response.statusCode,
        'body': decodedBody,
      };
    } on SocketException {
      throw InternetException('No Internet connection');
    } on TimeoutException {
      throw TimeoutException('Request timed out');
    } catch (e) {
      if (kDebugMode) print('🔺 PUT Unexpected error: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> deleteApi(String url,
      {String? authToken}) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          if (authToken != null) "Authorization": "Bearer $authToken",
        },
      );

      if (response.statusCode == 204) {
        return {
          'statusCode': 204,
          'body': null,
        };
      }

      dynamic responseJson = returnResponse(response);

      if (kDebugMode) {
        print('The JSON response: $responseJson');
      }

      return {
        'statusCode': response.statusCode,
        'body': responseJson,
      };
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw TimeoutException('');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic errorResponse = jsonDecode(response.body);
        if (errorResponse is Map<String, dynamic>) {
          if (errorResponse.containsKey('email')) {
            var emailError = errorResponse['email'];
            if (emailError is List && emailError.isNotEmpty) {
              throw UserAlreadyExistsException(emailError.first);
            } else {
              throw UserAlreadyExistsException(emailError.toString());
            }
          }

          if (errorResponse.containsKey('msg')) {
            var otpError = errorResponse['msg'];
            if (otpError is List && otpError.isNotEmpty) {
              throw InValidOtpException(otpError.first);
            } else {
              throw InValidOtpException(otpError.toString());
            }
          }
        } else {
          throw InvalidUrlException('Invalid request: ${response.body}');
        }
      case 404:
        dynamic errorResponse = jsonDecode(response.body);
        if (errorResponse is Map<String, dynamic> &&
            errorResponse.containsKey("errors")) {
          var errors = errorResponse["errors"];
          if (errors is Map<String, dynamic> &&
              errors.containsKey("non_field_errors")) {
            var nonFieldErrors = errors["non_field_errors"];
            if (nonFieldErrors is List && nonFieldErrors.isNotEmpty) {
              throw EmailOrPasswordIncorrect(nonFieldErrors.first);
            }
          }
        }
      default:
        if (kDebugMode) {
          print('network response status code ${response.statusCode}');
        }
        throw FetchDataException(
            'Error accorded While communication with server  ${response.body}');
    }
  }
}

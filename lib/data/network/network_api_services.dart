import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../app_exception.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {
  @override
  Future getApi(String url,{String? authToken}) async {
    dynamic responseJson;
    try {
      final headers = {
        "Content-Type": "application/json",
        if (authToken != null) "Authorization": "Bearer $authToken",
      };
      final response = await http.get(Uri.parse(url), headers:headers,)
          .timeout(const Duration(seconds: 15));
      responseJson = returnResponse(response);
      print('get Response is ${response.body}');
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw TimeoutException('');
    }

    return responseJson;
  }

  @override
  Future postApi(var data, String url, {String? authToken}) async {
    if (kDebugMode) {
      print('the data $data');
      print('the url $url');
    }

    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            if (authToken != null) "Authorization": "Bearer $authToken",
          },
          body: jsonEncode(data));
      responseJson = returnResponse(response);
      if (kDebugMode) {
        print('the json response $responseJson');
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw TimeoutException('');
    }
    return responseJson;
  }

  @override
  Future patchApi(var data, String url, {String? authToken}) async {
    if (kDebugMode) {
      print('🔹 The data: $data');
      print('🔹 The URL: $url');
      print('🔹 The authToken: $authToken');
    }

    dynamic responseJson;
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

      responseJson = returnResponse(response);
      if (kDebugMode) {
        print('JSON Response: $responseJson');
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw TimeoutException('');
    }

    return responseJson;
  }


  @override
  Future getApiWithAuthentication(var data,String url,{String? authToken}) async {
    dynamic responseJson;
    try {
      final headers = {
        "Content-Type": "application/json",
        if (authToken != null) "Authorization": "Bearer $authToken",
      };
      final response =
      await http.get(Uri.parse(url),
        headers: headers,
      ).timeout(const Duration(seconds: 15));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw TimeoutException('');
    }

    return responseJson;
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

        if (errorResponse is Map<String, dynamic> &&
            errorResponse.containsKey('email')) {
          var emailError = errorResponse['email'];
          if (emailError is List && emailError.isNotEmpty) {
            throw UserAlreadyExistsException(emailError.first);
          } else {
            throw UserAlreadyExistsException(emailError.toString());
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

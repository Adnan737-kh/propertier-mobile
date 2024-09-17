import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:propertier/Network/api_urls.dart';

import '../../../extensions/navigate_to_dailpad.dart';

class PaymentApiService {
  final Dio _dio = Dio();
  PaymentApiService() {
    // Add any global headers here
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<bool> payMobIntention(
    String amount,
    String description,
  ) async {
    try {
      final response = await _dio.post(Finance.creatIntention, data: {
        "user_id": 7,
        "amount": amount,
        "description": description,
        "payment_methods": "card, easypaisa, jazzcash"
      });
      if (response.statusCode == 200) {
        navigateToUrl(response.data["redirect_url"]);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      log(e.toString());
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
    return false;
  }

  Future<bool> checkDiscountCoupon(String endpoint,
      {required BuildContext context, Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      if (response.statusCode == 200 &&
          response.data["success"] == true &&
          response.data["Data"].isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      log(e.toString());
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
    return false;
  }
}

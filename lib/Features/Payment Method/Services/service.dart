import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/Network/api_urls.dart';
import '../Sockets/sockets.dart';
import '../Views/payment_view.dart';

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
      final response = await _dio.post(Finance.createIntention, data: {
        "user_id": GetStorage().read("id").toString(),
        "amount": amount,
        "description": description,
        "payment_methods": "card"
        // easypaisa, jazzcash"
      });
      if (response.statusCode == 200) {
        // navigateToUrl(response.data["redirect_url"]);

        PaymentStatusSocketService().connect(
            "${Finance.paymentStatusSocket}${GetStorage().read("id").toString()}/");
        Get.to(() => PaymentView(
              urls: response.data["redirect_url"],
            ));
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

  Future<bool> createAdFeature(String endpoint,
      {required BuildContext context, Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      if (response.statusCode == 200) {
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

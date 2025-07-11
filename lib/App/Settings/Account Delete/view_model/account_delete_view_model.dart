import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:propertier/repository/auth_repo/delete_account/delete_account_repo.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../constant/toast.dart';
import '../../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';

class AccountDeleteViewModel extends GetxController {
  UserPreference userPreference = UserPreference();
  final DeleteAccountRepo _api = DeleteAccountRepo();
  String? _accessToken;
  String? get accessToken => _accessToken;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    userPreference.getUserAccessToken().then((value) async {
      if (kDebugMode) {
        print('Delete account page!!! ${value.accessToken}');
      }
      if (value.accessToken!.isNotEmpty ||
          value.accessToken.toString() != 'null') {
        _accessToken = value.accessToken;
      }
    });
    super.onInit();
  }

  Future<void> requestDeleteAccount() async {
    isLoading.value = true;

    if (kDebugMode) {
      print('Access token is $_accessToken');
    }

    if (_accessToken == null) {
      if (kDebugMode) {
        print('Access token is null. Cannot delete account.');
      }
      return;
    }

    try {
      await _api.deleteAccount(_accessToken!).then(
        (onValue) {
          int statusCode = onValue['statusCode'];
          dynamic body = onValue['body'];

          if (kDebugMode) {
            print('StatusCode: $statusCode');
            print('Body: $body');
          }

          if (statusCode == 201 || statusCode == 204) {
            if (kDebugMode) {
              print('StatusCode: $statusCode');
            }

            isLoading.value = false;

            userPreference.logOut().then((value) {
              Get.toNamed(AppRoutes.loginView);
            });
            // Get.offAllNamed(AppRoutes.navBarView);
            toast(title: 'Account Deleted Successfully', context: Get.context!);
          } else if (statusCode == 401) {
            isLoading.value = false;

            toast(title: 'Something Went Wrong', context: Get.context!);
          }
        },
      );
    } catch (e) {
      isLoading.value = false;
      toast(title: 'Something Went  Wrong', context: Get.context!);

      if (kDebugMode) {
        print('Error deleting account: $e');
      }
    }
  }
}

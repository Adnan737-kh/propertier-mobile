import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/toast.dart';

import '../../../../../repository/auth_repo/login_repo/login_repo.dart';
import '../../../../Auth/User/Token/token_preference_view_model/token_preference_view_model.dart';

class ChangePasswordViewModel extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final FocusNode currentPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmNewPasswordFocusNode = FocusNode();

  final _api = LoginRepository();
  final userPreference = UserPreference();

  String? _accessToken;
  String? get accessToken => _accessToken;

  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    userPreference.getUserAccessToken().then((value) async {
      if (kDebugMode) {
        print('Change Password Verification Access!!! ${value.accessToken}');
      }
      if (value.accessToken!.isNotEmpty ||
          value.accessToken.toString() != 'null') {
        _accessToken = value.accessToken;
      }
    });
    super.onInit();
  }

  void updateFocusNode(FocusNode? focusNode, BuildContext context) {
    if (focusNode != null) {
      FocusScope.of(context).requestFocus(focusNode);
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    currentPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmNewPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> changePassword(BuildContext context, String oldPassword,
      String reEnterOlPassword, String newPassword) async {
    isLoading(true);
    final Map<String, String> data = {
      'current_password': oldPassword,
      'new_password': reEnterOlPassword,
      'password_confirm': newPassword,
    };
    _api.changePassword(data, _accessToken!).then((onValue) {
      int statusCode = onValue['statusCode'];
      dynamic body = onValue['body'];
      if (kDebugMode) {
        print('Response: $body');
        print('Status Code: $statusCode');
      }

      if (statusCode == 200) {
        isLoading(true);
        Get.offAllNamed(AppRoutes.loginView);
        toast(title: 'Password Changed Successfully', context: context);
      } else {
        isLoading(true);
      }
    });
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../constant/toast.dart';
import '../../../../repository/auth_repo/login_repo/login_repo.dart';

class NewPasswordViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reNewPasswordController = TextEditingController();
  final LoginRepository _api = LoginRepository();

  var isShowPassword = false.obs;
  var isShowConfirmPassword = false.obs;
  RxBool isLoading = false.obs;

  @override
  void dispose() {
    newPasswordController.dispose();
    reNewPasswordController.dispose();
    super.dispose();
  }

  void confirmRestPassword() {
    isLoading(true);
    Map data = {
      'password': newPasswordController.text.toString(),
      'password_confirm': reNewPasswordController.text.toString(),
    };

    // // Send the model data as a Map to the API
    _api.reSetForgotPassword(data).then((onValue) async {
      CustomToast.show(title: 'Password change Successfully', context: Get.context!);
      Get.toNamed(AppRoutes.loginView);
    }).onError((error, stackTrace) {
      isLoading(false);
      if (kDebugMode) {
        print('$error and $stackTrace');
      }
    });
  }
}

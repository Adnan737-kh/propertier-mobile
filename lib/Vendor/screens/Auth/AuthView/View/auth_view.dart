import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0), () async {
      if (await GetStorage().read('user') != null) {
        Get.offAllNamed(AppRoutes
            .vendordashborad); //* Navigate to home screen if user exists
      } else {
        Get.offAllNamed(AppRoutes
            .onBoardingView); //* Navigate to home screen if user exists
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundColor,
    );
  }
}

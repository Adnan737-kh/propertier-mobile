import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/constant/colors.dart';

import '../../../../RoutesAndBindings/app_routes.dart';

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
        // LoginResponseModel result = await LoginServices().loginUser(
        //     email: user.email ?? '',
        //     context: context,
        //     password: user.hashedPassword!);

        // final newUser = User(
        //   id: result.data!.user!.id!,
        //   roleId: result.data!.user!.roleId!,
        //   name: result.data!.user!.name, // Name can be added later
        //   username: result.data!.user!.username,
        //   email: result.data!.user!.email,
        //   image: result.data!.user!.image,
        //   cover: result.data!.user!.cover,
        //   phoneNumber: result
        //       .data!.user!.phoneNumber, // Phone number can be added later
        //   createdAt: result.data!.user!.createdAt,
        //   updatedAt: result.data!.user!.updatedAt,
        //   hashedPassword: user.hashedPassword,
        // );
        // await AuthService()
        //     .registerUser(newUser, user.hashedPassword!)
        //     .whenComplete(() => Get.offAllNamed(AppRoutes.navBarView));
        Get.offAllNamed(
            AppRoutes.navBarView); //* Navigate to home screen if user exists
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

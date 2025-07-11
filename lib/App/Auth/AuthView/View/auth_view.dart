import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/constant/colors.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../Profile/ViewModel/profile_view_model.dart';
import '../../User/Token/token_preference_view_model/token_preference_view_model.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final ProfileViewModel viewModel = Get.put(ProfileViewModel());
  final UserPreference userPreference = UserPreference();

  @override
  void initState() {
    super.initState();

    final viewModel = Get.put(ProfileViewModel());
    final UserPreference userPreference = UserPreference();

    Future.delayed(Duration.zero, () async {
      try {
        final tokenData = await userPreference.getUserAccessToken();

        if (tokenData.accessToken != null &&
            tokenData.accessToken!.isNotEmpty &&
            tokenData.accessToken != 'null') {
          // Fetch profile data
          await viewModel.getProfile(
            context: Get.context!,
            accessToken: tokenData.accessToken!,
          );
          debugPrint('Access Token Found: ${tokenData.accessToken}');

          final userProfile = await userPreference.getUserProfileData();

          if (userProfile != null && userProfile.email != null) {
            debugPrint(' User profile email: ${userProfile.email}');
            debugPrint('Vendor info: ${userProfile.vendor}');

            // Navigate to home screen
            Get.offAllNamed(AppRoutes.navBarView);
          } else {
            debugPrint('User profile not found or email is null');
            Get.offAllNamed(AppRoutes.onBoardingView);
          }
        } else {
          debugPrint('Access token is missing or invalid');
          Get.offAllNamed(AppRoutes.onBoardingView);
        }
      } catch (e, stackTrace) {
        debugPrint('Error during auth flow: $e');
        debugPrint('StackTrace: $stackTrace');
        Get.offAllNamed(AppRoutes.onBoardingView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColor.buttonColor,
        ),
      ),
    );
  }
}

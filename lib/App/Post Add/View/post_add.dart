import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/NavBar/ViewModel/navbar_view_model.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
// import 'package:propertier/App/Utils/text_botton.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../constant/AppButton/text_button.dart';
import '../../../constant/constant.dart';
import '../../../Utils/height_width_box.dart';
import '../Add Properties/ViewModel/add_properties_view_model.dart';

class PostAddView extends StatelessWidget {
  PostAddView({super.key});
  final navBarVM = Get.put(NavBarViewModel());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Constant.onboardingIcon,
                  height: context.getSize.height * 0.03,
                ),
                getHeight(context, 0.075),
                // customTextButton(
                //     title: "Material",
                //     onTap: () {
                //       Get.toNamed(AppRoutes.addMaterialView);
                //     },
                //     buttonColor: AppColor.white,
                //     textColor: AppColor.darkGreyColor.withOpacity(0.7)),
                // getHeight(context, 0.008),
                // customTextButton(
                //     title: "Properties",
                //     onTap: GetStorage().read('user') == null
                //         ? () {
                //             navBarVM.changeSelectedTab(2);
                //           }
                //         : () {
                //             final cont = Get.put(UploadPropertyViewModel());
                //             Get.toNamed(AppRoutes.addPropertiesView,
                //                 arguments: cont);
                //           },
                //     buttonColor: AppColor.white,
                //     textColor: AppColor.darkGreyColor.withOpacity(0.7)),

              FutureBuilder(
                future: navBarVM.userPreference.getUserAccessToken(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator()); // Show loader while fetching data
                  }

                  if (snapshot.hasData) {
                    final accessToken = snapshot.data?.accessToken ?? "";
                    if (accessToken.isEmpty || accessToken.toLowerCase() == "null") {
                      if (kDebugMode) {
                        print('No accessToken!!! $accessToken');
                      }
                      return customTextButton(
                        title: "Properties",
                        onTap: () {
                          navBarVM.changeSelectedTab(2);
                        },
                        buttonColor: AppColor.white,
                        textColor: AppColor.darkGreyColor.withOpacity(0.7),
                      );
                    } else {
                      if (kDebugMode) {
                        print('Valid accessToken!!! $accessToken');
                      }
                      return customTextButton(
                        title: "Properties",
                        onTap: () {
                          final cont = Get.put(UploadPropertyViewModel());
                          Get.toNamed(AppRoutes.addPropertiesView, arguments: cont);
                        },
                        buttonColor: AppColor.white,
                        textColor: AppColor.darkGreyColor.withOpacity(0.7),
                      );
                    }
                  } else {
                    if (kDebugMode) {
                      print('Failed to fetch accessToken!');
                    }
                    return customTextButton(
                      title: "Properties",
                      onTap: () {
                        navBarVM.changeSelectedTab(2);
                      },
                      buttonColor: AppColor.white,
                      textColor: AppColor.darkGreyColor.withOpacity(0.7),
                    );
                  }
                },
              ),

              getHeight(context, 0.008),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

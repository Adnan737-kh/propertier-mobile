import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Home/View/component/carousel_slider_widget.dart';
import 'package:propertier/App/MyServiceOrder/View/MyServiceOrder.dart';
import 'package:propertier/App/Services/ViewModel/services_view_model.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/search_text_field.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../Vendor/screens/Auth/Service/auth_service.dart'
    as vendor_service;
import '../../../../Vendor/screens/Auth/Service/google_sigin_services.dart';
import '../../../Auth/Service/auth_service.dart';
import '../../../NavBar/ViewModel/navbar_view_model.dart';
import '../../../Profile/Model/profile_model.dart';
import '../../Model/vender_registration_model.dart';

PreferredSize servicesAppBar(BuildContext context,
    {required ServicesViewModel viewModel}) {
  return PreferredSize(
      preferredSize: Size(
          context.getSize.width,
          Platform.isAndroid
              ? context.getSize.height * 0.47
              : context.getSize.height * 0.5),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [boxShadow()],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.getSize.width * 0.030),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getHeight(context, 0.06),
              customAppBar(
                  context: context,
                  onTap: () {
                    Get.offAllNamed(AppRoutes.navBarView);
                  }),
              getHeight(context, 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.lazyPut(()=>NavBarViewModel());
                      // Change the tab to Profile (index 2) in NavBarView
                      Get.find<NavBarViewModel>().changeSelectedTab(2);
                      // Navigate to NavBarView
                      Get.offAllNamed(AppRoutes.navBarView);
                    },
                    child: CircleAvatar(
                      radius: context.getSize.width * 0.08,
                      backgroundImage:
                          NetworkImage(viewModel.profileImage.toString()),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      UserProfile? userProfileData =
                      await viewModel.userPreference.getUserProfileData();

                      if (userProfileData == null) {
                        return Get.toNamed(AppRoutes.loginView);
                      }
                      if (userProfileData.verificationStatus == "incomplete") {
                        Get.toNamed(AppRoutes.verificationView);
                      } else {
                        if (userProfileData.vendor == null) {
                          await viewModel.openSelectCategoryScreen(context);

                          if (viewModel.selectedParentServiceId == null ||
                              viewModel.selectedCategory == null) {
                            Fluttertoast.showToast(
                                msg: context.local.please_select_a_category);
                            return;
                          } else {
                            Fluttertoast.showToast(msg: context.local.please_wait);
                          }

                          VendorRegistrationModel? vendorResponse =
                              await vendor_service.AuthService().registerVendor(
                            context,
                            viewModel.accessToken!,
                          );


                          if (vendorResponse?.id != null) {
                            Get.toNamed(AppRoutes.serviceForm, arguments: {
                              'category': vendorResponse?.serviceMainCategory,
                            });
                          } else {
                            AuthService().logout();
                            GoogleSignInServices().logout();
                          }
                        } else if (userProfileData.vendor?.submittedRequirements == null) {
                          Get.toNamed(AppRoutes.serviceForm, arguments: {
                            'category': userProfileData.vendor?.assignedService?.mainCategory,
                          });
                        } else {
                          Get.toNamed(AppRoutes.vendorDashBoard);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.buttonColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 10.0,
                      ),
                    ),
                    child:  Text(context.local.switch_to_vendor,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: viewModel.userName.toString(),
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(const MyServiceOrder());
                      },
                      child: const Icon(Ionicons.cart_outline)),
                ],
              ),
              getHeight(context, 0.01),
              CarouselSliderWidget(),
              getHeight(context, 0.008),
              SearchTextField(
                  hintText: context.local.what_are_you_looking_for,
                  horzontalPadding: 0,
                  searchController: viewModel.searchController,
                  suFixIcon: Image.asset(Constant.mic))
            ],
          ),
        ),
      ));
}

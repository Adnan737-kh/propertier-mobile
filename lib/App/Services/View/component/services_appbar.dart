import 'dart:io';
import 'package:flutter/foundation.dart';
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
                      // UserLoginModel? currentUser = await AuthService().getCurrentUser();
                      // if (kDebugMode) {
                      //   print(currentUser?.users?.first.type);
                      // }
                      // if (currentUser != null) {
                      //   for(User user in currentUser.users??[]){
                      //     if(user.type == "vendor"){
                      //       GetStorage().write('vendorUserId', user.id);
                      //       Get.toNamed(AppRoutes.vendordashborad);
                      //       return;
                      //     }}}

                      UserProfile? user =
                          await viewModel.userPreference.getUserProfileData();

                      if (user == null) {
                        if (kDebugMode) {
                          print("no user**");
                        }
                        return Get.toNamed(AppRoutes.loginView);
                      }
                      if (kDebugMode) {
                        print("status ${user.vendor}");
                      }

                      if (kDebugMode) {
                        print("general status ${user.verificationStatus}");
                      }
                      if (user.verificationStatus == "incomplete") {
                        Get.toNamed(AppRoutes.verificationView);
                      } else {
                        if (user.vendor == null) {
                          await viewModel.openSelectCategoryScreen(context);

                          if (kDebugMode) {
                            print(
                                "selected services ${viewModel.selectedParentServiceId}");
                            print(
                                "selected services name ${viewModel.selectedCategory}");
                          }

                          if (viewModel.selectedParentServiceId == null ||
                              viewModel.selectedCategory == null) {
                            Fluttertoast.showToast(
                                msg: "Please Select a Category");
                            return;
                          } else {
                            Fluttertoast.showToast(msg: "Please Wait...");
                          }

                          VendorRegistrationModel? vendorResponse =
                              await vendor_service.AuthService().registerVendor(
                            context,
                            viewModel.selectedParentServiceId!,
                            viewModel.selectedCategory!,
                            viewModel.accessToken!,
                          );

                          if (vendorResponse != null) {
                            int vendorId = vendorResponse.id;
                            String? title = vendorResponse.serviceTitle;
                            String? mainCategory =
                                vendorResponse.serviceMainCategory;
                            int userId = vendorResponse.user;

                            if (kDebugMode) {
                              print("Vendor ID: $vendorId");
                              print("Service Title: $title");
                              print("Main Category: $mainCategory");
                              print("User ID: $userId");
                              print(
                                  "category else pre ${user.vendor?.submittedRequirements}");
                              print(
                                  "mainCategory else ${user.vendor?.assignedService?.mainCategory}");
                            }
                          }

                          if (vendorResponse?.id != null) {
                            Get.toNamed(AppRoutes.serviceForm, arguments: {
                              'category': vendorResponse?.serviceMainCategory,
                            });
                          } else {
                            AuthService().logout();
                            GoogleSignInServices().logout();
                          }
                        } else if (user.vendor?.submittedRequirements == null) {
                          if (kDebugMode) {
                            print(
                                "category else he ${user.vendor?.assignedService?.mainCategory}");
                          }
                          Get.toNamed(AppRoutes.serviceForm, arguments: {
                            'category':
                                user.vendor?.assignedService?.mainCategory,
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
                    child: const Text(
                      'Switch to Vendor',
                      style: TextStyle(
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
                  appText(
                    title: viewModel.userName.toString(),
                    context: context,
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
                  hintText: 'What are you looking for',
                  horzontalPadding: 0,
                  searchController: viewModel.searchController,
                  suFixIcon: Image.asset(Constant.mic))
            ],
          ),
        ),
      ));
}

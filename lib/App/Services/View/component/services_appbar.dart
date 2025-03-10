import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Auth/Login/Model/user_login_model/user_login_model.dart';
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
import '../../../../Vendor/screens/Auth/Service/auth_service.dart' as vendorService;
import '../../../../Vendor/screens/Auth/Service/google_sigin_services.dart';
import '../../../Auth/Service/auth_service.dart';
import '../../../NavBar/ViewModel/navbar_view_model.dart';

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
                      backgroundImage: NetworkImage(viewModel.profileImage.toString() ??
                          "https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    ),
                  ),
                  ElevatedButton(

                    onPressed: () async {
                      UserLoginModel? currentUser = await AuthService().getCurrentUser();
                      if (kDebugMode) {
                        print(currentUser?.users?.first.type);
                      }
                      if (currentUser != null) {
                        for(User user in currentUser.users??[]){
                          if(user.type == "vendor"){
                            GetStorage().write('vendorUserId', user.id);
                            Get.toNamed(AppRoutes.vendordashborad);
                            return;
                          }
                        }
                        await viewModel.openSelectCategoryScreen(context);

                        if (kDebugMode) {
                          print(viewModel.selectedParentServiceId);
                          print(viewModel.selectedCategory);
                        }
                        if(viewModel.selectedParentServiceId == null || viewModel.selectedCategory == null){
                          Fluttertoast.showToast(msg: "Please Select a Category");
                          return;
                        }
                        else{
                          Fluttertoast.showToast(msg: "Please Wait...");
                        }
                        String email = currentUser.users!.first.email!;
                        String firebaseID = currentUser.users!.first.firebaseId!;
                        int? vendorId = await vendorService.AuthService().RegisterVendor(context, email, firebaseID,viewModel.selectedParentServiceId!, viewModel.selectedCategory!);
                        if (kDebugMode) {
                          print("vendor id: $vendorId");
                        }
                        if(vendorId != null){
                          Get.toNamed(AppRoutes.ServiceForm, arguments: {
                            'vendorId': vendorId,
                            'serviceId':  viewModel.selectedParentServiceId,
                            'serviceName': viewModel.selectedCategory,
                            'email': currentUser.users!.first.email!,
                            'firebaseId': currentUser.users!.first.firebaseId!
                          });
                        }
                        else{
                          AuthService().logout();
                          GoogleSiginServices().logout();
                          Get.offAllNamed(AppRoutes.loginView);
                        }
                      }
                      else {
                        Get.toNamed(AppRoutes.loginView);
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
                    title: viewModel.userName.toString() ,
                    context: context,
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                  ),
                  InkWell(
                    onTap: (){
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

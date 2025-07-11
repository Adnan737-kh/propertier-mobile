import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/App/Drawer/View/drawer.dart';
import 'package:propertier/App/Home/View/home_view.dart';
import 'package:propertier/App/NavBar/ViewModel/navbar_view_model.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/Components/overlayWidget.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/ViewModel/add_properties_view_model.dart';
import 'package:propertier/App/Profile/View/profile_view.dart';
import 'package:propertier/App/UserNotLogin/view/user_not_login_view.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../Post Add/View/post_add.dart';
import '../../Services/View/services_view.dart';
import '../../updates/updates_view/updates_view.dart';

class NavBarView extends StatelessWidget {
  final vm = Get.find<UploadPropertyViewModel>();
  NavBarView({super.key}) {
    // Register the NavBarViewModel if not already registered
    if (!Get.isRegistered<NavBarViewModel>()) {
      Get.put(NavBarViewModel());
    }

    final navBarViewModel = Get.find<NavBarViewModel>();
    final index = Get.arguments?['initialIndex'];
    if (index != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        navBarViewModel.setInitialIndex(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX<NavBarViewModel>(builder: (viewModel) {
      return Scaffold(
        drawer: customDrawer(context: context),
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: context.getSize.height,
              child: Builder(builder: (context) {
                if (viewModel.selectedTabIndex == 0) {
                  return HomeView();
                } else if (viewModel.selectedTabIndex == 1) {
                  return const UpdatesView();
                } else if (viewModel.selectedTabIndex == 2) {
                  return PostAddView();
                } else if (viewModel.selectedTabIndex == 3) {
                  return ServicesView();
                } else if (viewModel.selectedTabIndex == 4) {
                  return FutureBuilder(
                    future: viewModel.userPreference.getUserAccessToken(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasData) {
                        final accessToken = snapshot.data?.accessToken ?? "";
                        if (accessToken.isEmpty ||
                            accessToken.toLowerCase() == "null") {
                          return const UserNotLoginView();
                        } else {
                          return const ProfileStatusView();
                        }
                      } else {
                        return const UserNotLoginView(); // Fallback in case of error
                      }
                    },
                  );
                }

                return const SizedBox.shrink();
              }),
            ),
            CurvedNavigationBar(
              iconPadding: 0,
              color: AppColor.buttonColor,
              index: viewModel.selectedTabIndex,
              backgroundColor: Colors.transparent,
              items: [
                CurvedNavigationBarItem(
                  labelStyle: textStyle(
                      context: context,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  child: Container(
                    padding: viewModel.selectedTabIndex == 0
                        ? const EdgeInsets.all(10)
                        : null,
                    decoration: viewModel.selectedTabIndex == 0
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color:
                                    const Color.fromRGBO(255, 255, 255, 0.80),
                                width: 5))
                        : null,
                    child: Image.asset(
                      Constant.eState,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  label: viewModel.selectedTabIndex == 0
                      ? ''
                      : context.local.properties,
                ),
                CurvedNavigationBarItem(
                  labelStyle: textStyle(
                      context: context,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  child: Container(
                    padding: viewModel.selectedTabIndex == 1
                        ? const EdgeInsets.all(10)
                        : null,
                    decoration: viewModel.selectedTabIndex == 1
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color:
                                    const Color.fromRGBO(255, 255, 255, 0.80),
                                width: 5))
                        : null,
                    child: SvgPicture.asset(
                      Constant.updates,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  label: viewModel.selectedTabIndex == 1
                      ? ''
                      : context.local.updates,
                ),
                CurvedNavigationBarItem(
                  labelStyle: textStyle(
                      context: context,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  child: Container(
                    padding: viewModel.selectedTabIndex == 2
                        ? const EdgeInsets.all(10)
                        : null,
                    decoration: viewModel.selectedTabIndex == 2
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color:
                                    const Color.fromRGBO(255, 255, 255, 0.80),
                                width: 5))
                        : null,
                    child: SvgPicture.asset(
                      Constant.addPost,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  label: viewModel.selectedTabIndex == 2
                      ? ''
                      : context.local.post_ad,
                ),
                CurvedNavigationBarItem(
                  labelStyle: textStyle(
                      context: context,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  child: Container(
                    padding: viewModel.selectedTabIndex == 3
                        ? const EdgeInsets.all(10)
                        : null,
                    decoration: viewModel.selectedTabIndex == 3
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color:
                                    const Color.fromRGBO(255, 255, 255, 0.80),
                                width: 5))
                        : null,
                    child: SvgPicture.asset(
                      Constant.plumber2,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  label: viewModel.selectedTabIndex == 3
                      ? ''
                      : context.local.services,
                ),
                CurvedNavigationBarItem(
                  labelStyle: textStyle(
                      context: context,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  child: Container(
                    padding: viewModel.selectedTabIndex == 3
                        ? const EdgeInsets.all(10)
                        : null,
                    decoration: viewModel.selectedTabIndex == 3
                        ? BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color:
                                    const Color.fromRGBO(255, 255, 255, 0.80),
                                width: 5))
                        : null,
                    child: Image.asset(
                      Constant.person,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  label: viewModel.selectedTabIndex == 3
                      ? ''
                      : context.local.profile,
                ),
              ],
              onTap: (index) {
                viewModel.changeSelectedTab(index);
              },
            ),
            if (viewModel.selectedTabIndex == 2)
              Positioned(
                  left: context.getSize.width * 0.090,
                  top: context.getSize.height * 0.050,
                  child: Builder(builder: (context) {
                    return GetStorage().read('user') == null
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child:
                                const Icon(Icons.menu, color: AppColor.white));
                  })),
            if (vm.isOverlayVisible.value == true)
              Positioned(top: 40, child: OverlayWidget()),
          ],
        ),
      );
    });
  }
}

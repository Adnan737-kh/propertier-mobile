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
import 'package:propertier/extensions/size_extension.dart';

import '../../Post Add/View/post_add.dart';

class NavBarView extends StatelessWidget {
  NavBarView({super.key});
  final vm = Get.find<UploadPropertyViewModel>();
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    // bool isOpenKeyboard = MediaQuery.of(context).viewInsets.bottom > 0;
    return GetX<NavBarViewModel>(
        init: NavBarViewModel(),
        builder: (viewModel) {
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
                    } else if (viewModel.selectedTabIndex == 2) {
                      // return viewModel.accessToken.value?.isEmpty ?? true
                      //     ? const UserNotLoginView()
                      //     : ProfileStatusView();

                      return  FutureBuilder(
                        future: viewModel.userPreference.getUserAccessToken(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator()); // Show loader while fetching data
                          }

                          if (snapshot.hasData) {
                            final accessToken = snapshot.data?.accessToken ?? "";
                            if (accessToken == null || accessToken.isEmpty || accessToken.toLowerCase() == "null") {
                              print('No accessToken!!! $accessToken');
                              return const UserNotLoginView();
                            } else {
                              print('Valid accessToken!!! $accessToken');
                              return ProfileStatusView();
                            }
                          } else {
                            print('Fall accessToken!!!');
                            return const UserNotLoginView(); // Fallback in case of error
                          }
                        },
                      );

                    } else if (viewModel.selectedTabIndex == 1) {
                      return PostAddView();
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
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.80),
                                    width: 5))
                            : null,
                        child: Image.asset(
                          Constant.eState,
                          height: 25,
                          width: 25,
                        ),
                      ),
                      label:
                          viewModel.selectedTabIndex == 0 ? '' : 'Properties',
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
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.80),
                                    width: 5))
                            : null,
                        child: SvgPicture.asset(
                          Constant.addPost,
                          height: 25,
                          width: 25,
                        ),
                      ),
                      label: viewModel.selectedTabIndex == 1 ? '' : 'Post Add',
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
                                    color: const Color.fromRGBO(
                                        255, 255, 255, 0.80),
                                    width: 5))
                            : null,
                        child: Image.asset(
                          Constant.person,
                          height: 25,
                          width: 25,
                        ),
                      ),
                      label: viewModel.selectedTabIndex == 2 ? '' : 'Profile',
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
                                child: const Icon(Icons.menu,
                                    color: AppColor.white));
                      })),
                if (vm.isOverlayVisible.value == true)
                  Positioned(top: 40, child: OverlayWidget()),
              ],
            ),
          );
        });
  }
}

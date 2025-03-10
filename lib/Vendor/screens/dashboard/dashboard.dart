import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:propertier/App/NavBar/View/nav_bar_view.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Vendor/screens/dashboard/Posts/post_screen.dart';
import 'package:propertier/Vendor/screens/dashboard/earnings/view/earning_screen.dart';
import 'package:propertier/Vendor/screens/dashboard/fearture_ads/view/feature_ads_screen.dart';
import 'package:propertier/Vendor/screens/dashboard/home/view/home_screen.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/controller/profile_controller.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/view/profile.dart';
import 'package:propertier/Vendor/screens/dashboard/viewmodel/DashboardViewModel.dart';
import 'package:propertier/Vendor/screens/widgets/drawer_widget.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin<Dashboard> {
  final ProfileController profileController = Get.put(ProfileController());
  int selectedIndex = 0;
  bool isDrawerOpen = false;

  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  Future<void> _navigateToFeatureAds() async {
    setState(() {
      selectedIndex = 1; // Index for FeatureAdsScreen
    });
  }

  final DashboardViewModel dashboardViewModel = Get.put(DashboardViewModel());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashboardViewModel.startLocationLoop();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dashboardViewModel.stopLocationLoop();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              if (selectedIndex == 0) // Show AppBar only on the Requests screen
                AppBar(
                  backgroundColor: const Color(0xFF131A22),
                  iconTheme: const IconThemeData(color: Colors.white, size: 29),
                  actions: [
                    Container(
                      margin: const EdgeInsets.only(top: 9, bottom: 9),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColor.buttonColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Get.offAllNamed(AppRoutes.navBarView);
                          Get.put(NavBarView());
                        },
                        child: const Text(
                          'Switch to Client',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                  ],
                  leading: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: toggleDrawer,
                  ),
                ),
              Expanded(
                child: IndexedStack(
                  index: selectedIndex,
                  children: [
                    const HomeScreen(),
                    const FeatureAdsScreen(),
                    const PostScreen(),
                    const EarningScreen(),
                    ProfileScreen(
                      onViewAllTap: () {
                        setState(() {
                          selectedIndex = 1; // Navigate to Feature Ads
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: const Color(0xFFFFCE58),
              index: selectedIndex,
              items: [
                CurvedNavigationBarItem(
                  child: SvgPicture.asset(
                   Constant.vendorHomeIcon,
                  ),
                  label: selectedIndex == 0 ? '' : 'Requests',
                  labelStyle: const TextStyle(
                    color: Color(0xFF131A22),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CurvedNavigationBarItem(
                  child: Image.asset(Constant.vendorFeturedadIcon),
                  label: selectedIndex == 1 ? '' : 'Feature Ads',
                  labelStyle: const TextStyle(
                    color: Color(0xFF131A22),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CurvedNavigationBarItem(
                  child: SvgPicture.asset(
                    Constant.vendorAddPostIcon,
                  ),
                  label: selectedIndex == 2 ? '' : 'Post Add',
                  labelStyle: const TextStyle(
                    color: Color(0xFF131A22),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CurvedNavigationBarItem(
                  child: SvgPicture.asset(Constant.vendorEarningIcon),
                  label: selectedIndex == 3 ? '' : 'Earnings',
                  labelStyle: const TextStyle(
                    color: Color(0xFF131A22),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CurvedNavigationBarItem(
                  child: SvgPicture.asset(
                    Constant.vendorProfileIcon,
                  ),
                  label: selectedIndex == 4 ? '' : 'Profile',
                  labelStyle: const TextStyle(
                    color: Color(0xFF131A22),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              onTap: (index) {
                if (index == 1) {
                  _navigateToFeatureAds(); // Fetch data and navigate to Feature Ads
                } else {
                  setState(() {
                    selectedIndex = index;
                  });
                }
              },
            ),
          ),
          if (isDrawerOpen)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: toggleDrawer,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 100,
                        child: DrawerWidget(
                          onToggleDrawer: toggleDrawer,
                          onItemSelected: (index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

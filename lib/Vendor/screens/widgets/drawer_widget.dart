import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Vendor/screens/Auth/Login/View/login_view.dart';
import 'package:propertier/Vendor/screens/Auth/Login/ViewModel/login_view_model.dart';
import 'package:propertier/Vendor/screens/Auth/Service/auth_service.dart';
import 'package:propertier/Vendor/screens/Auth/Service/google_sigin_services.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/controller/profile_controller.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/view/profile.dart';
import 'package:propertier/Vendor/screens/drawer/activity/view/select_activity_screen.dart';
import 'package:propertier/Vendor/screens/drawer/edit_profile/view/edit_profile_screen.dart';
import 'package:propertier/Vendor/screens/drawer/languages/view/language_screen.dart';
import 'package:propertier/Vendor/screens/drawer/offered_service/view/offered_service.dart';
import 'package:propertier/Vendor/screens/drawer/orders/view/order_screen.dart';
import 'package:propertier/Vendor/screens/drawer/policy/view/policy_screen.dart';
import 'package:propertier/Vendor/screens/drawer/privacy/view/privacy_screen.dart';
import 'package:propertier/Vendor/screens/drawer/review/view/review_screen.dart';
import 'package:propertier/Vendor/screens/drawer/setting/view/setting_screen.dart';
import 'package:propertier/Vendor/screens/drawer/support/view/support_screen.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/select_verfication_screen.dart';
import 'package:propertier/constant/colors.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.loadProfile();
  }

  double? _rating;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(profileController
                              .profile.value.profilePictureUrl ??
                          "https://images.unsplash.com/photo-1719054415148-b83895be5157?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90b3MtZmVlZHw0NHx8fGVufDB8fHx8fA%3D%3D"),
                      fit: BoxFit.cover,
                    ),
                    shape: const OvalBorder(),
                  ),
                ),
                const SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profileController.profile.value.name.toString(),
                        style: const TextStyle(
                          color: Color(0xFF131A22),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 0.07,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      RatingBar.builder(
                        initialRating: profileController.profile.value.rating
                                ?.toDouble() ??
                            0,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        onRatingUpdate: (rating) async {},
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Menu Items
          ListTile(
            leading: SvgPicture.asset(
              'assets/vendor_assets/profile.svg',
              color: const Color(0x99131A22),
              height: 18,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const ProfileScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/account.svg'),
            title: const Text(
              'Account Status',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/verify.svg'),
            title: const Text(
              'Verification',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const SelectVerficationScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/edit.svg'),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const EditProfileScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/analytics.svg'),
            title: const Text(
              'Analytics',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/setting.svg'),
            title: const Text(
              'Settings',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const SettingScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/ads.svg'),
            title: const Text(
              'Ads',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/order.svg'),
            title: const Text(
              'Orders',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const OrderScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/review.svg'),
            title: const Text(
              'Reviews',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const ReviewScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/language.svg'),
            title: const Text(
              'Languages',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const LanguageScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/privacy.svg'),
            title: const Text(
              'Privacy',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const PrivacyScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/policy.svg'),
            title: const Text(
              'Policy',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const PolicyScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/support.svg'),
            title: const Text(
              'Support',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const SupportScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/info.svg'),
            title: const Text(
              'Offered Services',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const OfferedService());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/activity.svg'),
            title: const Text(
              'Activity',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const SelectActivityScreen());
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/vendor_assets/payout.svg'),
            title: const Text(
              'Payout',
              style: TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {},
          ),

// Logout Button
          InkWell(
            onTap: () {
              Get.put(LoginViewModel());
              AuthService().logout();
              GoogleSiginServices().logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginView(),
                ),
              );
            },
            child: Container(
              width: context.width,
              height: 60,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: AppColor.buttonColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.logout,
                      color: AppColor.backgroundColor,
                    ),
                  ),
                  appText(
                      title: "Sign Out",
                      context: context,
                      fontWeight: FontWeight.bold)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

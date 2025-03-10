import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Vendor/screens/Auth/Login/View/login_view.dart';
import 'package:propertier/Vendor/screens/Auth/Login/ViewModel/login_view_model.dart';
import 'package:propertier/Vendor/screens/Auth/Service/auth_service.dart';
import 'package:propertier/Vendor/screens/Auth/Service/google_sigin_services.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/controller/profile_controller.dart';
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
import 'package:propertier/constant/constant.dart';

import '../drawer/vehicle_list/VehicleList.dart';


class DrawerWidget extends StatefulWidget {
  final VoidCallback onToggleDrawer;
  final Function(int) onItemSelected;

  const DrawerWidget({
    Key? key,
    required this.onToggleDrawer,
    required this.onItemSelected,
  }) : super(key: key);

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

  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.primaryColor,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
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
                          color: Colors.white,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              Constant.vendorProfileIcon,
              color: Colors.white,
              height: 18,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              // Use the passed function to update the selected index and close the drawer
              widget.onItemSelected(4); // Profile screen index
              widget.onToggleDrawer(); // Close the drawer
            },
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(
              Constant.vendorProfileIcon,
              color: Colors.white,
              height: 18,
            ),
            title: const Text(
              'Wallet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              widget.onToggleDrawer(); // Close the drawer
              Get.toNamed(AppRoutes.VendorWallet);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              Constant.vendorProfileIcon,
              color: Colors.white,
              height: 18,
            ),
            title: const Text(
              'Verification Form',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              widget.onToggleDrawer(); // Close the drawer
              Get.toNamed(AppRoutes.VendorForm);
            },
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(
              Constant.verifyIcon,
              color: Colors.white,
            ),
            title: const Text(
              'Verification',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Get.to(() => const SelectVerficationScreen());
            },
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.editProfileIcon,
                color: Colors.white),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Get.to(() => const EditProfileScreen());
            },
          ),
          divider(context: context),
          if(profileController.profile.value.professionTypes != null && profileController.profile.value.professionTypes!.length == 2 && (profileController.profile.value.professionTypes![1] == "Driver" || profileController.profile.value.professionTypes![1] == "Transport"))
          ListTile(
            leading: SvgPicture.asset(
              Constant.verifyIcon,
              color: Colors.white,
            ),
            title: const Text(
              'My Vehicles',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Get.to(() => const VehicleList());
            },
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.analyticsIcon,
                color: Colors.white),
            title: const Text(
              'Analytics',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {},
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.settingIcon,
                color: Colors.white),
            title: const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Get.to(() => const SettingScreen());
            },
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.adsIcon,
                color: Colors.white),
            title: const Text(
              'Ads',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {},
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.orderIcon,
                color: Colors.white),
            title: const Text(
              'Orders',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Get.to(() => const OrderScreen());
            },
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.reviewIcon,
                color: Colors.white),
            title: const Text(
              'Reviews',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Get.to(() => const ReviewScreen());
            },
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.reviewIcon,
                color: Colors.white),
            title: const Text(
              'Languages',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Get.to(() => const LanguageScreen());
            },
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.privacyIcon,
                color: Colors.white),
            title: const Text(
              'Privacy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Get.to(() => const PrivacyScreen());
            },
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.policyIcon,
                color: Colors.white),
            title: const Text(
              'Policy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Get.to(() => const PolicyScreen());
            },
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.supportIcon,
                color: Colors.white),
            title: const Text(
              'Support',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              Get.to(() => const SupportScreen());
            },
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.infoIcon,
                color: Colors.white),
            title: const Text(
              'Offered Services',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const OfferedService());
            },
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.activityIcon,
                color: Colors.white),
            title: const Text(
              'Activity',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            onTap: () {
              Get.to(() => const SelectActivityScreen());
            },
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.payoutIcon,
                color: Colors.white),
            title: const Text(
              'Payout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {},
          ),
          divider(context: context),
          ListTile(
            leading: SvgPicture.asset(Constant.analyticsIcon,
                color: Colors.white),
            title: const Text(
              'Delete Account',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text(
                      "All data related to this account will be deleted. This action cannot be undone.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                          AuthService().deleteVender();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text("Delete"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          divider(context: context),
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
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: AppColor.buttonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.logout,
                      color: AppColor.backgroundColor,
                    ),
                  ),
                  appText(
                    title: "Sign Out",
                    context: context,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

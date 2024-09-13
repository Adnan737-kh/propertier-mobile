import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/drawer/edit_profile/view/edit_profile_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: Get.size.width,
           height: Get.height * .124,
            padding: const EdgeInsets.only(top: 38, left: 8),
            decoration: ShapeDecoration(
              color: const Color(0xFF131A22),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.black.withOpacity(0.05),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 10,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Alternative to Get.back()
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Setting',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 34),
          VerificationWidget(
            text: 'Edit Profile',
            onTap: () {
              Get.to(() => const EditProfileScreen());
            },
          ),
          VerificationWidget(
            text: 'Verification',
            onTap: () {},
          ),
          VerificationWidget(
            text: 'Earnings',
            onTap: () {
              // Get.to(() => IdCardVerificationScreen());
            },
          ),
          VerificationWidget(
            text: 'Reviews',
            onTap: () {
              // Get.to(() => IncorporationErrorScreen());
            },
          ),
          VerificationWidget(
            text: 'Language',
            onTap: () {},
          ),
          VerificationWidget(
            text: 'Payout',
            onTap: () {
              // Get.to(() => TextDocumentErrorScreen());
            },
          ),
        ],
      ),
    );
  }
}

class VerificationWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const VerificationWidget({
    super.key,
    required this.text,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFD1D8E0)),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Color(0x99131A22),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color(0xFF131A22),
            ),
          ],
        ),
      ),
    );
  }
}

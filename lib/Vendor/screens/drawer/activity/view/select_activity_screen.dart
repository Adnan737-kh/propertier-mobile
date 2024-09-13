import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/drawer/activity/view/activity_screen.dart';

class SelectActivityScreen extends StatefulWidget {
  const SelectActivityScreen({super.key});

  @override
  State<SelectActivityScreen> createState() => _SelectActivityScreenState();
}

class _SelectActivityScreenState extends State<SelectActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         Container(
              width: Get.size.width,
              height: Get.height * .093,
              padding: const EdgeInsets.only(top: 30, left: 8),
              decoration: ShapeDecoration(
                color: const Color(0xFF131A22),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.black.withOpacity(0.05000000074505806),
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
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  const SizedBox(width: 4),
                  const Text(
                    'Activity',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 34,
          ),
          VerificationWidget(
            text: 'Your Posts',
            onTap: () {
              Get.to(() => ActivityScreen());
            },
          ),
          VerificationWidget(
            text: 'Order Cancelled',
            onTap: () {},
          ),
          VerificationWidget(
            text: 'Withdrawls',
            onTap: () {
              // Get.to(() => IdCardVerificationScreen());
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
        // height: 47,
        margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),

        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFD1D8E0)),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0x99131A22),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color(0xFF131A22),
            )
          ],
        ),
      ),
    );
  }
}

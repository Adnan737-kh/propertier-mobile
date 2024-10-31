import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/dashboard/dashboard.dart';

class SuccessScreen extends StatefulWidget {
  final String text;
  const SuccessScreen({super.key, required this.text});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              width: Get.size.width,
              height: Get.height * .1,
              padding: const EdgeInsets.only(top: 36, left: 8),
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
                  Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: Get.height * .24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/vendor_assets/done.png',
                  height: Get.height * .1,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Congratulation!',
                  style: TextStyle(
                    color: Color(0xB2131A22),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'your ID Card is  Verified',
                  style: TextStyle(
                    color: Color(0xB2131A22),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: Get.height * .2,
                ),
                InkWell(
                  onTap: () {
                    Get.offAll(() => const Dashboard());
                  },
                  child: Container(
                    width: Get.size.width,
                    height: Get.height * .071,
                    // height: 58,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFDCD54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Color(0xFF131A22),
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../success_screen.dart';

class OpenCameraScreen extends StatefulWidget {
  const OpenCameraScreen({super.key});

  @override
  State<OpenCameraScreen> createState() => _OpenCameraScreenState();
}

class _OpenCameraScreenState extends State<OpenCameraScreen> {
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
                  const Text(
                    'Face Verification',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: Get.height * .14,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                DottedBorder(
                    color: Colors.grey.shade600,
                    dashPattern: const [9, 4],
                    child: SizedBox(
                      height: Get.height * .32,
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black45,
                          size: 38,
                        ),
                      ),
                    )),
                const SizedBox(height: 8),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Please Take photo of your ',
                        style: TextStyle(
                          color: Color(0xB2131A22),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Face',
                        style: TextStyle(
                          color: Color(0xFF4286F5),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * .12,
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                        () => const SuccessScreen(text: 'Face Verification'));
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
                        'Send',
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/widgets/round_checkbox.dart';
import 'package:propertier/extensions/localization_extension.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool isMe = false;
  bool isEvery = false;
  bool isprivate = false;
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
                    context.local.privacy,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 34,
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.lock),
                          const SizedBox(width: 7),
                          Text(
                            context.local.private_account,
                            style: const TextStyle(
                              color: Color(0xE5131A22),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      CupertinoSwitch(
                        value: isprivate,
                        // activeColor: Color(0xFFE6CF00),
                        activeColor: Colors.amber,
                        onChanged: (value) {
                          setState(() {
                            isprivate = value;
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    color: Colors.black26,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.local.comment,
                        style: const TextStyle(
                          color: Color(0xE5131A22),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'Every One',
                        style: TextStyle(
                          color: Color(0xB2131A22),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    color: Colors.black26,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.local.posts,
                        style: const TextStyle(
                          color: Color(0xE5131A22),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'Every One',
                        style: TextStyle(
                          color: Color(0xB2131A22),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    color: Colors.black26,
                  ),
                ],
              )),
          const Spacer(),
          Container(
            width: Get.size.width,
            height: 237,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7F7F7),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.local.only_me,
                            style: const TextStyle(
                              color: Color(0xFF596068),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            context.local.only_you_can_see_your_comments,
                            style: const TextStyle(
                              color: Color(0xB2131A22),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      RoundCheckbox(
                        value: isMe,
                        activeColor: Colors.amber,
                        // activeColor: Colors.grey,
                        onChanged: (value) {
                          setState(() {
                            isMe = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7F7F7),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Every one',
                            style: TextStyle(
                              color: Color(0xFF596068),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            context.local.every_one_can_see_your_comments,
                            style: const TextStyle(
                              color: Color(0xB2131A22),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      RoundCheckbox(
                        value: isEvery,
                        activeColor: Colors.amber,
                        onChanged: (value) {
                          setState(() {
                            isEvery = value;
                          });
                        },
                      ),
                    ],
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

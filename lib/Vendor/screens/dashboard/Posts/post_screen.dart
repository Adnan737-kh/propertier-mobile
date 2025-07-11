import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/constant/constant.dart';

import '../../../../RoutesAndBindings/app_routes.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * .08,
          ),
          Image.asset(
            Constant.appLogo,
            height: Get.height * .06,
          ),
          SizedBox(
            height: Get.height * .35,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.vendorAddPostScreen);
              },
              child: Container(
                height: Get.height * .066,
                width: Get.width * .88,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 160, 158, 158),
                    borderRadius: BorderRadius.circular(6)),
                child: const Center(
                  child: Text(
                    'Add Post',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xE5131A22)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

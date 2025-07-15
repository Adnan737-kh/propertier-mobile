import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../constant/colors.dart';
import '../../../../../../Utils/app_text.dart';

Widget verifyTile({
  required String verify,
  required String title,
  Function()? onTap,
}) {
  var context = Get.context!;

  Widget statusIcon;
  switch (verify) {
    case "unverified":
      statusIcon = Image.asset("assets/icons/AlertIcon.png", width: 27);
      break;
    case "pending":
      statusIcon = const CustomText(
        title: '✓ ',
        fontSize: 32,
        color: AppColor.buttonColor,
      );
      break;
    case "verified":
      statusIcon = const CustomText(
        title: '✓ ',
        fontSize: 32,
        color: AppColor.greenColor,
      );
      break;
    default:
      statusIcon = Image.asset("assets/icons/AlertIcon.png", width: 27);
      break;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFEFEFE),
            boxShadow: [
              BoxShadow(
                color: AppColor.blackColor.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(-1, 1),
                spreadRadius: 0,
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    statusIcon,
                    const SizedBox(width: 8),
                    CustomText(
                      title: title,
                      colorOpecity: 0.60,
                    ),
                  ],
                ),
                const Icon(Icons.keyboard_arrow_right_rounded),
              ],
            ),
          ),
        ),
      ),

      // Below the card: Status text
      const SizedBox(height: 3),
      _buildStatusText(verify, title,context),
      const SizedBox(height: 6),
    ],
  );
}

Widget _buildStatusText(String verify,String title, BuildContext context) {
  String text;
  Color color;

  switch (verify) {
    case 'unverified':
      text = '$title Verification required';
      color = Colors.red;
      break;
    case 'pending':
      text = '$title Verification in progress';
      color = Colors.orange;
      break;
    case 'verified':
      text = '$title Verification complete';
      color = Colors.green;
      break;
    default:
      return const SizedBox(); // no text
  }

  return Padding(
    padding: const EdgeInsets.only(top: 4.0),
    child: CustomText(
      title: text,
      fontSize: 12,
      color: color,
    ),
  );
}


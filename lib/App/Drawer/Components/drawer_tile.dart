import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';

Widget drawerTile(
    {required String title, required BuildContext context, Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              title: title,
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal),
          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white)
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';

Widget saleDetailAtribute({
  required BuildContext context,
  required String title,
  required String data,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(title: title, ),
      CustomText(title: data, fontSize: 10, colorOpecity: 0.7)
    ],
  );
}

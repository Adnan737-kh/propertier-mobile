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
      appText(title: title, context: context),
      appText(title: data, context: context, fontSize: 10, colorOpecity: 0.7)
    ],
  );
}

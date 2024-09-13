import 'package:flutter/cupertino.dart';
import 'package:propertier/Utils/app_text.dart';

detailsTitle({required BuildContext context, required String title}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: appText(
        textAlign: TextAlign.left,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        title: title,
        context: context),
  );
}

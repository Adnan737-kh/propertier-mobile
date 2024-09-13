import 'package:flutter/material.dart';
import 'package:propertier/extensions/size_extension.dart';

Container divider(
    {double height = 1,
    double withOpacity = 1,
    required BuildContext context,
    Color? color}) {
  return Container(
    width: context.getSize.width,
    height: height,
    color: color ?? const Color(0xff797979).withOpacity(withOpacity),
  );
}

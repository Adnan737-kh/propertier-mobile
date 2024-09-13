import 'package:flutter/material.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

Image logoTile(BuildContext context) {
  return Image.asset(
    Constant.onboardingIcon,
    height: context.getSize.height * 0.053,
  );
}

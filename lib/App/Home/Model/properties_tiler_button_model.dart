import 'package:flutter/widgets.dart';

class PropertiesTileButtonModel {
  String title;
  Function(String?) onTap;
  Color color;
  IconData? icon;
  Color titleColor;
  Color borderColor;
  PropertiesTileButtonModel(
      {required this.onTap,
      required this.titleColor,
      required this.borderColor,
      required this.title,
      required this.color,
      required this.icon});
}

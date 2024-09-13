import 'package:flutter/material.dart';

boxShadow({
  double xOffset = -1,
  double yOffset = 1,
  double blurRadius = 4,
  double spreadRadius = 0,
  Color color = Colors.black,
  double opacity = 0.1,
}) {
  return BoxShadow(
      color: color.withOpacity(opacity),
      offset: Offset(xOffset, yOffset),
      blurRadius: blurRadius,
      spreadRadius: spreadRadius);
}

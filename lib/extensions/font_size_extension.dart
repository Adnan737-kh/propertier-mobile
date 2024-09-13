import 'package:flutter/material.dart';

extension FontSizeExtension on BuildContext {
  double fontSize(double fontsize) =>
      MediaQuery.of(this).textScaler.scale(fontsize);
}

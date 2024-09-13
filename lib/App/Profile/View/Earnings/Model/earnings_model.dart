import 'package:flutter/material.dart';

class EarningsModel {
  String title;
  VoidCallback onTap;
  EarningsModel({
    required this.onTap,
    required this.title,
  });
}

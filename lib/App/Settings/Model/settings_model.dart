import 'package:flutter/material.dart';

class SettingsModel {
  final String title;
  final VoidCallback onTap;
  SettingsModel({required this.onTap, required this.title});
}

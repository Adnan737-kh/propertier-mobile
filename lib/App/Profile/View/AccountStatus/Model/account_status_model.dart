import 'package:flutter/material.dart';

class AccountStatusModel {
  String title;
  VoidCallback onTap;
  AccountStatusModel({required this.onTap, required this.title});
}

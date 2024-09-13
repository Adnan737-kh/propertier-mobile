import 'package:flutter/material.dart';

class ChartSubtitleModel {
  final String _subtitle;
  final Color _color;
  ChartSubtitleModel({required String subtitle, required Color color})
      : _color = color,
        _subtitle = subtitle;

  String get subtitle => _subtitle;
  Color get color => _color;
}

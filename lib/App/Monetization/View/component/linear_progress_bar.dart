import 'dart:math';

import 'package:flutter/material.dart';
import 'package:propertier/constant/colors.dart';

class LinearProgressBarPainter extends CustomPainter {
  final double value;
  final Color color;

  LinearProgressBarPainter({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round;
    Paint paint2 = Paint()
      ..color = const Color(0xffD9D9D9)
      ..strokeWidth = size.height
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, size.height / 2), // Start point
      Offset(size.width, size.height / 2), // End point
      paint2,
    );
    canvas.drawLine(
      Offset(0, size.height / 2), // Start point
      Offset(size.width * value, size.height / 2), // End point
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

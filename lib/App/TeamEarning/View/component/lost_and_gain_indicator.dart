import 'dart:math';

import 'package:flutter/material.dart';
import 'package:propertier/constant/colors.dart';

class LostAndGainCircularProgressPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double value;

  LostAndGainCircularProgressPainter({
    required this.strokeWidth,
    required this.color,
    required this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    final double radius = min(size.width, size.height) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw background circle
    // canvas.drawCircle(center, radius, paint..color = Colors.transparent);

    // Draw progress arc
    final double arcAngle = 2 * pi * value;
    const double arcAngle2 = 2 * pi * 1;
    canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        -pi / 2,
        arcAngle2,
        false,
        paint..color = AppColor.lightBlueColor);
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -pi / 2,
      arcAngle,
      false,
      paint
        ..shader = LinearGradient(
          colors: [color, color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

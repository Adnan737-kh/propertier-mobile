import 'dart:math';

import 'package:flutter/material.dart';
import 'package:propertier/constant/colors.dart';

class TeamEarningCircularProgressPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double value;
  final double innervalue;

  TeamEarningCircularProgressPainter({
    required this.strokeWidth,
    required this.innervalue,
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
    final Paint paint2 = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;
    final Paint paint3 = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    final double radius = min(size.width, size.height) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius2 = min(size.width - 60, size.height) / 2;
    final Offset center2 = Offset(size.width / 2, size.height / 2);

    // Draw background circle
    // canvas.drawCircle(center, radius, paint..color = Colors.transparent);

    // Draw progress arc
    final double arcAngle = 2 * pi * value;
    final double arcAngle2 = 2 * pi * innervalue;
    const double arcAngle3 = 2 * pi * 1;
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      pi / 2,
      arcAngle3,
      false,
      paint3..color = const Color.fromRGBO(113, 117, 122, 0.05),
    );
    canvas.drawArc(
        Rect.fromCircle(
          center: center2,
          radius: radius2,
        ),
        pi / 2,
        arcAngle3,
        false,
        paint3..color = const Color.fromRGBO(113, 117, 122, 0.10));
    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      pi / 2,
      arcAngle,
      false,
      paint
        ..shader = LinearGradient(
          colors: [color.withOpacity(1), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: center2,
        radius: radius2,
      ),
      pi / 2,
      arcAngle2,
      false,
      paint2
        ..shader = LinearGradient(
          colors: [AppColor.buttonColor.withOpacity(1), AppColor.buttonColor],
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

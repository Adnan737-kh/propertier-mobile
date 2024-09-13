import 'package:flutter/material.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:text_scroll/text_scroll.dart';

scrollableText(
    {required BuildContext context,
    required TextStyle textStyle,
    required String title,
    double width = 0.55,
    TextAlign textAlign = TextAlign.right}) {
  return SizedBox(
    width: context.getSize.width * width,
    child: TextScroll(
      title,
      mode: TextScrollMode.bouncing,
      velocity: const Velocity(pixelsPerSecond: Offset(150, 0)),
      delayBefore: const Duration(seconds: 2),
      numberOfReps: 1,
      pauseBetween: const Duration(milliseconds: 1),
      style: textStyle,
      textAlign: textAlign,
      selectable: true,
    ),
  );
}

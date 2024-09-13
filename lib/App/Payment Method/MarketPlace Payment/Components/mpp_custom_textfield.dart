import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import '../../../../Utils/textStyle.dart';

Widget mPPCustomTextfield({
  required TextEditingController textEditingController,
  String? labelText,
  String? validatorString,
  String? Function(String?)? validator,
  required BuildContext context,
}) {
  return TextFormField(
    decoration: InputDecoration(
        labelText: labelText,
        labelStyle: textStyle(context: context, fontSize: 18)),
    controller: textEditingController,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [
      // FilteringTextInputFormatter.digitsOnly
      DecimalTextInputFormatter(decimalRange: 3)
    ],
    validator: validator ??
        (value) {
          if (value == null || value.isEmpty) {
            return validatorString;
          }
          return null;
        },
  );
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    String value = newValue.text;
    if (value.contains(".") &&
        value.substring(value.indexOf(".") + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == ".") {
      truncated = "0.";
    }

    newSelection = newValue.selection.copyWith(
      baseOffset: math.min(truncated.length, truncated.length + 1),
      extentOffset: math.min(truncated.length, truncated.length + 1),
    );

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}

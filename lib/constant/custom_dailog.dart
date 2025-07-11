import 'package:flutter/material.dart';
import 'package:propertier/constant/colors.dart';

import 'AppButton/text_button.dart';

class CustomAlertDialog {
  static Future<void> show({
    required BuildContext context,
    String? title,
    String? message,
    String confirmText = "OK",
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool barrierDismissible = true,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlertDialog(
              title: title != null ? Text(title) : null,
              content: message != null ? Text(message) : null,
              actions: [
                Row(
                  children: [
                    if (cancelText != null)
                      Expanded(
                        child: customTextButton(
                          textColor: AppColor.blackColor,
                          height: 40,
                          buttonColor: AppColor.white,
                          onTap: () {
                            Navigator.of(context).pop();
                            if (onCancel != null) onCancel();
                          },
                          title: cancelText,
                        ),
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: customTextButton(
                        height: 40,
                        textColor: AppColor.white,
                        buttonColor: AppColor.buttonColor,
                        onTap: () {
                          Navigator.of(context).pop();
                          if (onConfirm != null) onConfirm();
                        },
                        title: confirmText,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

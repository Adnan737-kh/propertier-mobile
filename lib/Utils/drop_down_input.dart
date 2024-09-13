import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final List<T> options;
  final T value;
  final double width;
  final void Function(T) onChanged;
  const AppDropdownInput({
    super.key,
    required this.width,
    this.options = const [],
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [boxShadow()],
        color: AppColor.white,
      ),
      height: 30,
      width: width,
      child: FormField<T>(
        builder: (FormFieldState<T> state) {
          return InputDecorator(
            decoration: InputDecoration(
              hintStyle: textStyle(
                  context: context, fontSize: 8, fontWeight: FontWeight.w400),
              contentPadding:
                  const EdgeInsets.only(left: 12, top: 0, bottom: 0, right: 6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            isEmpty: value == null || value == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.blackColor,
                  size: 12,
                ),
                value: value,
                isDense: true,
                onChanged: (value) {
                  onChanged(value as T);
                },
                items: options.map((T value) {
                  return DropdownMenuItem<T>(
                      value: value,
                      child: value == ''
                          ? const SizedBox.shrink()
                          : appText(
                              title: value.toString(),
                              context: context,
                              fontSize: 8,
                              fontWeight: FontWeight.w400));
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

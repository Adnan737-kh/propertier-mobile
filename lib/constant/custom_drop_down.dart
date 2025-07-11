import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropDown<T> extends StatelessWidget {
  final List<T> items;
  final Rx<T?> observableSelectedValue;
  final TextEditingController? otherFieldController;
  final String Function(T item) itemToString;
  final String? hintText;
  final String? labelText;
  final String? otherValue;
  final String? otherHintText;
  final double heightFactor;
  final bool showOtherTextField;

  const CustomDropDown({
    super.key,
    required this.items,
    required this.observableSelectedValue,
    required this.itemToString,
    this.otherFieldController,
    this.hintText,
    this.labelText,
    this.otherValue,
    this.otherHintText,
    this.heightFactor = 0.06,
    this.showOtherTextField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = observableSelectedValue.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null) ...[
            Text(
              labelText!,
              style: const TextStyle(
                color: Color(0xFF131A22),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
          ],
          SizedBox(
            height: Get.height * heightFactor,
            child: DropdownButtonFormField<T>(
              value: items.contains(selected) ? selected : null,

              hint: hintText != null ? Text(hintText!) : null,
              isExpanded: true,
              decoration: InputDecoration(
                fillColor: const Color(0x05131A22),
                filled: true,
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0x05131A22)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0x05131A22)),
                ),
              ),
              style: const TextStyle(
                color: Color(0x66131A22),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              items: items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(itemToString(item)),
                );
              }).toList(),
              onChanged: (value) {
                observableSelectedValue.value = value;
                if (showOtherTextField &&
                    value != null &&
                    itemToString(value) != otherValue) {
                  otherFieldController?.text = itemToString(value);
                } else {
                  otherFieldController?.clear();
                }
              },
            ),
          ),
          if (showOtherTextField &&
              selected != null &&
              itemToString(selected) == otherValue) ...[
            const SizedBox(height: 18),
            TextFormField(
              controller: otherFieldController,
              cursorColor: Colors.amber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: const Color(0x05131A22),
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.020,
                  horizontal: 8,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0x05131A22)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0x05131A22)),
                ),
                hintText: otherHintText ?? 'Enter value',
                hintStyle: const TextStyle(
                  color: Color(0x66131A22),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                isDense: true,
              ),
            ),
          ],
        ],
      );
    });
  }
}

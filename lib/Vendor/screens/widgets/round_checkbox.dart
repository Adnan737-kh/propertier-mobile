import 'package:flutter/material.dart';

class RoundCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color checkColor;
  final Color inactiveColor;

  const RoundCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.blue,
    this.checkColor = Colors.white,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: value ? activeColor : inactiveColor,
          shape: BoxShape.circle,
          border: Border.all(
              color: value ? activeColor : Colors.black45, width: 1.0),
        ),
        child: Center(
          child:
              value ? Icon(Icons.check, size: 18.0, color: checkColor) : null,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TabBarItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Color selectedColor;

  const TabBarItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 2.0, bottom: 0.09, left: 3.0, right: 3.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDCD54) : selectedColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1F0101),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

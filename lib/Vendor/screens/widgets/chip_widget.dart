import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onPressed;

  const ChipWidget({
    super.key,
    required this.text,
    this.isSelected = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
             decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.05000000074505806),
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
        margin: EdgeInsets.only(right: 8, bottom: 8),
        child: Text(
          text,
           style: TextStyle(
    color: Color(0xFF131A22),
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
        ),
      ),
    );
  }
}
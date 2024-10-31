import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String text;
  final TextInputType? keyboardType;
  final String headertext;
   final ValueChanged<String>? onChanged;
  final bool obsecure;
    final bool obscureText;
  final TextEditingController controller;

  const PrimaryTextField(
      {super.key,
       this.prefixIcon,
      required this.controller,
      required this.headertext,
      required this.text,
       this.obscureText = false,
      this.suffixIcon,
      this.obsecure = false, this.keyboardType, this.onChanged, });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
           headertext,
            style: const TextStyle(
              color: Color(0xFF131A22),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
        TextFormField(
          
          obscureText: obsecure,
          controller: controller,
          keyboardType:keyboardType ,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.030,
            ),
            hintText: text,
            hintStyle: const TextStyle(
              color: Color(0xB2131A22),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),

          onChanged: onChanged,
        ),
      ],
    );
  }
}

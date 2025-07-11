import 'package:flutter/material.dart';

import 'package:flutter/services.dart';


// class OTPField extends StatelessWidget {
//   final int numberOfFields;
//   final Function(String)? onChanged;
//   final Function(String)? onSubmit;
//
//   const OTPField({
//     super.key,
//     this.numberOfFields = 6,
//     this.onChanged,
//     this.onSubmit,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: OtpTextField(
//         enabledBorderColor: AppColor.blackColor,
//         numberOfFields: numberOfFields,
//         showFieldAsBox: true,
//         borderRadius: BorderRadius.circular(13),
//         borderWidth: 1,
//         borderColor: AppColor.blackColor.withOpacity(0.4),
//         focusedBorderColor: AppColor.blackColor,
//         keyboardType: TextInputType.number,
//         textStyle: textStyle(
//           context: context,
//           fontWeight: FontWeight.w600,
//           fontSize: 14,
//         ),
//         filled: true,
//         fillColor: AppColor.white,
//         onCodeChanged: onChanged,
//         onSubmit: onSubmit,
//       ),
//     );
//   }
// }





class OTPField extends StatefulWidget {
  final TextEditingController controller;
  final int numberOfFields;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;

  const OTPField({
    super.key,
    this.numberOfFields = 6,
    this.onChanged,
    this.onSubmit,
    required this.controller,
  });

  @override
  State<OTPField> createState() => _OTPFieldState();
}

class _OTPFieldState extends State<OTPField> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.numberOfFields, (_) => TextEditingController());
    _focusNodes = List.generate(widget.numberOfFields, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged() {
    final code = _controllers.map((e) => e.text).join();
    widget.onChanged?.call(code);
    if (!_controllers.any((c) => c.text.isEmpty)) {
      widget.onSubmit?.call(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.numberOfFields, (index) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.12,
          height: MediaQuery.of(context).size.height * 0.06,
          child: TextFormField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              filled: true,
              fillColor: Colors.white,
              hintText: "_",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              if (value.isEmpty && index > 0) {
                _focusNodes[index - 1].requestFocus();
              } else if (value.isNotEmpty && index < widget.numberOfFields - 1) {
                _focusNodes[index + 1].requestFocus();
              }
              _onCodeChanged();
            },
          ),
        );
      }),
    );
  }
}



// class OTPField extends StatelessWidget {
//   final TextEditingController controller;
//   final bool isDone;
//
//   const OTPField({Key? key, required this.controller, this.isDone = false}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: context.getSize.width * 0.12,
//       height: context.getSize.height * 0.06,
//       child: TextFormField(
//         controller: controller,
//         textInputAction:
//         isDone == true ? TextInputAction.done : TextInputAction.next,
//         style: textStyle(
//             context: context, fontWeight: FontWeight.w600, fontSize: 14),
//         onChanged: (value) {
//           if (isDone == true) {
//             FocusScope.of(context).unfocus();
//           }
//           if (isDone == false) {
//             value.length == 1
//                 ? FocusScope.of(context).nextFocus()
//                 : FocusScope.of(context).unfocus();
//           }
//         },
//         decoration: InputDecoration(
//             fillColor: AppColor.white,
//             filled: true,
//             hintText: '_',
//             hintStyle: textStyle(context: context),
//             contentPadding: const EdgeInsets.all(0),
//             enabledBorder: OutlineInputBorder(
//                 borderSide:
//                 BorderSide(color: AppColor.blackColor.withOpacity(0.4)),
//                 borderRadius: BorderRadius.circular(13)),
//             focusedBorder: OutlineInputBorder(
//               // borderSide: const BorderSide(color: AppColor.blackColor),
//                 borderRadius: BorderRadius.circular(13))),
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         inputFormatters: [
//           LengthLimitingTextInputFormatter(1),
//           FilteringTextInputFormatter.digitsOnly,
//         ],
//       ),
//     );
//   }
// }
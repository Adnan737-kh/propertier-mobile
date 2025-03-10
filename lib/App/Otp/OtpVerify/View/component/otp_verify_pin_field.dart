import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';

import 'package:propertier/extensions/size_extension.dart';

// ignore: must_be_immutable
// class OTPVerifyPinField extends StatelessWidget {
//   final int pinLength;
//   final Function(String) onComplete;
//   OTPVerifyViewModel viewModel;

//   OTPVerifyPinField(
//       {super.key,
//       required this.viewModel,
//       required this.pinLength,
//       required this.onComplete});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: List.generate(pinLength, (index) {
//             return SizedBox(
//               width: context.getSize.width * 0.12,
//               height: context.getSize.height * 0.06,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColor.backgroundColor,
//                     side: BorderSide(
//                         width: 3,
//                         color: AppColor.primaryColor.withOpacity(0.5)),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     )),
//                 onPressed: () {
//                   viewModel.getSelectedFieldIndex(index);
//                 },
//                 // _onDigitPressed(index),
//                 child: Obx(
//                   () => appText(
//                     context: context,
//                     fontSize: 20,
//                     title: viewModel.pin[index].isNotEmpty
//                         ? '${viewModel.pin[index]}'
//                         : '-',
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }

class OTPField extends StatelessWidget {
  final TextEditingController controller;
  final bool isDone;

  const OTPField({Key? key, required this.controller, this.isDone = false}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getSize.width * 0.12,
      height: context.getSize.height * 0.06,
      child: TextFormField(
        controller: controller,
        textInputAction:
            isDone == true ? TextInputAction.done : TextInputAction.next,
        style: textStyle(
            context: context, fontWeight: FontWeight.w600, fontSize: 14),
        onChanged: (value) {
          if (isDone == true) {
            FocusScope.of(context).unfocus();
          }
          if (isDone == false) {
            value.length == 1
                ? FocusScope.of(context).nextFocus()
                : FocusScope.of(context).unfocus();
          }
        },
        decoration: InputDecoration(
            fillColor: AppColor.white,
            filled: true,
            hintText: '_',
            hintStyle: textStyle(context: context),
            contentPadding: const EdgeInsets.all(0),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColor.blackColor.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(13)),
            focusedBorder: OutlineInputBorder(
                // borderSide: const BorderSide(color: AppColor.blackColor),
                borderRadius: BorderRadius.circular(13))),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}

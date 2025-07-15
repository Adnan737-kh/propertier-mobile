import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/extensions/localization_extension.dart';
import '../../../../constant/AppTextField/app_textfield.dart';
import '../../../../constant/colors.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/text_botton.dart';
import '../ViewModel/number_verification_view_model.dart';

class NumberConfirmView extends StatelessWidget {
  NumberConfirmView({super.key});
  final numberVerificationVM = Get.find<NumberVerificationViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: AppColor.blackColor,
        ),
        title: const Text(
          "Confirm Verification",
          style: TextStyle(
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: numberVerificationVM.emailFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        title:context.local.please_enter_your_number_to_receive_a_verification_code,
                        fontSize: 16,
                        color: const Color(0xFF6D6E6F),
                        fontWeight: FontWeight.bold),
                    const SizedBox(
                      height: 30,
                    ),
                    customPhoneNumberTextField(
                      label: "Enter your email",
                      hintText: 'Enter your email',
                      controller: numberVerificationVM.numberController,
                      textInputType: TextInputType.emailAddress,
                      suffix: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.record_voice_over),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid  phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Obx(() {
                      return Row(
                        children: [
                          Expanded(
                            child: numberVerificationVM.isLoading.value
                                ? const Center(child: CircularProgressIndicator())
                                : textButton(
                              onClick: () async {
                                if (numberVerificationVM.emailFormKey.currentState!.validate()) {
                                  numberVerificationVM.emailFormKey.currentState?.save();
                                  numberVerificationVM.phoneNumberVerification(
                                    context,
                                    numberVerificationVM.accessToken!,
                                  );
                                }
                              },
                              context: context,
                              title: 'Send',
                            ),
                          ),
                        ],
                      );
                    }),

                    const SizedBox(
                      height: 45,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

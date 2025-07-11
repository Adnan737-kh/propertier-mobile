import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constant/AppTextField/app_textfield.dart';
import '../../../../constant/colors.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/text_botton.dart';
import '../ViewModel/email_verification_view_model.dart';

class EmailConfirmView extends StatelessWidget {
  EmailConfirmView({super.key});
  final confirmEmailVM = Get.find<EmailVerficationViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // 👈 add local key here

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
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        title:
                            "Please enter your Email to receive a verification code.",
                        fontSize: 16,
                        color: const Color(0xFF6D6E6F),
                        fontWeight: FontWeight.bold),
                    const SizedBox(
                      height: 30,
                    ),
                    customTextField(
                      label: "Enter your email",
                      hintText: 'Enter your email',
                      controller: confirmEmailVM.emailController,
                      textInputType: TextInputType.emailAddress,
                      suffix: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.record_voice_over),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid  Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() {
                            return confirmEmailVM.isLoading.value
                                ? const Center(child: CircularProgressIndicator())
                                : textButton(
                              onClick: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();
                                  confirmEmailVM.emailVerification(
                                    context,
                                    confirmEmailVM.accessToken!,
                                  );
                                }
                              },

                              context: context,
                              title: 'Send',
                            );
                          }),
                        ),
                      ],
                    ),

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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/email/view/otp_screen.dart';
import 'package:propertier/Vendor/screens/widgets/primary_textfield.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
                width: Get.size.width,
                height: Get.height * .1,
                padding: const EdgeInsets.only(top: 36, left: 8),
                decoration: ShapeDecoration(
                  color: const Color(0xFF131A22),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.05000000074505806),
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 10,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    const SizedBox(width: 4),
                    const Text(
                      'Email Verification',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )),
            // const SizedBox(height: 160),

            SizedBox(
              height: Get.height * .178,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Please enter your Email to receive a verification code.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF131A22),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .034,
                    ),
                    PrimaryTextField(
                      controller: emailController,
                      headertext: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      text: 'Enter Your Email',
                      suffixIcon: const Icon(Icons.mic),
                    ),
                    SizedBox(
                      height: Get.height * .178,
                    ),
                    InkWell(
                      onTap: () {
                        validateAndCreate();
                      },
                      child: Container(
                        width: Get.size.width,
                        height: Get.height * .071,
                        // height: 58,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFDCD54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Send',
                            style: TextStyle(
                              color: Color(0xFF131A22),
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> validateAndCreate() async {
    if (emailController.text.isEmpty) {
      Get.snackbar('Validation error', 'Please enter a valid Email',
          colorText: Colors.red.shade700);
      return;
    } else {
      Get.to(() => const OtpScreen(
          email: 'farazj105@gmail.com', verificationID: 'verificationID'));
      // authController.resetmypassword(emailController.text, context);
    }
  }
}

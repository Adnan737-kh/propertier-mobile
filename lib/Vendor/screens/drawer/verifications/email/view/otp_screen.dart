// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/email/view/verify_email_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final String verificationID;
  const OtpScreen(
      {super.key, required this.email, required this.verificationID});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TimerManager timerManager = TimerManager();
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  bool loading = false;
  bool isVerifying = false;
  int _timerValue = 60;

  late String verificationId;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _startResendTimer();

    verificationId = widget.verificationID;
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          const SizedBox(height: 140),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      'Waiting to automatically detect an\nmessage sent to ',
                  style: TextStyle(
                    color: Color(0xFF131A22),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: 'Email',
                  style: TextStyle(
                    color: Color(0xFF131A22),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          InkWell(
            onTap: () {
              Get.to(() => const VerifyEmailScreen());
            },
            child: const Text(
              'Wrong Email?',
              style: TextStyle(
                color: Color(0xFF4286F5),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              6,
              (index) => SizedBox(
                width: 50,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: TextField(
                    obscureText: true,
                    controller: _otpControllers[index],
                    cursorColor: Colors.black,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: "-",
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 8),
                      focusColor: Colors.grey,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height * .21),
          GestureDetector(
            onTap: () {
              if (_timerValue == 0) {
                timerManager.startTimer(() {});
                setState(() {
                  _timerValue = 60;
                });
              }
            },
            child: _timerValue == 0
                ? const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Don’t receive Code?',
                        style: TextStyle(
                          color: Color(0xFF131A22),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 2),
                      Text(
                        'Resend  Code',
                        style: TextStyle(
                          color: Color(0xFF109B0E),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                : Text(
                    'Resend OTP in $_timerValue seconds',
                    style: const TextStyle(
                      color: Color(0xFF4286F5),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () async {
              // if (isVerifying) {
              //   return; // Do nothing if already verifying
              // }
            
              // setState(() {
              //   loading = true;
              //   isVerifying = true;
              // });
            
              // // Check if any OTP field is empty
              // if (_otpControllers
              //         .any((controller) => controller.text.isEmpty) ||
              //     _otpControllers
              //         .any((controller) => controller.text.length > 6)) {
              //   // Show snackbar if any OTP field is empty
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //       backgroundColor: Colors.red,
              //       behavior: SnackBarBehavior.floating,
              //       content: Text(
              //         'Please fill all fields',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontFamily: 'Poppins',
              //           fontSize: 15,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //     ),
              //   );
            
              //   setState(() {
              //     loading = false;
              //     isVerifying = false;
              //   });
              //   return;
              // }
            
              // try {
              //   String otpCode = _otpControllers
              //       .map((controller) => controller.text)
              //       .join('');
              //   PhoneAuthCredential credential =
              //       PhoneAuthProvider.credential(
              //     verificationId: verificationId,
              //     smsCode: otpCode,
              //   );
            
              //   // Sign in with the OTP credential
              //   await auth.signInWithCredential(credential);
              //   setState(() {
              //     loading = false;
              //   });
            
              //   // Check if user data exists in Firestore
              //   User? user = auth.currentUser;
              //   DocumentSnapshot userSnapshot = await FirebaseFirestore
              //       .instance
              //       .collection('users')
              //       .doc(user?.uid)
              //       .get();
            
              //   if (userSnapshot.exists) {
              //     // User data exists, navigate to the home screen
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => const Dashboard(),
              //       ),
              //     );
              //     setState(() {
              //       loading = false;
              //     });
              //   } else {
              //     // User data does not exist, navigate to data entry screen
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => const MainInformation(),
              //       ),
              //     );
              //     setState(() {
              //       loading = false;
              //     });
              //   }
              // } catch (e) {
              //   print(e.toString());
            
              //   if (e is FirebaseAuthException) {
              //     if (e.code == 'invalid-verification-code') {
              //       // Show a dialog for wrong OTP
              //       showDialog(
              //         context: context,
              //         builder: (context) {
              //           return AlertDialog(
              //             title: const Text('Wrong OTP'),
              //             content: const Text(
              //               'The OTP you entered is incorrect. Please try again.',
              //             ),
              //             actions: [
              //               TextButton(
              //                 onPressed: () {
              //                   Navigator.pop(context);
              //                   setState(() {
              //                     loading = false;
              //                     isVerifying = false;
              //                   });
              //                 },
              //                 child: const Text('OK'),
              //               ),
              //             ],
              //           );
              //         },
              //       );
              //     }
              //   } else {
              //     // Handle other non-authentication exceptions if needed
              //   }
              // }
            },
            child: Stack(
              children: [
                Container(
                  height: Get.height * .07,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFDCD54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Visibility(
                      visible: !loading,
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          color: Color(0xFF131A22),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                if (loading)
                  const Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _startResendTimer() {
    timerManager.startTimer(() {
      if (_timerValue == 0) {
        timerManager.cancelTimer();
        setState(() {
          _timerValue = 60;
        });
      } else {
        setState(() {
          _timerValue--;
        });
      }
    });
  }
}

class TimerManager {
  late Timer _resendTimer;
  bool _timerActive = false;
  int _timerDuration = 60;

  bool get isTimerActive => _timerActive;
  int get timerDuration => _timerDuration;

  void startTimer(Function() callback) {
    _timerActive = true;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerDuration == 0) {
        _timerActive = false;
        _timerDuration = 60;
        _resendTimer.cancel();
      } else {
        _timerDuration--;
        callback();
      }
    });
  }

  void cancelTimer() {
    _timerActive = false;
    _timerDuration = 60;
    _resendTimer.cancel();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/logo_tile.dart';
import 'package:propertier/Utils/search_location_bottom_sheet.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/Vendor/screens/Auth/Sign%20Up/ViewModel/signup_view_model.dart';
import 'package:propertier/constant/AppButton/text_button.dart';
import 'package:propertier/constant/AppTextField/app_textfield.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/constant/toast.dart';
import 'package:propertier/extensions/size_extension.dart';

// import '../../../../Utils/appbar.dart';
// import '../../../../Utils/logo_tile.dart';
// import '../../../../constant/AppButton/text_button.dart';
// import '../../../../constant/AppTextField/app_textfield.dart';
// import '../../../../constant/colors.dart';
// import '../../../../constant/constant.dart';
// import '../../../../Utils/height_width_box.dart';
import '../../Components/social_links.dart';


class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final signupVM = Get.find<SignUpViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => Form(
          key: signupVM.formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  getHeight(context, 0.065),
                  customAppBar(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      context: context,
                      title: 'Sign Up vendor',
                      onTap: () {
                        Get.back();
                        
                   
                      }),
                  getHeight(context, 0.069),
                  Align(alignment: Alignment.center, child: logoTile(context)),
                  getHeight(context, 0.090),
                  customTextField(
                    labal: "Full Name",
                    controller: signupVM.usernameController,
                    hintText: 'Full Name',
                    textInputType: TextInputType.name,
                    suffix: GestureDetector(
                      onTap: () {
                        print("Start Listing");
                        signupVM.startListening(textFieldNo: 0);
                      },
                      child: Image.asset(
                        Constant.mic,
                        height: context.getSize.height * 0.022,
                        width: context.getSize.width * 0.038,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Full Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  customTextField(
                    labal: "Email",
                    controller: signupVM.userEmailController,
                    hintText: 'Enter Your Email',
                    textInputType: TextInputType.emailAddress,
                    suffix: GestureDetector(
                      onTap: () {
                        signupVM.startListening(textFieldNo: 1);
                      },
                      child: Image.asset(
                        Constant.mic,
                        height: context.getSize.height * 0.022,
                        width: context.getSize.width * 0.038,
                      ),
                    ),
                    validator: (value) {
                      if (value == '' || value!.isEmpty) {
                        return "Please Enter Your Email";
                      } else if (!value.isEmail) {
                        return "Please Enter valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  customTextField(
                    onTap: () {
                      searchLoactionBottomSheet(
                          placesList: signupVM.places,
                          onSelect: (val) {
                            signupVM.locationController.text = val;
                            signupVM.getGeoCode(val);
                            signupVM.searchAddressController.clear();
                            signupVM.places.clear();
                            Get.back();
                          },
                          onChange: (val) {
                            signupVM.searchPlaces(val);
                          },
                          context: context,
                          searchController: signupVM.searchAddressController);
                    },
                    readOnly: true,
                    labal: "Address",
                    controller: signupVM.locationController,
                    hintText: 'Address',
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == '' || value!.isEmpty) {
                        return "Please Enter Your Address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  customPhoneNumberTextField(
                    labal: "Phone Number",
                    controller: signupVM.userNumberController,
                    hintText: 'Enter Your Phone Number',
                    textInputType: TextInputType.phone,
                    suffix: const Icon(Icons.record_voice_over),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: customTextField(
                          labal: "Password",
                          obsecureText: !signupVM.isShowPassword.value,
                          controller: signupVM.passwordController,
                          suffix: GestureDetector(
                              onTap: () {
                                signupVM.isShowPassword.value =
                                    !signupVM.isShowPassword.value;
                              },
                              child: Icon(
                                signupVM.isShowPassword.value
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                                size: context.getSize.width * 0.050,
                                color: !signupVM.isShowPassword.value
                                    ? null
                                    : AppColor.secondaryColor,
                              )),
                          hintText: 'Enter your password',
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Oops! we could not find matching credentials.';
                            }
                            return null;
                          },
                        ),
                      ),
                      getWidth(context, 0.010),
                      Expanded(
                        child: customTextField(
                          labal: "Confirm Password",
                          obsecureText: !signupVM.isShowConfirmPassword.value,
                          controller: signupVM.confirmPasswordController,
                          suffix: GestureDetector(
                              onTap: () {
                                signupVM.isShowConfirmPassword.value =
                                    !signupVM.isShowConfirmPassword.value;
                              },
                              child: Icon(
                                signupVM.isShowConfirmPassword.value
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                                color: !signupVM.isShowConfirmPassword.value
                                    ? null
                                    : AppColor.secondaryColor,
                              )),
                          hintText: 'Enter Confirm password',
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Oops! we could not find matching credentials.';
                            } else if (signupVM.passwordController.text !=
                                signupVM.confirmPasswordController.text) {
                              return 'Password Mismatch';
                            } else
                              return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Expanded(
                          child: signupVM.isSuccess == false
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.buttonColor,
                                  ),
                                )
                              : textButton(
                                  textFontSize: 14,
                                  textFontWeight: FontWeight.bold,
                                  context: context,
                                  onClick: () async {
                                    if (signupVM.formKey.currentState!
                                            .validate() &&
                                        signupVM.userNumberController.text !=
                                            "") {
                                      signupVM.formKey.currentState?.save();
                                      print(signupVM.userNumberController.text);
                                      // signupVM
                                      //     .phoneAuthentication(
                                      //         phone:
                                      //             "+92${signupVM.userNumberController.text}")

                                      signupVM
                                          .sendOTPtoEmail(
                                              email: signupVM
                                                  .userEmailController.text)
                                          .whenComplete(() async {
                                        // final result =
                                        //     await signupVM.signupUser(
                                        //         context: context,
                                        //         name: signupVM
                                        //             .usernameController.text,
                                        //         email: signupVM
                                        //             .userEmailController.text,
                                        //         phoneNumber: signupVM
                                        //             .userNumberController.text,
                                        //         password: signupVM
                                        //             .passwordController.text,
                                        //         confirmPassword: signupVM
                                        //             .confirmPasswordController
                                        //             .text);
                                        // if (result == true) {
                                        //   signupVM.changeLoading(true);

                                        //   Get.toNamed(
                                        //     AppRoutes.verifySigninView,
                                        //   );
                                        // } else if (result == false) {
                                        //   signupVM.changeLoading(true);
                                        // }
                                      });
                                    } else if (signupVM
                                        .userNumberController.text.isEmpty) {
                                      toast(
                                          title: "Please Provide number",
                                          context: context);
                                    }
                                  },
                                  buttonColor: AppColor.buttonColor,
                                  title: 'Sign Up',
                                  textColor: AppColor.blackColor,
                                ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => signupVM.isGoogleSigninLoading.value == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.googleColor,
                                ),
                              )
                            : Expanded(
                                child: customTextButton(
                                    height: 48,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    onTap: () async {
                                      signupVM.sigupWithGoogle(
                                          context: context);
                                    },
                                    icondata: Bootstrap.google,
                                    title: 'Sign Up with Google',
                                    buttonColor: AppColor.googleColor
                                    // textColor: AppColor.,
                                    ),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: customTextButton(
                            height: 48,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            onTap: () async {},
                            icondata: Bootstrap.facebook,
                            // iconColor: AppColor.googleColor,
                            title: 'Sign Up with FaceBook',
                            buttonColor: AppColor.facebookColor
                            // textColor: AppColor.,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SocialLinks(),
                  const SizedBox(
                    height: 12,
                  ),
                  getHeight(context, 0.012),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }
}

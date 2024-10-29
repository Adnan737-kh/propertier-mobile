import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import '../../../../../App/Auth/Service/auth_service.dart';
import '../../../../../App/Auth/Service/google_sigin_services.dart';
import '../../../../../RoutesAndBindings/app_routes.dart';
import '../../../../../Utils/app_text.dart';
import '../../Components/social_links.dart';

class SignUpViewVendor extends StatelessWidget {
  SignUpViewVendor({super.key});
  final signupVM = Get.find<SignUpViewModelVendor>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
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
                      title: 'Vendor Form',
                      onTap: () {
                        Get.back();
                      }),
                  getHeight(context, 0.069),
                  Align(alignment: Alignment.center, child: logoTile(context)),
                  getHeight(context, 0.010),
                  Align(alignment: Alignment.center, child: Text("Vendor Application Form")),
                  getHeight(context, 0.080),
                  customTextField(
                    labal: "Full Name",
                    controller: signupVM.usernameController,
                    hintText: 'Full Name',
                    textInputType: TextInputType.name,
                    suffix: GestureDetector(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: appText(
                        title: "ID Card Front Image",
                        context: context,
                        fontSize: 14,
                        color: const Color.fromARGB(196, 141, 142, 143),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(()=> InkWell(
                    onTap: ()async{
                      File? file = await signupVM.pickImage(context);
                      if(file != null){
                        signupVM.cnicFrontPath.value = file.path;
                      }
                    },
                    child: signupVM.cnicFrontPath.value == "" ?
                    Container(
                      width: Get.width,
                      height: 150,
                      decoration: BoxDecoration(
                          color: AppColor.textColorGrey,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      alignment: Alignment.center,
                      child: appText(
                          title: "Tap to pick Image",
                          context: context,
                          fontSize: 14,
                          color: AppColor.primaryColor,
                          ),
                    ): ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(File(signupVM.cnicFrontPath.value), height: 150,width: Get.width, fit: BoxFit.cover,)),
                  )
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: appText(
                        title: "ID Card Back Image",
                        context: context,
                        fontSize: 14,
                        color: const Color.fromARGB(196, 141, 142, 143),
                      fontWeight: FontWeight.bold
                        ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(()=> InkWell(
                    onTap: ()async{
                      File? file = await signupVM.pickImage(context);
                      if(file != null){
                        signupVM.cnicBackPath.value = file.path;
                      }
                    },
                    child: signupVM.cnicBackPath.value == "" ?
                    Container(
                      width: Get.width,
                      height: 150,
                      decoration: BoxDecoration(
                          color: AppColor.textColorGrey,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      alignment: Alignment.center,
                      child: appText(
                          title: "Tap to pick Image",
                          context: context,
                          fontSize: 14,
                          color: AppColor.primaryColor,
                      ),
                    ): ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(File(signupVM.cnicBackPath.value), height: 150,width: Get.width, fit: BoxFit.cover,)),
                  )
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  customTextField(
                    labal: "Other Detail",
                    controller: signupVM.noteC,
                    hintText: 'Other Detail',
                    textInputType: TextInputType.text,
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


                                      if(signupVM.cnicFrontPath.value == "" || signupVM.cnicBackPath.value == ""){
                                        Fluttertoast.showToast(msg: "Please Add ID Card Images");
                                        return;
                                      }




                                      final result =
                                      await signupVM.signupUser(
                                          context: context,
                                          name: signupVM
                                              .usernameController.text,
                                          email: signupVM
                                              .userEmailController.text,
                                          pinCode: "+92",
                                          address: signupVM.locationController.text,
                                          phoneNumber: signupVM
                                              .userNumberController.text,
                                        cnicFront: signupVM.cnicFrontPath.value,
                                        cnicBack: signupVM.cnicBackPath.value,
                                          );
                                      if (result == true) {
                                        signupVM.changeLoading(true);
                                        Fluttertoast.showToast(msg: "Congrats, You are now vendor");
                                        AuthService().logout();
                                        GoogleSiginServices().logout();
                                        Get.offAllNamed(AppRoutes.loginView);
                                      } else if (result == false) {
                                        signupVM.changeLoading(true);
                                      }

                                    } else if (signupVM
                                        .userNumberController.text.isEmpty) {
                                      toast(
                                          title: "Please Provide number",
                                          context: context);
                                    }
                                  },
                                  buttonColor: AppColor.buttonColor,
                                  title: 'Submit',
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
                    height: 15,
                  ),
                  const SocialLinks(),
                  const SizedBox(
                    height: 12,
                  ),
                ],
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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
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
import '../../../../../App/Auth/Service/auth_service.dart';
import '../../../../../App/Auth/Service/google_sigin_services.dart';
import '../../../../../RoutesAndBindings/app_routes.dart';
import '../../../../../Utils/app_text.dart';
import '../../../../../Utils/border.dart';
import '../../Components/social_links.dart';
import '../ViewModel/EditVendorProfileController.dart';

class Editvendorprofile extends StatelessWidget {
  const Editvendorprofile({super.key});

  @override
  Widget build(BuildContext context) {
    EditVendorProfileController controller = Get.put(EditVendorProfileController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: controller.formKey,
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
                    title: 'Edit Form',
                    onTap: () {
                      Get.back();
                    }),
                getHeight(context, 0.069),
                Align(alignment: Alignment.center, child: logoTile(context)),
                getHeight(context, 0.010),
                Align(alignment: Alignment.center, child: Text("Vendor Profile Form")),
                getHeight(context, 0.080),
                SizedBox(
                  height: context.getSize.height * 0.090,
                  width: context.getSize.width * 0.180,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Obx(()=> ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: controller.profileImagePath.value != ""? Image.file(File(controller.profileImagePath.value),fit: BoxFit.cover,height: 100, width: 100,):
                        Image.network(controller.user.profilePictureUrl == null || controller.user.profilePictureUrl == "" ? Constant.dummayImage:controller.user.profilePictureUrl!, fit: BoxFit.cover, height: 100, width: 100,),
                      )),
                      InkWell(
                        onTap: ()async{
                          File? file = await controller.pickImage(context);
                          if(file != null){
                            controller.profileImagePath.value = file.path;
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: border(color: AppColor.white),
                              shape: BoxShape.circle,
                              color: Colors.blue),
                          child: Icon(
                            Icons.edit,
                            size: context.getSize.width * 0.020,
                            color: AppColor.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                getHeight(context, 0.080),
                customTextField(
                  labal: "Full Name",
                  controller: controller.usernameController,
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
                  controller: controller.userEmailController,
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
                        placesList: controller.places,
                        onSelect: (val) {
                          controller.locationController.text = val;
                          controller.getGeoCode(val);
                          controller.searchAddressController.clear();
                          controller.places.clear();
                          Get.back();
                        },
                        onChange: (val) {
                          controller.searchPlaces(val);
                        },
                        context: context,
                        searchController: controller.searchAddressController);
                  },
                  readOnly: true,
                  labal: "Address",
                  controller: controller.locationController,
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
                  controller: controller.userNumberController,
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
                    File? file = await controller.pickImage(context);
                    if(file != null){
                      controller.cnicFrontPath.value = file.path;
                    }
                  },

                    child:  controller.cnicFrontPath.value != ""?
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(File(controller.cnicFrontPath.value), height: 150,width: Get.width, fit: BoxFit.cover,)):
                    controller.user.cnicFrontUrl != null && controller.user.cnicFrontUrl != ""?
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(controller.user.cnicFrontUrl??"", height: 150,width: Get.width, fit: BoxFit.cover,)) :
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
                  ),
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
                    File? file = await controller.pickImage(context);
                    if(file != null){
                      controller.cnicBackPath.value = file.path;
                    }
                  },
                  child: controller.cnicBackPath.value != "" ?
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(File(controller.cnicBackPath.value), height: 150,width: Get.width, fit: BoxFit.cover,)):
                  controller.user.cnicBackUrl != null && controller.user.cnicBackUrl != ""?
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(controller.user.cnicBackUrl??"", height: 150,width: Get.width, fit: BoxFit.cover,)):
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
                  ),
                )
                ),
                const SizedBox(
                  height: 12,
                ),
                customTextField(
                  labal: "Other Detail",
                  controller: controller.noteC,
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
                        child: controller.isSuccess == false
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
                            if (controller.formKey.currentState!
                                .validate() &&
                                controller.userNumberController.text !=
                                    "") {
                              controller.formKey.currentState?.save();



                              final result =
                              await controller.updateUser(
                                context: context,
                                name: controller
                                    .usernameController.text,
                                email: controller
                                    .userEmailController.text,
                                pinCode: "+92",
                                address: controller.locationController.text,
                                phoneNumber: controller
                                    .userNumberController.text,
                                cnicFront: controller.cnicFrontPath.value == ""? null: controller.cnicFrontPath.value,
                                cnicBack: controller.cnicBackPath.value == ""? null: controller.cnicBackPath.value,
                                profileImage: controller.profileImagePath.value == ""? null: controller.profileImagePath.value,

                              );
                              controller.changeLoading(true);
                              if (result == true) {
                                controller.changeLoading(true);
                                Fluttertoast.showToast(msg: "Profile updated.");
                                AuthService().logout();
                                GoogleSiginServices().logout();
                                Get.offAllNamed(AppRoutes.loginView);
                                // Get.back();
                              } else if (result == false) {
                                controller.changeLoading(true);
                              }

                            } else if (controller
                                .userNumberController.text.isEmpty) {
                              toast(
                                  title: "Please Provide number",
                                  context: context);
                            }
                          },
                          buttonColor: AppColor.buttonColor,
                          title: 'Update',
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

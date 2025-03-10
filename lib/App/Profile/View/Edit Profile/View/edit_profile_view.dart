import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Profile/View/Verification/View/components/edit_profile_textfield.dart';
import 'package:propertier/Utils/search_location_bottom_sheet.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../../Utils/appbar.dart';
import '../../../../../constant/AppButton/text_button.dart';
import '../../../../../constant/colors.dart';
import '../../../../../constant/constant.dart';
import '../../../../../Utils/height_width_box.dart';
import '../ViewModel/edit_profile_view_model.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});
  final editProfileVM = Get.find<EditProfileViewModel>();
  final myFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => editProfileVM.profileModel.value.userProfile == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColor.buttonColor,
                ),
              )
            : SafeArea(
                child: Form(
                  key: editProfileVM.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: context.getSize.width,
                          height: context.getSize.height * 0.26,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned(
                                top: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: context.getSize.width * 0.040,
                                      vertical: context.getSize.height * 0.01),
                                  height: context.getSize.height * 0.2,
                                  width: context.getSize.width,
                                  decoration: BoxDecoration(
                                      image: editProfileVM.coverImage != '' ||
                                              editProfileVM.profileModel.value.userProfile
                                                      ?.coverPhotoUrl ==
                                                  ''
                                          ? DecorationImage(
                                              image: FileImage(
                                                File(editProfileVM.coverImage),
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : DecorationImage(
                                              image: NetworkImage(
                                                editProfileVM.profileModel.value.userProfile
                                                    ?.coverPhotoUrl ??
                                                    Constant.dummyImage,
                                              ),
                                              fit: BoxFit.cover,
                                            )),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customAppBar(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          context: context,
                                          onTap: () {
                                            Get.back();
                                          },
                                          title: 'Edit Profile'),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            editProfileVM.pickImage(
                                                isProfileImage: false);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 1,
                                                )),
                                            child: const Icon(
                                              Ionicons.camera_outline,
                                              color: AppColor.white,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: context.getSize.height * 0.12,
                                width: context.getSize.width * 0.22,
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Container(
                                      height: context.getSize.height * 0.12,
                                      width: context.getSize.width * 0.22,
                                      decoration: BoxDecoration(
                                          image: editProfileVM.profileImage !=
                                                  ''
                                              ? DecorationImage(
                                                  image: FileImage(File(
                                                      editProfileVM
                                                          .profileImage)),
                                                  fit: BoxFit.cover,
                                                )
                                              : editProfileVM.profileModel.value.userProfile
                                              ?.profilePictureUrl ==
                                                      null
                                                  ? null
                                                  : DecorationImage(
                                                      image: NetworkImage(
                                                          editProfileVM.profileModel.value.userProfile
                                                              ?.profilePictureUrl ??
                                                              Constant
                                                                  .dummyImage),
                                                      fit: BoxFit.cover,
                                                    ),
                                          border: Border.all(
                                              color: AppColor.buttonColor,
                                              width: 3),
                                          shape: BoxShape.circle),
                                    ),
                                    Positioned(
                                      bottom: context.getSize.height * 0.01,
                                      child: GestureDetector(
                                        onTap: () {
                                          editProfileVM.pickImage(
                                              isProfileImage: true);
                                        },
                                        child: Container(
                                          height:
                                              context.getSize.height * 0.030,
                                          width: context.getSize.width * 0.060,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1,
                                              )),
                                          child: const Icon(
                                            Ionicons.camera_outline,
                                            size: 10,
                                            color: AppColor.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              getHeight(context, 0.04),
                              EditProfileTextField(
                                isEditable: false,
                                // isEditableFunction: () {
                                //   editProfileVM.isName.value =
                                //       !editProfileVM.isName.value;
                                //   Future.delayed(
                                //       const Duration(
                                //         milliseconds: 500,
                                //       ), () {
                                //     editProfileVM.focusTextField(
                                //         editProfileVM.nameFocusNode, context);
                                //   });
                                // },
                                label: "Full Name",
                                controller:
                                    editProfileVM.nameController,
                                hintText: 'Full Name',
                                textInputType: TextInputType.name,
                                suffix: GestureDetector(
                                  onTap: () {},
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
                                focusNode: editProfileVM.nameFocusNode,
                              ),
                              getHeight(context, 0.028),
                              EditProfileTextField(
                                isEditable: false,
                                // isEditableFunction: () {
                                //   editProfileVM.isEmail.value =
                                //       !editProfileVM.isEmail.value;
                                //   Future.delayed(
                                //       const Duration(
                                //         milliseconds: 500,
                                //       ), () {
                                //     editProfileVM.focusTextField(
                                //         editProfileVM.emailFocusNode, context);
                                //   });
                                // },
                                label: "Email",
                                textInputType: TextInputType.emailAddress,
                                controller: editProfileVM.emailController,
                                hintText: 'Enter Your Email',
                                suffix: GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    Constant.mic,
                                    height: context.getSize.height * 0.022,
                                    width: context.getSize.width * 0.038,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Your Email';
                                  }
                                  return null;
                                },
                                focusNode: editProfileVM.emailFocusNode,
                              ),
                              getHeight(context, 0.028),
                              EditProfileTextField(
                                isEditable: editProfileVM.isPassword.value,
                                isEditableFunction: () {
                                  editProfileVM.isPassword.value =
                                      !editProfileVM.isPassword.value;
                                  Future.delayed(
                                      const Duration(
                                        milliseconds: 500,
                                      ), () {
                                    editProfileVM.focusTextField(
                                        editProfileVM.passwordFocusNode,
                                        context);
                                  });
                                },
                                label: "Password",
                                textInputType: TextInputType.text,
                                controller: editProfileVM.passwordController,
                                hintText: 'Enter Your Password',
                                suffix: GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    Constant.mic,
                                    height: context.getSize.height * 0.022,
                                    width: context.getSize.width * 0.038,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Your Password';
                                  }
                                  return null;
                                },
                                focusNode: editProfileVM.passwordFocusNode,
                              ),
                              getHeight(context, 0.028),
                              customPhoneNumberTextField(
                                  onChangeCountry: (country) {
                                    editProfileVM.changeInitialCode(
                                        "+${country.dialCode}");
                                    print(country.dialCode);
                                  },
                                  initialCOde: editProfileVM.initialCode,
                                  label: "Phone Number",
                                  isEditable: editProfileVM.isPhone.value,
                                  isEditablefun: () {
                                    editProfileVM.isPhone.value =
                                        !editProfileVM.isPhone.value;
                                    Future.delayed(
                                        const Duration(
                                          milliseconds: 500,
                                        ), () {
                                      editProfileVM.focusTextField(
                                          editProfileVM.focusNode3, context);
                                    });
                                  },
                                  controller:
                                      editProfileVM.numberController,
                                  hintText: 'Enter Your Phone Number',
                                  textInputType: TextInputType.phone,
                                  suffix: const Icon(Icons.record_voice_over),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter valid phone number';
                                    }
                                    return null;
                                  },
                                  focusNode: editProfileVM.focusNode3),
                              getHeight(context, 0.028),
                              EditProfileTextField(
                                isEditable: editProfileVM.isAbout.value,
                                isEditableFunction: () {
                                  editProfileVM.isAbout.value =
                                      !editProfileVM.isAbout.value;
                                  Future.delayed(
                                      const Duration(
                                        milliseconds: 500,
                                      ), () {
                                    editProfileVM.focusTextField(
                                        editProfileVM.focusNode4, context);
                                  });
                                },
                                label: "About",
                                textInputType: TextInputType.text,
                                controller: editProfileVM.aboutController,
                                hintText: '',
                                suffix: GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    Constant.mic,
                                    height: context.getSize.height * 0.022,
                                    width: context.getSize.width * 0.038,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Your Email';
                                  }
                                  return null;
                                },
                                focusNode: editProfileVM.focusNode4,
                              ),
                              getHeight(context, 0.028),
                              EditProfileTextField(
                                isEditable: editProfileVM.isAddress.value,
                                isEditableFunction: () {
                                  editProfileVM.isAddress.value =
                                      !editProfileVM.isAddress.value;
                                  // searchLocationBottomSheet(
                                  //     placesList: editProfileVM.places,
                                  //     onSelect: (val) {
                                  //       editProfileVM.addressController.text =
                                  //           val;
                                  //       editProfileVM.getGeoCode(val);
                                  //       editProfileVM.searchAddressController
                                  //           .clear();
                                  //       editProfileVM.places.clear();
                                  //
                                  //       Get.back();
                                  //     },
                                  //     onChange: (val) {
                                  //       editProfileVM.searchPlaces(val);
                                  //     },
                                  //     context: context,
                                  //     searchController: editProfileVM
                                  //         .searchAddressController);
                                  // });
                                },
                                label: "Address",
                                textInputType: TextInputType.text,
                                controller: editProfileVM.addressController,
                                hintText: 'Address',
                                readOnly: true,
                                suffix: GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(
                                    Constant.mic,
                                    height: context.getSize.height * 0.022,
                                    width: context.getSize.width * 0.038,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Your Address';
                                  }
                                  return null;
                                },
                                focusNode: editProfileVM.focusNode5,
                              ),
                              getHeight(context, 0.06),
                              Obx(
                                () => editProfileVM.isSuccess == false
                                    ? SizedBox(
                                        height: context.getSize.height * 0.048,
                                        child: const CircularProgressIndicator(
                                          color: AppColor.buttonColor,
                                        ),
                                      )
                                    : customTextButton(
                                        onTap: () async {
                                          // await editProfileVM
                                          //     .editProfileData(
                                          //       password: editProfileVM
                                          //           .passwordController.text,
                                          //       context: context,
                                          //       id: editProfileVM.userData.value
                                          //               .users?.first.id
                                          //               .toString() ??
                                          //           '',
                                          //       profileImage:
                                          //           editProfileVM.profileImage,
                                          //       coverImage:
                                          //           editProfileVM.coverImage,
                                          //       name: editProfileVM
                                          //           .userFullNameController
                                          //           .text,
                                          //       email: editProfileVM
                                          //           .usernameController.text,
                                          //       phoneNumber: editProfileVM
                                          //           .userNumberController.text,
                                          //       about: editProfileVM
                                          //           .userAboutController.text,
                                          //       address: editProfileVM
                                          //           .addressController.text,
                                          //     )
                                          //     .whenComplete(() =>
                                          //         editProfileVM.getUserData());
                                          editProfileVM.isLoading.value = true;
                                          editProfileVM.editProfile();
                                        },
                                        fontWeight: FontWeight.bold,
                                        buttonColor: AppColor.buttonColor,
                                        title: 'Save',
                                        textColor: AppColor.blackColor,
                                      ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

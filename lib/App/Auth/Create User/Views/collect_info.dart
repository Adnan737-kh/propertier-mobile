import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/loading_view.dart';
import 'package:propertier/Utils/search_location_bottom_sheet.dart';
import 'package:propertier/constant/toast.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../Utils/appbar.dart';
import '../../../../Utils/logo_tile.dart';
import '../../../../constant/AppButton/text_button.dart';
import '../../../../constant/AppTextField/app_textfield.dart';
import '../../../../constant/colors.dart';
import '../../../../constant/constant.dart';
import '../../../../Utils/height_width_box.dart';
import '../../Components/social_links.dart';
import '../../Sign Up/ViewModel/signup_view_model.dart';

class CollectInfo extends StatelessWidget {
  CollectInfo({super.key});
  final signupVM = Get.find<SignUpViewModel>();

  Future<bool> _showPrivacyPolicyDialog() async {
    bool? accept = await showDialog<bool>(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Privacy Policy'),
          content: const SizedBox(
            height: 300.0, // Set a fixed height for the dialog content
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Privacy Policy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'At Propertier, we offer a comprehensive suite of services designed to meet all your property needs. '
                    'Our team of experts and specialists are dedicated to providing top-notch solutions in various aspects '
                    'of real estate and construction. Our services include:',
                  ),
                  SizedBox(height: 10),
                  Text(
                      '1. Document Verification: Ensure the legality and authenticity of property documents with our expert team of advocates and legal professionals.'),
                  SizedBox(height: 5),
                  Text(
                      '2. Property Expertise: Our seasoned property experts provide valuable insights and advice for buying, selling, and managing properties.'),
                  SizedBox(height: 5),
                  Text(
                      '3. Property Valuation: Get accurate and reliable property valuations for all types of real estate.'),
                  SizedBox(height: 5),
                  Text(
                      '4. Architectural and Design Services: From 2D and 3D AutoCAD mapping to architectural design, our skilled architects, exterior designers, and interior designers bring your vision to life.'),
                  SizedBox(height: 5),
                  Text(
                      '5. Surveying Services: We offer land surveying, quantity surveying, and quality surveying services to ensure precise planning and execution of projects.'),
                  SizedBox(height: 5),
                  Text(
                      '6. Engineering Services: Our team of engineers, including civil engineers, provides expert guidance on construction and infrastructure projects.'),
                  SizedBox(height: 5),
                  Text(
                      '7. Utility and Logistics: We facilitate water provision, transportation, and material supply, along with construction machinery services like excavators, bulldozers, and cranes.'),
                  SizedBox(height: 5),
                  Text(
                      '8. Machinery and Equipment Rental: Access a wide range of construction machinery, including excavators, bobcats, backhoe loaders, motor graders, and more.'),
                  SizedBox(height: 5),
                  Text(
                      '9. Labor Services: We provide skilled labor for various tasks, including masonry, plastering, carpentry, steel fixing, shuttering, and more. Our team also includes experts in electrical, plumbing, HVAC systems, and other specialized trades.'),
                  SizedBox(height: 5),
                  Text(
                      '10. Property Maintenance and Development: From caretakers and security guards to surveillance services and land development, we ensure your property is well-maintained and secure.'),
                  SizedBox(height: 5),
                  Text(
                      '11. Registry and Documentation: We offer registry, intaqal, and property document services to streamline the legal aspects of property ownership and transactions.'),
                  SizedBox(height: 5),
                  Text(
                      '12. Marketing and Advertising: Our SMM services for real estate, billboard advertising, and drafting services help promote and market your properties effectively.'),
                  SizedBox(height: 10),
                  Text(
                    'Please read and accept our privacy policy to proceed with login.',
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Decline'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Accept'),
            ),
          ],
        );
      },
    );

    return accept!;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return signupVM.isSuccess
          ? const LoadingView()
          : Scaffold(
              resizeToAvoidBottomInset: true,
              body: Form(
                key: signupVM.calledFormKey,
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
                            title: 'Collect Info',
                            onTap: () {
                              Get.back();
                            }),
                        SizedBox(
                          width: sizeWidth(1, 0.7),
                          child: Column(
                            children: [
                              getHeight(context, 0.069),
                              Align(
                                  alignment: Alignment.center,
                                  child: logoTile(context)),
                              getHeight(context, 0.090),
                              // customTextField(
                              //   labal: "Full Name",
                              //   controller: signupVM.nameController,
                              //   hintText: 'Full Name',
                              //   textInputType: TextInputType.name,
                              //   suffix: GestureDetector(
                              //     onTap: () {
                              //       print("Start Listing");
                              //       signupVM.startListening(textFieldNo: 0);
                              //     },
                              //     child: Image.asset(
                              //       Constant.mic,
                              //       height: context.getSize.height * 0.022,
                              //       width: context.getSize.width * 0.038,
                              //     ),
                              //   ),
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Please enter Full Name';
                              //     }
                              //     return null;
                              //   },
                              // ),
                              const SizedBox(
                                height: 12,
                              ),
                              customTextField(
                                label: "Email",
                                controller: signupVM.emailController,
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
                                  // searchLocationBottomSheet(
                                  //     placesList: signupVM.places,
                                  //     onSelect: (val) {
                                  //       signupVM.locationController.text = val;
                                  //       signupVM.getGeoCode(val);
                                  //       signupVM.searchAddressController
                                  //           .clear();
                                  //       signupVM.places.clear();
                                  //       Get.back();
                                  //     },
                                  //     onChange: (val) {
                                  //       signupVM.searchPlaces(val);
                                  //     },
                                  //     context: context,
                                  //     searchController:
                                  //         signupVM.searchAddressController);
                                },
                                readOnly: true,
                                label: "Address",
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
                                controller: signupVM.numberController,
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
                                  Obx(
                                    () => Expanded(
                                      child: signupVM.isSuccess == true
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                color: AppColor.buttonColor,
                                              ),
                                            )
                                          : customTextButton(
                                              height: 48,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              onTap: () async {
                                                if (signupVM.calledFormKey
                                                        .currentState!
                                                        .validate() &&
                                                    signupVM.numberController
                                                            .text !=
                                                        "") {
                                                  signupVM.calledFormKey
                                                      .currentState
                                                      ?.save();

                                                  signupVM.sendOTPtoEmail(
                                                      email: signupVM
                                                          .emailController
                                                          .text);
                                                } else if (signupVM
                                                    .numberController
                                                    .text
                                                    .isEmpty) {
                                                  toast(
                                                      title:
                                                          "Please Provide number",
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
                              const SocialLinks(),
                            ],
                          ),
                        ),
                        getHeight(context, 0.012),
                      ],
                    ),
                  ),
                ),
              ),
            );
    });
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    return emailRegex.hasMatch(email);
  }
}

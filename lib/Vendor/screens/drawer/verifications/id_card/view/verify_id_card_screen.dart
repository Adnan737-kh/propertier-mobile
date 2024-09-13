import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/id_card/controller/document_controller.dart';

import '../../../../dashboard/profile/controller/profile_controller.dart';



class VerifyIdCardScreen extends StatefulWidget {
  const VerifyIdCardScreen({super.key});

  @override
  State<VerifyIdCardScreen> createState() => _VerifyIdCardScreenState();
}

class _VerifyIdCardScreenState extends State<VerifyIdCardScreen> {
  DocumentController awardController = Get.put(DocumentController());
   final ProfileController profileController = Get.put(ProfileController());
  final ImagePicker _picker = ImagePicker();
  XFile? selectedFrontImage;
  XFile? selectedBackImage;
  // Variable to store the selected image

  Future<void> _updateCnicFront() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedFrontImage = image;
      });
    }
  }

  Future<void> _updateCnicBack() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedBackImage = image;
      });
    }
  }

Future<void> _sendCnic() async {
  if (selectedFrontImage != null && selectedBackImage != null) {
    final box = GetStorage();
    String? vendorUserId = box.read('vendorUserId');

    // Get required fields from the profile controller
    String firebaseId = profileController.profile.value.firebaseId ?? '';
    String email = profileController.profile.value.email ?? '';
    String type = profileController.profile.value.type ?? '';

    // Debugging: print to verify if all fields are being retrieved correctly
    print('Vendor User ID: $vendorUserId');
    print('Firebase ID: $firebaseId');
    print('Email: $email');
    print('Type: $type');
    
    if (vendorUserId != null && vendorUserId.isNotEmpty && 
        firebaseId.isNotEmpty && email.isNotEmpty && type.isNotEmpty) {
      
      await awardController.updateCnic(
        File(selectedFrontImage!.path),
        File(selectedBackImage!.path),
        vendorUserId,
        firebaseId,
        email,
        type,
      );
    } else {
      Get.snackbar('Error', 'Required user information is missing');
    }
  } else {
    Get.snackbar('Error', 'No image selected');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'ID Card Verification',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: Get.height * .08,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DottedBorder(
                    color: Colors.grey.shade600,
                    dashPattern: [9, 4],
                    child: InkWell(
                      onTap: () {
                        _updateCnicFront();
                      },
                      child: Container(
                        height: Get.height * .22,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: selectedFrontImage == null
                                  ? NetworkImage(
                                      ProfileController()
                                              .profile.value.cnicFrontUrl ??
                                          "https://images.unsplash.com/photo-1719054415148-b83895be5157?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90b3MtZmVlZHw0NHx8fGVufDB8fHx8fA%3D%3D",
                                    )
                                  : FileImage(File(selectedFrontImage!.path))
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            )),
                      ),
                    )),
                const SizedBox(height: 8),
                const Text(
                  'Please Take photo of your ID Card from front',
                  style: TextStyle(
                    color: Color(0xB2131A22),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                const Divider(),
                const SizedBox(height: 35),
                DottedBorder(
                    color: Colors.grey.shade600,
                    dashPattern: [9, 4],
                    child: InkWell(
                      onTap: () {
                        _updateCnicBack();
                      },
                      child: Container(
                        height: Get.height * .22,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: selectedBackImage == null
                                  ? NetworkImage(
                                      ProfileController()
                                              .profile.value.cnicBackUrl ??
                                          "https://images.unsplash.com/photo-1719054415148-b83895be5157?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90b3MtZmVlZHw0NHx8fGVufDB8fHx8fA%3D%3D",
                                    )
                                  : FileImage(File(selectedBackImage!.path))
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            )),
                      ),
                    )),
                const SizedBox(height: 8),
                const Text(
                  'Please Take photo of your ID Card from Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xB2131A22),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: Get.height * .1,
                ),
                InkWell(
                  onTap: () {
                    _sendCnic();
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

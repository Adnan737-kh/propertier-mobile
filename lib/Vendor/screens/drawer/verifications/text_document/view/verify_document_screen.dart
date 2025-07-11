import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/Vendor/screens/dashboard/profile/controller/profile_controller.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/text_document/Contoller/text_document_Controller.dart';

class VerifyDocumentScreen extends StatefulWidget {
  const VerifyDocumentScreen({super.key});

  @override
  State<VerifyDocumentScreen> createState() => _VerifyDocumentScreenState();
}

class _VerifyDocumentScreenState extends State<VerifyDocumentScreen> {
  final VerifyDocumentController documentController =
      Get.put(VerifyDocumentController());
  final ProfileController profileController = Get.put(ProfileController());
  File? selectedIncorporationImage;
  File? selectedSoleProprietorImage;

  Future<void> _pickImage(String documentType) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (documentType == 'incorporate') {
          selectedIncorporationImage = File(pickedFile.path);
          documentController
              .setIncorporateDocument(selectedIncorporationImage!);
        } else if (documentType == 'sole_proprietor') {
          selectedSoleProprietorImage = File(pickedFile.path);
          documentController
              .setSoleProprietorDocument(selectedSoleProprietorImage!);
        }
      });
    }
  }

  Future<void> _sendDocuments() async {
    if (selectedIncorporationImage != null ||
        selectedSoleProprietorImage != null) {
      final box = GetStorage();
      String? vendorUserId = box.read('vendorUserId');

      String firebaseId = profileController.profile.value.firebaseId ?? '';
      String email = profileController.profile.value.email ?? '';
      String type = profileController.profile.value.type ?? '';

      if (vendorUserId != null &&
          vendorUserId.isNotEmpty &&
          firebaseId.isNotEmpty &&
          email.isNotEmpty &&
          type.isNotEmpty) {
        await documentController.sendDocuments(
          firebaseId: firebaseId,
          email: email,
          type: type,
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
                    color: Colors.black.withOpacity(0.05),
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
                GestureDetector(
                  onTap: () => _pickImage('incorporate'),
                  child: DottedBorder(
                    color: Colors.grey.shade600,
                    dashPattern: const [9, 4],
                    child: SizedBox(
                      height: Get.height * .2,
                      width: Get.width * .8,
                      child: selectedIncorporationImage == null
                          ? const Center(
                              child: Icon(
                                Icons.camera_alt,
                                size: 38,
                                color: Colors.black45,
                              ),
                            )
                          : Image.file(
                              selectedIncorporationImage!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Please Take photo of your ',
                        style: TextStyle(
                          color: Color(0xB2131A22),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Incorporate',
                        style: TextStyle(
                          color: Color(0xFF4286F5),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 26,
                ),
                const Divider(),
                const SizedBox(height: 35),
                GestureDetector(
                  onTap: () => _pickImage('sole_proprietor'),
                  child: DottedBorder(
                    color: Colors.grey.shade600,
                    dashPattern: const [9, 4],
                    child: SizedBox(
                      height: Get.height * .2,
                      width: Get.width * .8,
                      child: selectedSoleProprietorImage == null
                          ? const Center(
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.black45,
                                size: 38,
                              ),
                            )
                          : Image.file(
                              selectedSoleProprietorImage!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Please Take photo of your ',
                        style: TextStyle(
                          color: Color(0xB2131A22),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Sole Propertier',
                        style: TextStyle(
                          color: Color(0xFF4286F5),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * .1,
                ),
                InkWell(
                  onTap: _sendDocuments,
                  child: Container(
                    width: Get.size.width,
                    height: Get.height * .071,
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
        ],
      ),
    );
  }
}

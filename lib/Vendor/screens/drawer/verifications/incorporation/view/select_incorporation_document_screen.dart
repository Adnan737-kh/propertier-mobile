import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/success_screen.dart';

import '../../../../dashboard/profile/controller/profile_controller.dart';
import '../../id_card/controller/document_controller.dart';

class SelectIncorporationDocumentScreen extends StatefulWidget {
  const SelectIncorporationDocumentScreen({super.key});

  @override
  State<SelectIncorporationDocumentScreen> createState() =>
      _SelectIncorporationDocumentScreenState();
}

class _SelectIncorporationDocumentScreenState
    extends State<SelectIncorporationDocumentScreen> {
  DocumentController documentController = Get.put(DocumentController());
  final ProfileController profileController = Get.put(ProfileController());
  final ImagePicker _picker = ImagePicker();
  XFile? selectedIncorporationImage;
  XFile? selectedArtificaialAssociatioinImage;
  XFile? selectedMemberofAssocciationImage;

  Future<void> _updateIncorporation() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedIncorporationImage = image;
      });
    }
  }

  Future<void> _updateAssociation() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedArtificaialAssociatioinImage = image;
      });
    }
  }

  Future<void> _updateMemberofAssociation() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedMemberofAssocciationImage = image;
      });
    }
  }

  Future<void> _sendDocuments() async {
    if (selectedIncorporationImage != null ||
        selectedArtificaialAssociatioinImage != null ||
        selectedMemberofAssocciationImage != null) {
      final box = GetStorage();
      String? vendorUserId = box.read('vendorUserId');

      // Get required fields from the profile controller
      String firebaseId = profileController.profile.value.firebaseId ?? '';
      String email = profileController.profile.value.email ?? '';
      String type = profileController.profile.value.type ?? '';

      if (vendorUserId != null &&
          vendorUserId.isNotEmpty &&
          firebaseId.isNotEmpty &&
          email.isNotEmpty &&
          type.isNotEmpty) {
        if (selectedIncorporationImage != null) {
          await documentController.updateIncorporationDocument(
            File(selectedIncorporationImage!.path),
            vendorUserId,
            firebaseId,
            email,
            type,
          );
        }
        if (selectedArtificaialAssociatioinImage != null) {
          await documentController.updateAssociationDocument(
            File(selectedArtificaialAssociatioinImage!.path),
            vendorUserId,
            firebaseId,
            email,
            type,
          );
        }
        if (selectedMemberofAssocciationImage != null) {
          await documentController.updateMemberofAssociation(
            File(selectedMemberofAssocciationImage!.path),
            vendorUserId,
            firebaseId,
            email,
            type,
          );
        }

        Get.snackbar('Success', 'Documents uploaded successfully!');
        Get.to(() => const SuccessScreen(
              text: 'Verify',
            ));
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
                    'Incorporation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: Get.height * .9,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Get.height * .08,
                    ),
                    DottedBorder(
                        color: Colors.grey.shade600,
                        dashPattern: const [9, 4],
                        child: InkWell(
                          onTap: () {
                            _updateIncorporation();
                          },
                          child: Container(
                            height: Get.height * .2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                  image: selectedIncorporationImage == null
                                      ? NetworkImage(ProfileController()
                                              .profile
                                              .value
                                              .certificateOfIncorporationUrl ??
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9G-3fE_XkNuDmyKAl0Cdd5uwtjAhGkP1BxQ&s')
                                      : FileImage(File(
                                              selectedIncorporationImage!.path))
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        )),
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
                            text: 'Certificate\nof In Corporation',
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
                      height: 8,
                    ),
                    const Divider(
                      color: Colors.black26,
                    ),
                    const SizedBox(height: 9),
                    DottedBorder(
                      color: Colors.grey.shade600,
                      dashPattern: const [9, 4],
                      child: InkWell(
                        onTap: () {
                          _updateAssociation();
                        },
                        child: Container(
                          height: Get.height * .2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image: selectedArtificaialAssociatioinImage ==
                                        null
                                    ? NetworkImage(
                                        ProfileController()
                                                .profile
                                                .value
                                                .artificialOfAssociationUrl ??
                                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9G-3fE_XkNuDmyKAl0Cdd5uwtjAhGkP1BxQ&s",
                                      )
                                    : FileImage(File(
                                        selectedArtificaialAssociatioinImage!
                                            .path)) as ImageProvider,
                                fit: BoxFit.cover,
                              )),
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
                            text: 'Artificial of\nAssociation',
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
                      height: 8,
                    ),
                    const Divider(
                      color: Colors.black26,
                    ),
                    const SizedBox(height: 9),
                    DottedBorder(
                      color: Colors.grey.shade600,
                      dashPattern: const [9, 4],
                      child: InkWell(
                        onTap: () {
                          _updateMemberofAssociation();
                        },
                        child: Container(
                          height: Get.height * .2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image: selectedMemberofAssocciationImage == null
                                    ? NetworkImage(
                                        ProfileController()
                                                .profile
                                                .value
                                                .memberOfAssociationUrl ??
                                            "https://images.unsplash.com/photo-1719054415148-b83895be5157?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90b3MtZmVlZHw0NHx8fGVufDB8fHx8fA%3D%3D",
                                      )
                                    : FileImage(File(
                                        selectedMemberofAssocciationImage!
                                            .path)) as ImageProvider,
                                fit: BoxFit.cover,
                              )),
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
                            text: 'Member of Association',
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
                      height: Get.height * .03,
                    ),
                    InkWell(
                      onTap: () {
                        _sendDocuments(); // Correctly invoke the _sendDocuments method
                      },
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

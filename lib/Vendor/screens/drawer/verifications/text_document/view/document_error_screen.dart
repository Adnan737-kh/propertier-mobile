
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Vendor/screens/drawer/verifications/text_document/view/verify_document_screen.dart';

class TextDocumentErrorScreen extends StatefulWidget {
  const TextDocumentErrorScreen({super.key});

  @override
  State<TextDocumentErrorScreen> createState() =>
      _TextDocumentErrorScreenState();
}

class _TextDocumentErrorScreenState extends State<TextDocumentErrorScreen> {
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
                    'Text Document',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: Get.height * .24,
          ),
          const Icon(
            Icons.cancel_outlined,
            color: Color(0xFFE93E28),
            size: 88,
          ),
          const SizedBox(
            height: 2,
          ),
          const Text(
            'Error',
            style: TextStyle(
              color: Color(0xFF131A22),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your Text Document is not verified',
            style: TextStyle(
              color: Color(0xB2131A22),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              Get.to(() => const VerifyDocumentScreen());
            },
            child: const Text(
              'Verify Yor Text Document?',
              style: TextStyle(
                color: Color(0xFF4286F5),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

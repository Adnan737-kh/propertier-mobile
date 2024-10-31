import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              width: Get.size.width,
              height: Get.height * .093,
              padding: const EdgeInsets.only(top: 30, left: 8),
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
                    'Policy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 24,
          ),
          Container(
            height: Get.height * .87,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This Privacy Policy sets out the commitment of Propertier Marketing PVT Ltd, the developer of Propertier, to protecting the privacy of our users. Our goal is to provide a safe and secure platform for users to search for and find real estate information.',
                    style: TextStyle(
                      color: Color(0x66131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Information Collected',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We collect information that you voluntarily provide to us, such as your name, email address, phone number, and any other contact information. We also collect information about your app usage, such as the properties you search for, save, and view, as well as your preferences and settings',
                    style: TextStyle(
                      color: Color(0x66131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Purpose of Collecting Information',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We collect information to offer you with a tailored experience when using our app, to connect with you, to answer to your requests, to provide support, and to improve our services.',
                    style: TextStyle(
                      color: Color(0x66131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Sharing Information',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We will not sell, rent, or lease your personal information to third parties. We may share your information with our service providers for the purpose of providing our services, such as payment processors, email service providers, and marketing firms. These third parties are subject to strict confidentiality agreements and are only authorized to use your information as necessary to provide their services to us.',
                    style: TextStyle(
                      color: Color(0x66131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Data Security',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We take appropriate measures to protect the security of your personal information, including using secure servers, encryption, and firewalls. However, no method of transmission over the Internet or electronic storage is 100% secure. Therefore, we cannot guarantee its absolute security.',
                    style: TextStyle(
                      color: Color(0x66131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Access and Control of Your Information',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'You have the right to access, correct, update, and delete your personal information at any time. You can do this by logging into your account and updating your profile. If you wish to delete your account, please contact our support team at Support@propertier.com.pk This Privacy Policy sets out the commitment of Propertier Marketing PVT Ltd, the developer of Propertier, to protecting the privacy of our users. Our goal is to provide a safe and secure platform for users to search for and find real estate information.',
                    style: TextStyle(
                      color: Color(0x66131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Information Collected',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We collect information that you provide directly to us, such as your name, email address, phone number, and any other contact information you choose to provide. In addition, we collect information about your use of our app, such as the properties you search for, save, and view, as well as your preferences and settings.',
                    style: TextStyle(
                      color: Color(0x66131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),
                  Opacity(
                    opacity: 0.60,
                    child: Text(
                      'Purpose of Collecting Information',
                      style: TextStyle(
                        color: Color(0xFF131A22),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We use the information we collect to provide you with a personalized experience while using our app, to communicate with you, to respond to your requests, to provide support, and to improve our services.',
                    style: TextStyle(
                      color: Color(0x66131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Sharing Information',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We will not sell, rent, or lease your personal information to third parties. We may share your information with our service providers for the purpose of providing our services, such as payment processors, email service providers, and marketing firms. These third parties are subject to strict confidentiality agreements and are only authorized to use your information as necessary to provide their services to us.',
                    style: TextStyle(
                      color: Color(0x66131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Data Security',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We take appropriate measures to protect the security of your personal information, including using secure servers, encryption, and firewalls. However, no method of transmission over the Internet or electronic storage is 100% secure. Therefore, we cannot guarantee its absolute security.',
                    style: TextStyle(
                      color: Color(0x66131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Access and Control of Your Information',
                    style: TextStyle(
                      color: Color(0xFF131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'You have the right to access, correct, update, and delete your personal information at any time. You can do this by logging into your account and updating your profile. If you wish to delete your account, please contact us at [contact information].\n\nA payment policy is a set of rules and guidelines for accepting and processing payments for goods or services. It typically outlines acceptable forms of payment, payment processing time frames, and any associated fees or charges. The payment policy may also include information on dispute resolution and refunds.\n\nPayment Policy: All payments are processed through the Bank Alfalah payment channel.\n\nPayment Refusal: Transactions that are deemed malicious or unlawful will be rejected.\n\nPayment Refund: If the product does not meet expectations, clients have 15 days to seek a refund. After reviewing the claim, the support team will validate it and offer a full refund if it is found to be legitimate.\n\nCustomers can contact us at support@propertier.com.pk for assistance.',
                    style: TextStyle(
                      color: Color(0x66131A22),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

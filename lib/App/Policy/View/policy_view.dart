import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Policy/Components/policy_tile.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import '../../../Utils/appbar.dart';
// import '../Components/review_tile.dart';s
import '../ViewModel/policy_viewmodel.dart';

class PolicyView extends StatelessWidget {
  PolicyView({super.key});
  final viewModel = Get.find<PolicyViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * 0.060),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  getHeight(context, 0.050),
                  customAppBar(
                      context: context,
                      onTap: () => Get.back(),
                      title: "Policy",
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  getHeight(context, 0.050),
                ],
              ),
              //Policy
              appText(
                  title:
                      "This Privacy Policy sets out the commitment of Propertier Marketing PVT Ltd, the developer of Propertier, to protecting the privacy of our users. Our goal is to provide a safe and secure platform for users to search for and find real estate information.",
                  context: context,
                  fontSize: 14,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w400,
                  colorOpecity: 0.4),
              policyTile(
                  title: "Information Collected",
                  subTitle:
                      "We collect information that you voluntarily provide to us, such as your name, email address, phone number, and any other contact information. We also collect information about your app usage, such as the properties you search for, save, and view, as well as your preferences and settings",
                  context: context),
              policyTile(
                  title: "Purpose of Collecting Information",
                  subTitle:
                      "We collect information to offer you with a tailored experience when using our app, to connect with you, to answer to your requests, to provide support, and to improve our services.",
                  context: context),
              policyTile(
                  title: "Sharing Information",
                  subTitle:
                      "We will not sell, rent, or lease your personal information to third parties. We may share your information with our service providers for the purpose of providing our services, such as payment processors, email service providers, and marketing firms. These third parties are subject to strict confidentiality agreements and are only authorized to use your information as necessary to provide their services to us.",
                  context: context),
              policyTile(
                  title: "Data Security",
                  subTitle:
                      "We take appropriate measures to protect the security of your personal information, including using secure servers, encryption, and firewalls. However, no method of transmission over the Internet or electronic storage is 100% secure. Therefore, we cannot guarantee its absolute security.",
                  context: context),
              policyTile(
                  title: "Access and Control of Your Information",
                  subTitle:
                      "You have the right to access, correct, update, and delete your personal information at any time. You can do this by logging into your account and updating your profile. If you wish to delete your account, please contact our support team at Support@propertier.com.pk This Privacy Policy sets out the commitment of Propertier Marketing PVT Ltd, the developer of Propertier, to protecting the privacy of our users. Our goal is to provide a safe and secure platform for users to search for and find real estate information.",
                  context: context),
              policyTile(
                  title: "",
                  subTitle:
                      "A payment policy is a set of rules and guidelines for accepting and processing payments for goods or services. It typically outlines acceptable forms of payment, payment processing time frames, and any associated fees or charges. The payment policy may also include information on dispute resolution and refunds",
                  context: context),
              policyTile(
                  title: "",
                  subTitle:
                      "Payment Policy: All payments are processed through the Bank Alfalah payment channel.",
                  context: context),
              policyTile(
                  title: "",
                  subTitle:
                      "Payment Refusal: Transactions that are deemed malicious or unlawful will be rejected.",
                  context: context),
              policyTile(
                  title: "",
                  subTitle:
                      "Payment Refund: If the product does not meet expectations, clients have 15 days to seek a refund. After reviewing the claim, the support team will validate it and offer a full refund if it is found to be legitimate.",
                  context: context),
              policyTile(
                  title: "",
                  subTitle:
                      "Customers can contact us at support@propertier.com.pk for assistance.",
                  context: context),
            ],
          ),
        ),
      ),
    );
  }
}

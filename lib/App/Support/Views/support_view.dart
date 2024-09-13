import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_text.dart';
import '../../../Utils/appbar.dart';
import '../../../Utils/height_width_box.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: Column(
          children: [
            getHeight(context, 0.050),
            customAppBar(
                context: context,
                onTap: () {
                  Get.back();
                },
                title: "Support"),
            getHeight(context, 0.360),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  appText(
                    title: "To See Support visit \nPropertier Website.",
                    fontSize: 16,
                    colorOpecity: 0.7,
                    context: context,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // Add your code here (e.g., navigate to another page or URL)
                      String url = "https://support.propertier.com.pk/";
                      // var urllaunchable = await canLaunchUrl(Uri.parse(url));
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        print("URL can't be launched.");
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(context.getSize.width * 0.008),
                      child: appText(
                        title: "Visit Propertier website?",
                        color: AppColor.facebookColor,
                        fontSize: 14,
                        colorOpecity: 0.7,
                        context: context,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

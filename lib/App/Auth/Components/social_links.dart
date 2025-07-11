import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({
    super.key,
  });
  void _onClick(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      if (kDebugMode) {
        print("URL can't be launched.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        socialBtn(
            onTap: () {
              _onClick("https://www.facebook.com/Propertier.com.pk/");
            },
            imagePath: "assets/icons/facebook.png"),
        const Gap(15),
        socialBtn(
            onTap: () {
              _onClick("https://x.com/Propertiercom");
            },
            imagePath: "assets/icons/X.png"),
        const Gap(15),
        socialBtn(
            onTap: () {
              _onClick("https://www.instagram.com/propertier.com.pk/");
            },
            imagePath: "assets/icons/Instagram1.png"),
        const Gap(15),
        socialBtn(
            onTap: () {
              _onClick("https://www.youtube.com/@propertier");
            },
            imagePath: "assets/icons/Youtube1.png"),
      ],
    );
  }

  GestureDetector socialBtn(
      {required Function()? onTap, required String imagePath}) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        imagePath,
        width: 33,
      ),
    );
  }
}

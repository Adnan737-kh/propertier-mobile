import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/extensions/size_extension.dart';

class AdsView extends StatelessWidget {
  const AdsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
        child: Column(
          children: [
            getHeight(context, 0.040),
            customAppBar(
                context: context,
                onTap: () {
                  Get.back();
                },
                title: 'Ads')
          ],
        ),
      )),
    );
  }
}

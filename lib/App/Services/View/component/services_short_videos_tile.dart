import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Services/ViewModel/services_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class ServicesShortVideoTile extends StatelessWidget {
  final ServicesViewModel viewModel;
  const ServicesShortVideoTile({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomText(
                  title: context.local.short_videos,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                const Icon(
                  Ionicons.play_circle_outline,
                  size: 20,
                )
              ],
            ),
            CustomText(
              title: context.local.view_more,
              color: AppColor.greenColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        getHeight(context, 0.011),
        GridView.count(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 11,
          childAspectRatio: 2 / 3,
          // height: context.getSize.height * 0.325,
          children: List.generate(
            2,
            (index) => Container(
              // height: context.getSize.height / 2,
              // width: context.getSize.width / 2,
              padding: const EdgeInsets.all(15),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: NetworkImage(Constant.dummyImage),
                    fit: BoxFit.cover,
                  )),
              child: Container(
                height: context.getSize.height * 0.043,
                width: context.getSize.width * 0.086,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: border(color: AppColor.buttonColor, width: 1),
                    image: const DecorationImage(
                        image: NetworkImage(
                          Constant.dummyImage,
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
        )
      ],
    );
  }
}

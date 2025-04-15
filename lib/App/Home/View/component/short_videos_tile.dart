import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/Utils/App%20Ad%20Mob/app_interstitial_ads.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Model/property.dart';
import '../../../Profile/View/component/ShortVideoPlayer/VideoPlayerScreen.dart';

// ignore: must_be_immutable
class ShortVideosTile extends StatelessWidget {
  HomeViewModel viewModel;
  List<Property> shortVideosList;
  ShortVideosTile(
      {super.key, required this.viewModel, required this.shortVideosList});
  @override
  Widget build(BuildContext context) {
    List<Property> newShortVideoList = shortVideosList;
    if (kDebugMode) {
      print("new ShortVideo List ${newShortVideoList.length}");
    }
    List<Property> shortVideos = [];
    if (viewModel.isSale.value == true) {
      shortVideos = newShortVideoList
          .where((e) => e.purpose!.toLowerCase() == "sale")
          .toList();
    } else {
      shortVideos = newShortVideoList
          .where((e) => e.purpose!.toLowerCase() == "rent")
          .toList();
    }
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.getSize.width * 0.036),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  appText(
                    title: context.local.shortVideos,
                    context: context,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const Gap(5),
                  const Icon(
                    Ionicons.play_circle_outline,
                    size: 20,
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.shortVideoView,
                      arguments: shortVideos[0]);
                },
                child: appText(
                  title: context.local.viewMore,
                  context: context,
                  color: AppColor.greenColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        getHeight(context, 0.011),
        listShortVideos(context, newShortVideoList)
      ],
    );
  }

  SizedBox listShortVideos(BuildContext context, List<Property> shortVideos) {
    return SizedBox(
      height: context.isPhone
          ? context.getSize.height * 0.37
          : context.getSize.height * 0.34,
      width: context.getSize.width,
      child: shortVideos.isEmpty
          ? Center(
              child: appText(title: 'No Data Available', context: context),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              cacheExtent: 500000,
              padding: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.036),
              physics: const BouncingScrollPhysics(),
              itemCount: shortVideos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async {
                      await loadAndShowInterstitialAd();
                      // Get.toNamed(AppRoutes.shortVideoView,
                      //     arguments: shortVideos[index]);
                      Get.to(VideoPlayerScreen(
                          properties: const [], property: shortVideos[index]));
                    },
                    child: ShortVideoThumbnail(
                      property: shortVideos[index],
                    ));
              },
            ),
    );
  }
}

class ShortVideoThumbnail extends StatefulWidget {
  final Property property;

  const ShortVideoThumbnail({super.key, required this.property});

  @override
  State<ShortVideoThumbnail> createState() => _ShortVideoThumbnailState();
}

class _ShortVideoThumbnailState extends State<ShortVideoThumbnail> {
  // String? _path;
  generateThumbnail(String videoPath) async {
    try {} catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  void initState() {
    widget.property.shortVideo != null
        ? generateThumbnail(
            widget.property.shortVideo!,
          )
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
      // height: context.getSize.height / 2,
      width: context.isPhone ? 200 : 260,
      padding: const EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(widget.property.image!),
            fit: BoxFit.cover,
          )),
      child: Container(
        height: context.getSize.height * 0.043,
        width: context.isPhone ? 200 : 260,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: border(color: AppColor.buttonColor, width: 1),
            image: DecorationImage(
                image:
                    NetworkImage(widget.property.image ?? Constant.dummyImage),
                fit: BoxFit.cover)),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:propertier/App/Details/View/component/details_title.dart';
import 'package:propertier/App/Details/View/component/video_tour.dart';

import 'package:propertier/Customer/screens/ServiceDetail/model/service_details_model.dart';

import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/scrollableText.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/price_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../App/Profile/View/component/SingleVideoPlayer/SingleVideoScreen.dart';
import '../../../../Model/property.dart';
import '../../../../Utils/App Ad Mob/app_banner_ads.dart';
import '../../../../Utils/border.dart';
import '../../../../Utils/info_tile.dart';
import '../controller/services_details_controller.dart';

Widget detailTile(BuildContext context,
    {
      // required VideosModel videosModel,
      required ServiceDetailsController controller}) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: context.getSize.width * 0.015,
        vertical: context.getSize.height * 0.02),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: AppColor.white,
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            scrollableText(
                width: 0.55,
                title: controller.serviceDetails.value.title!,
                context: context,
                textStyle: textStyle(
                    color: AppColor.blackColor.withOpacity(0.7),
                    context: context,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            CustomText(
              title: double.parse(controller.serviceDetails.value.rate??"00.0").formatPrice(),
              fontSize: 14,
              color: AppColor.greenColor,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        getHeight(context, 0.006),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Ionicons.location,
              color: AppColor.buttonColor,
              size: context.getSize.width * 0.030,
            ),
            const Gap(5),
            // scrollableText(
            //     context: context,
            //     textStyle: textStyle(
            //         context: context,
            //         fontSize: 12,
            //         fontWeight: FontWeight.w400,
            //         color: AppColor.blackColor.withOpacity(0.8)),
            //     title: controller.service.service.!),
          ],
        ),
        getHeight(context, 0.0072),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: List.generate(
        //       dataModel.property!.features!.length,
        //       (index) => dataModel.property!.features!.isEmpty
        //           ? const SizedBox.shrink()
        //           : Row(
        //               children: [
        //                 getWidth(context, 0.005),
        //               ],
        //             )),
        // ),
        getHeight(context, 0.007),
        divider(context: context, color: const Color(0xffCFCFCF)),
        getHeight(context, 0.015),
        detailsTitle(
          context: context,
          title: context.local.description,
        ),
        getHeight(context, 0.002),
        CustomText(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            colorOpecity: 0.8,
            textAlign: TextAlign.justify,
            title: controller.serviceDetails.value.description??""),
        getHeight(context, 0.007),
        divider(context: context, color: const Color(0xffCFCFCF)),
        getHeight(context, 0.01),
        infoTile(
          context,
          title: context.local.vendor,
          subtitle: controller.serviceDetails.value.vendor?.fullName??"",
          //  dataModel.property!.vendor,
        ),
        getHeight(context, 0.01),
        // infoTile(context,
        //     title: context.local.type,
        //     subtitle: controller.serviceDetails.value.isFeatured== null
        //     || controller.serviceDetails.isFeatured! == false ? "Un-Featured":"Featured"),
        getHeight(context, 0.01),
        // infoTile(context,
        //     title: context.local.area,
        //     subtitle:
        //     "${dataModel.property!.area!.toDouble().convertArea(areaType: dataModel.property!.areaUnit ?? '').toString()} ${dataModel.property!.areaUnit ?? ''}",
        //     isShowIcon: true,
        //     icon: Constant.marla),
        // getHeight(context, 0.007),
        // divider(context: context, color: const Color(0xffCFCFCF)),
        getHeight(context, 0.015),
        controller.serviceDetails.value.youtubeVideoUrl == null
            ? const SizedBox.shrink()
            : detailsTitle(context: context, title: context.local.videoTour),
        controller.serviceDetails.value.youtubeVideoUrl== null
            ? const SizedBox.shrink()
            : getHeight(context, 0.005),
        controller.serviceDetails.value.youtubeVideoUrl == null
            ? const SizedBox.shrink()
            : VideoTour(videoUrl: controller.serviceDetails.value.youtubeVideoUrl ?? ''),
        getHeight(context, 0.050),
        divider(context: context, color: const Color(0xffCFCFCF)),
        getHeight(context, 0.015),
       const SizedBox(
            height: 50,
            child: Center(child: AppBannerAd())),
        detailsTitle(context: context, title: context.local.detailShortVideo),
        getHeight(context, 0.005),
        controller.serviceDetails.value.shortVideo != null
            ? DetailPageShortVideo(
          services: controller.serviceDetails.value,
        )
            : const SizedBox(),
        getHeight(context, 0.010),
      ],
    ),
  );
}

class DetailPageShortVideo extends StatefulWidget {
  final ServiceDetailsModel services;

  const DetailPageShortVideo({super.key, required this.services});

  @override
  State<DetailPageShortVideo> createState() => _DetailPageShortVideoState();
}

class _DetailPageShortVideoState extends State<DetailPageShortVideo> {
  String? _path;
  generateThumbnail(String videoPath) async {
    try {
      final String? thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128, // specify the width of the thumbnail, can be adjusted
        quality: 75, // specify the quality of the thumbnail, can be adjusted
      );
      setState(() {
        _path = thumbnailPath;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  @override
  void initState() {
    print('short video ${widget.services.shortVideo}');
    widget.services.shortVideo != null
        ? generateThumbnail(
      widget.services.shortVideo!,
    )
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(SingleVideoScreen(properties:
          [Property(shortVideo: widget.services.shortVideo)],
              property: Property(shortVideo: widget.services.shortVideo)));
        },
        child: SizedBox(
            width: context.getSize.width * 0.6,
            height: context.getSize.height * 0.5,
            child: _path != null
                ? Container(
              margin: EdgeInsets.symmetric(
                  horizontal: context.getSize.width * 0.015, vertical: 5),
              // height: context.getSize.height / 2,
              width: context.getSize.width / 4,
              padding: const EdgeInsets.all(15),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: FileImage(File(_path!)),
                    fit: BoxFit.cover,
                  )),
              child: Container(
                height: context.getSize.height * 0.043,
                width: context.getSize.width * 0.086,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: border(color: AppColor.buttonColor, width: 1),
                    image:const  DecorationImage(
                        image: NetworkImage(Constant.dummyImage),
                        fit: BoxFit.cover)),
              ),
            )
                : const Center(
                child: CircularProgressIndicator(
                  color: AppColor.buttonColor,
                ))));
  }
}

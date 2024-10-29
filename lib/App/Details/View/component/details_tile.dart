import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:propertier/App/Details/Model/specific_property_model.dart';
import 'package:propertier/App/Details/View/component/details_title.dart';
import 'package:propertier/App/Details/View/component/recommendedTile.dart';
import 'package:propertier/App/Details/View/component/video_tour.dart';

import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/scrollableText.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/area_convert_extension.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/price_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:propertier/extensions/tags_remove_extension.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../Model/property.dart';
import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/App Ad Mob/app_banner_ads.dart';
import '../../../../Utils/border.dart';
import '../../../../Utils/info_tile.dart';

Widget detailTile(BuildContext context,
    {
    // required VideosModel videosModel,
    required DetailDataModel dataModel}) {
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
                title: dataModel.property!.title!,
                context: context,
                textStyle: textStyle(
                    color: AppColor.blackColor.withOpacity(0.7),
                    context: context,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
            appText(
              title: double.parse(dataModel.property!.price!).formatPrice(),
              context: context,
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
            scrollableText(
                context: context,
                textStyle: textStyle(
                    context: context,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColor.blackColor.withOpacity(0.8)),
                title: dataModel.property!.address!),
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
        appText(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            colorOpecity: 0.8,
            textAlign: TextAlign.justify,
            title: dataModel.property!.description!.parseHtmlString(),
            context: context),
        getHeight(context, 0.007),
        divider(context: context, color: const Color(0xffCFCFCF)),
        getHeight(context, 0.01),
        infoTile(
          context,
          title: context.local.vendor,
          subtitle: '',
          //  dataModel.property!.vendor,
        ),
        getHeight(context, 0.01),
        infoTile(context,
            title: context.local.type, subtitle: dataModel.property!.type!),
        getHeight(context, 0.01),
        infoTile(context,
            title: context.local.area,
            subtitle:
                "${dataModel.property!.area!.toDouble().convertArea(areaType: dataModel.property!.areaUnit ?? '').toString()} ${dataModel.property!.areaUnit ?? ''}",
            isShowIcon: true,
            icon: Constant.marla),
        getHeight(context, 0.007),
        divider(context: context, color: const Color(0xffCFCFCF)),
        getHeight(context, 0.007),
        detailsTitle(
          context: context,
          title: context.local.otherFeatures,
        ),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          direction: Axis.horizontal,
          children: List.generate(
            dataModel.features.length,
            (index) {
              return SizedBox(
                  width: context.getSize.width * 0.4,
                  child: Row(
                    children: [
                      Container(
                        height: 5,
                        width: 5,
                        decoration: BoxDecoration(
                          color: AppColor.blackColor.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Gap(5),
                      appText(
                          title:
                              " ${dataModel.features[index].featureId!.name!}",
                          colorOpecity: 0.7,
                          context: context),
                    ],
                  ));
            },
          ).toList(),
        ),
        getHeight(context, 0.007),
        dataModel.property!.video == null
            ? const SizedBox.shrink()
            : detailsTitle(context: context, title: context.local.videoTour),
        dataModel.property!.video == null
            ? const SizedBox.shrink()
            : getHeight(context, 0.005),
        dataModel.property!.video == null
            ? const SizedBox.shrink()
            : VideoTour(videoUrl: dataModel.property!.video ?? ''),
        getHeight(context, 0.01),
        divider(context: context, color: const Color(0xffCFCFCF)),
        getHeight(context, 0.015),
        SizedBox(
            height: 50,
            child: AppBannerAd()),
        detailsTitle(context: context, title: context.local.detailShortVideo),
        getHeight(context, 0.005),
        dataModel.property!.shortVideo != null
            ? DetailPageShortVideo(
                property: Property(
                    id: dataModel.property!.id,
                    shortVideo: dataModel.property!.shortVideo,
                    image: dataModel.property!.image,
                    title: dataModel.property!.title,
                    likes: dataModel.property!.likes,
                    description: dataModel.property!.description),
              )
            : const SizedBox(),
        getHeight(context, 0.010),
        divider(context: context, color: const Color(0xffCFCFCF)),
        getHeight(context, 0.015),
        detailsTitle(context: context, title: context.local.recommenderForYou),
        getHeight(context, 0.010),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dataModel.relatedProperties.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.offAndToNamed(AppRoutes.detailView, arguments: {
                    "id": dataModel.relatedProperties[index].id,
                    "user": "null"
                  });
                },
                child: recommandedTile(
                  context: context,
                  imageUrl: dataModel.relatedProperties[index].image ??
                      Constant.dummayImage,
                  title: dataModel.relatedProperties[index].title!,
                  subtitle: double.parse(dataModel
                          .relatedProperties[index].price!
                          .toString()
                          .replaceAll(',', ''))
                      .formatPrice(),
                ),
              );
            }),
        getHeight(context, 0.1)
      ],
    ),
  );
}

class DetailPageShortVideo extends StatefulWidget {
  final Property property;

  const DetailPageShortVideo({super.key, required this.property});

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
      print(e);
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
    return GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.shortVideoView, arguments: widget.property);
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
                          image: DecorationImage(
                              image: NetworkImage(widget.property.image ??
                                  Constant.dummayImage),
                              fit: BoxFit.cover)),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                    color: AppColor.buttonColor,
                  ))));
  }
}

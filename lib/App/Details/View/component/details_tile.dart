import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Details/Model/specific_property_model.dart';
import 'package:propertier/App/Details/View/component/details_title.dart';
import 'package:propertier/App/Details/View/component/recommendedTile.dart';

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
import 'package:propertier/extensions/tags_remove_extension.dart';

import '../../../../Model/property.dart';
import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/App Ad Mob/app_banner_ads.dart';
import '../../../../Utils/info_tile.dart';
import 'package:video_player/video_player.dart';


Widget detailTile(BuildContext context,
    {
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
            CustomText(
              title: double.parse(dataModel.property!.price!).formatPrice(),

              fontSize: 14,
              color: AppColor.greenColor,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
        getHeight(context, 0.006),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Icon(
        //       Ionicons.location,
        //       color: AppColor.buttonColor,
        //       size: context.getSize.width * 0.030,
        //     ),
        //     const Gap(5),
        //     scrollableText(
        //         context: context,
        //         textStyle: textStyle(
        //             context: context,
        //             fontSize: 12,
        //             fontWeight: FontWeight.w400,
        //             color: AppColor.blackColor.withOpacity(0.8)),
        //         title: dataModel.property!.address!),
        //   ],
        // ),
        getHeight(context, 0.0072),
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
            title: dataModel.property!.description!.parseHtmlString(),
        ),
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
            title: context.local.type, subtitle: dataModel.property!.propertyType!),
        getHeight(context, 0.01),
        infoTile(context,
            title: context.local.area,
            subtitle: "${dataModel.property!.area!.toDouble()} ${dataModel.property!.areaUnit ?? ''}",

            // subtitle:
            //     "${dataModel.property!.area!.toDouble().convertArea(
            //         areaType: dataModel.property!.areaUnit ?? '').toString()}"
            //     " ${dataModel.property!.areaUnit ?? ''}",
            isShowIcon: true,
            icon: Constant.marla),
        getHeight(context, 0.007),
        divider(context: context, color: const Color(0xffCFCFCF)),
        getHeight(context, 0.007),
        detailsTitle(
          context: context,
          title: context.local.other_features,),
        getHeight(context, 0.01),
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      Expanded(
                        child: CustomText(
                          textAlign: TextAlign.start,
                            title:
                                " ${dataModel.features[index].name!}",
                            colorOpecity: 0.7,
                        ),
                      ),
                    ],
                  ));
            },
          ).toList(),
        ),
        // getHeight(context, 0.018),
        // dataModel.property!.video == null
        //     ? const SizedBox.shrink()
        //     : detailsTitle(context: context, title: context.local.videoTour),
        // dataModel.property!.video == null
        //     ? const SizedBox.shrink()
        //     : getHeight(context, 0.005),
        // dataModel.property!.video == null || dataModel.property!. video!.isEmpty
        //     ? const Center(child: Text('No Video Available',style: TextStyle(
        //   fontSize: 20,
        //
        // ),),) : VideoTour(videoUrl: dataModel.property!.video ?? ''),
        getHeight(context, 0.01),
        divider(context: context, color: const Color(0xffCFCFCF)),
        getHeight(context, 0.015),
        const SizedBox(height: 50, child: AppBannerAd()),
        detailsTitle(context: context, title: context.local.detail_short_video),
        getHeight(context, 0.005),
        dataModel.property!.shortVideo != null
            ? DetailPageShortVideo(
                property: Property(
                    agent: dataModel.property!.agent,
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
        detailsTitle(context: context, title: context.local.recommender_for_you),
        getHeight(context, 0.010),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dataModel.relatedProperties.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.offAndToNamed(AppRoutes.propertyDetailView, arguments: {
                    "slug": dataModel.relatedProperties[index].slug,
                    "user": "null"
                  });},
                child: recommandedTile(
                  context: context,
                  imageUrl: dataModel.relatedProperties[index].image ??
                      Constant.dummyImage,
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
  late VideoPlayerController _videoController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    String videoUrl = widget.property.shortVideo ?? "";

    if (videoUrl.startsWith("http://")) {
      videoUrl = videoUrl.replaceFirst("http://", "https://");
    }
    _videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _videoController
              .pause(); // Stop playback to only show the first frame
        });
      }).catchError((error) {
        if (kDebugMode) {
          print("Error initializing video: $error");
        }
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.shortVideoView, arguments: widget.property);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          _isInitialized
              ? AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController), // Shows first frame
                )
              : Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: Colors.black12,
                  child: const Center(child: CircularProgressIndicator()),
                ),
          const Icon(Icons.play_circle_fill,
              size: 50, color: Colors.white), // Play button overlay
        ],
      ),
    );
  }
}
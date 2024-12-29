import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:propertier/Utils/App%20Ad%20Mob/app_interstitial_ads.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:propertier/extensions/tags_remove_extension.dart';
import 'package:video_player/video_player.dart';
import '../../../../../Model/property.dart';
import '../../../../../RoutesAndBindings/app_routes.dart';
import '../../../../../Utils/app_text.dart';
import '../../../../../Utils/height_width_box.dart';
import '../../../../../constant/colors.dart';
import '../../../../../constant/constant.dart';
import '../../../../Like And Unlike Service/like_unlike_services.dart';
import 'VideoScreenController.dart';


class VideoPlayerScreen extends StatelessWidget {
  final List<Property> properties;
  final Property property;
  VideoPlayerScreen({required this.properties, required this.property});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with the list of URLs
    final VideoScreenController controller = Get.put(VideoScreenController(properties, property));
    return Scaffold(
      // backgroundColor: AppColor.blackColor,
      body: Obx(() => PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          controller.onVideoChanged(index);
          print("*****:: $index ____ ${controller.properties.length}");
          print("*****: ${controller.activeVideoIndex}");
          if(index == controller.properties.length-1){
            loadAndShowInterstitialAd();
          }
        },
        children: controller.videoControllers.map((videoPlayerController){
          return GestureDetector(
            onTap: () => controller.pauseOrPlayVideoC(videoPlayerController),
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayerWidget(
                    videoController:
                    controller.videoControllers[controller.activeVideoIndex.value]),
                Positioned(
                  right: context.getSize.width * 0.05,
                  bottom: context.getSize.height * 0.2,
                  child: Obx(
                        () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        controller.isLiked.value.property != null
                            ? InkWell(
                            onTap: () async {

                              await LikeAndUnlikeServices()
                                  .likeService(
                                  context: context,
                                  agentId: GetStorage()
                                      .read("id")
                                      .toString(),
                                  propertyId: controller.properties[controller.activeVideoIndex.value].id!.toString())
                                  .then((value) {
                                controller.getSpecificPropertyDetail(controller.activeVideoIndex.value);

                              });
                            },
                            child: controller.isLiked.value.liked!
                                ? SvgPicture.asset(Constant.heartRedFill)
                                : SvgPicture.asset(
                              Constant.heartunFill,
                            ))
                            : const Gap(0),
                        appText(
                          title: controller.activeVideoIndex.value< controller.properties.length?controller.properties[controller.activeVideoIndex.value].likes.toString()??"":"",
                            // title: true
                            //     ? controller.isLiked.value.property != null
                            //     ? "${controller.isLiked.value.property!.likes! + controller.liked.value}"
                            //     : ""
                            //     : controller.properties[controller.activeVideoIndex.value].likes!.toString(),
                            context: context,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColor.white),
                        getHeight(context, 0.060),
                        InkWell(
                          onTap: (){
                            controller.ShareReel();
                          },
                          child: SvgPicture.asset(
                            Constant.shareRight,
                            width: context.getSize.width * 0.065,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: context.getSize.height * 0.1,
                  left: context.getSize.width * 0.05,
                  // right: context.getSize.width * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.offNamed(AppRoutes.detailView,
                              arguments: {
                                "id": controller.properties[controller.activeVideoIndex.value].id!,
                                "user": "null"
                              });
                          print("clicked detail");
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.white,
                                      width: 1,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.offNamed(
                                          AppRoutes
                                              .serviceProviderProfile,
                                          arguments: controller.properties[controller.activeVideoIndex.value].agent!.id
                                              .toString());
                                      print("clicked profile");
                                    },
                                    child: CircleAvatar(
                                      radius:
                                      context.getSize.width * 0.040,
                                      backgroundImage: NetworkImage(
                                          controller.activeVideoIndex.value< controller.properties.length?
                                          controller.properties[controller.activeVideoIndex.value].image ??
                                              Constant.dummayImage:Constant.dummayImage),
                                    ),
                                  ),
                                ),
                              ),
                              getWidth(context, 0.020),
                              SizedBox(
                                  width: context.getSize.width * 0.7,
                                  child: appText(
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      color: AppColor.white,
                                      title: controller.activeVideoIndex.value< controller.properties.length? controller.properties[controller.activeVideoIndex.value].title??" ":"",
                                      context: context))
                            ],
                          ),
                        ),
                      ),
                      // getHeight(context, 0.010),
                      appText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          context: context,
                          color: AppColor.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          title: controller.activeVideoIndex.value< controller.properties.length?controller.properties[controller.activeVideoIndex.value].description??""
                              .parseHtmlString():""),
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      )),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController videoController;

  const VideoPlayerWidget({required this.videoController});

  @override
  Widget build(BuildContext context) {
    return videoController.value.isInitialized
        ? AspectRatio(
      aspectRatio: videoController.value.aspectRatio,
      child: VideoPlayer(videoController),
    )
        : Center(child: CircularProgressIndicator());
  }
}

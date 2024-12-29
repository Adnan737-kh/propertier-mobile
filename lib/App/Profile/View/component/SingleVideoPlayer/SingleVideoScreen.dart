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
import 'SingleVideoScreenController.dart';


class SingleVideoScreen extends StatelessWidget {
  final List<Property> properties;
  final Property property;
  SingleVideoScreen({required this.properties, required this.property});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with the list of URLs
    final SingleVideoScreenController controller = Get.put(SingleVideoScreenController(properties, property));
    return Scaffold(
      // backgroundColor: AppColor.blackColor,
      body: Obx(() => PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          controller.onVideoChanged(index);
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
                VideoPlayerWidget(videoController: controller.videoControllers[controller.activeVideoIndex.value]),
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

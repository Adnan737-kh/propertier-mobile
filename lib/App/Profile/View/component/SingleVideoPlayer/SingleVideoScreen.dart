import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/App%20Ad%20Mob/app_interstitial_ads.dart';
import 'package:video_player/video_player.dart';
import '../../../../../Model/property.dart';

import 'SingleVideoScreenController.dart';


class SingleVideoScreen extends StatelessWidget {
  final List<Property> properties;
  final Property property;
  const SingleVideoScreen({super.key, required this.properties, required this.property});

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

  const VideoPlayerWidget({super.key, required this.videoController});

  @override
  Widget build(BuildContext context) {
    return videoController.value.isInitialized
        ? AspectRatio(
      aspectRatio: videoController.value.aspectRatio,
      child: VideoPlayer(videoController),
    )
        : const Center(child: CircularProgressIndicator());
  }
}

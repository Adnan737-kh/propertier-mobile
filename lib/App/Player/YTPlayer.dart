import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Player/YTPlayerController.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constant/colors.dart';


class YtPlayer extends StatelessWidget {
  const YtPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    YtPlayerController controller = Get.put(YtPlayerController());

    return Scaffold(
      backgroundColor: AppColor.blackColor,
      appBar: AppBar(
        backgroundColor: AppColor.blackColor,
      ),
      body: controller.videoUrl == null ||
          YoutubePlayer.convertUrlToId(controller.videoUrl!) == null
          ? const Center(child: Text("Invalid URL"))
          : GetBuilder<YtPlayerController>(
        builder: (_) => YoutubePlayer(
          controller: controller.youtubeController,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Player/YTPlayerController.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../constant/colors.dart';


class Ytplayer extends StatelessWidget {
  const Ytplayer({super.key});

  @override
  Widget build(BuildContext context) {
    Ytplayercontroller controller = Get.put(Ytplayercontroller());
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      appBar: AppBar(
        backgroundColor: AppColor.blackColor,
      ),
      body: Center(
        child: controller.videoUrl == null
            ? Center(child: Text("Invalid URL"))
            : YoutubePlayer(
          controller: controller.youtubeController,
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtPlayerController extends GetxController {
  late YoutubePlayerController youtubeController;
  String? videoUrl;

  @override
  void onInit() {
    super.onInit();
    videoUrl = Get.arguments as String?;
    String? videoId = YoutubePlayer.convertUrlToId(videoUrl??"");
    if (kDebugMode) {
      print("video id:$videoId");
    }

    if (videoId != null) {
      youtubeController = YoutubePlayerController(
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ), initialVideoId: videoId,
      );
    }
  }

  @override
  void onClose() {
    youtubeController.dispose();
    super.onClose();
  }
}

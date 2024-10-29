import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Ytplayercontroller extends GetxController {
  late YoutubePlayerController youtubeController;
  String? videoUrl;

  @override
  void onInit() {
    super.onInit();
    videoUrl = Get.arguments as String?;
    // String? videoId = _convertUrlToId("https://www.youtube.com/watch?v=eCHTDLxNHAA&t=11s");
    String? videoId = YoutubePlayer.convertUrlToId(videoUrl??"");
    print("video id:${videoId}");

    if (videoId != null) {
      youtubeController = YoutubePlayerController(
        flags: YoutubePlayerFlags(
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

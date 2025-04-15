import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoTourController extends GetxController {
  late YoutubePlayerController youtubeController;
  RxBool isPlaying = false.obs;
  RxBool isLoading = false.obs;
  RxString image = ''.obs;
  RxBool isInitialized = false.obs; // Make it observable

  final String videoUrl;

  VideoTourController(this.videoUrl);

  @override
  void onInit() {
    super.onInit();
    initializeVideo();
    getThumbnail();
  }

  void initializeVideo() {
    String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          enableCaption: true,
        ),
      )..addListener(() {
        isPlaying.value = youtubeController.value.isPlaying;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        isInitialized.value = true; // Ensure proper state update
      });
    } else {
      if (kDebugMode) {
        print("Error: Invalid Video URL or Extraction Failed");
      }
    }
  }

  Future<void> getThumbnail() async {
    if (image.isEmpty) {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      image.value =
      "https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(videoUrl)}/hqdefault.jpg";
      isLoading.value = false;
    }
  }

  void playVideo() {
    if (isInitialized.value) {
      youtubeController.play();
      isPlaying.value = true;
    } else {
      if (kDebugMode) {
        print("YouTube Player is not ready yet.");
      }
    }
  }

  @override
  void onClose() {
    youtubeController.dispose();
    super.onClose();
  }
}

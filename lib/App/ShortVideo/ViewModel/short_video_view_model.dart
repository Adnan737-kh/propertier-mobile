import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ShortVideoViewModel extends GetxController {
  final PageController pageController = PageController();
  late Rx<VideoPlayerController> currentController;
  late VideoPlayerController _previousController;
  late VideoPlayerController _nextController;
  // final Map<int, VideoPlayerController> _videoControllers = {};
  var previousNo = 0;

  Future<void> preloadController(bool isNext, String videoUrl) async {
    if (isNext) {
      VideoPlayerController controller =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await controller.initialize().then(
        (value) {
          _nextController = controller;
        },
      );
      // _nextController.initialize();
    } else {
      VideoPlayerController controller =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      controller.initialize().then(
        (value) {
          _previousController = controller;
        },
      );

      Future.delayed(const Duration(milliseconds: 100), () async {
        debugPrint("from Controller Previous Video => $videoUrl ");
      });
    }
  }

  Future<void> loadTheCurrentController(String videoUrl) async {
    VideoPlayerController controller =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    controller.initialize().then(
      (value) {
        currentController.value = controller;
        debugPrint("Controller is initialized  => $videoUrl ");
      },
    );
  }

  void updateControllers(bool isNext) {
    if (isNext) {
      currentController.value = _nextController;
    } else {
      currentController.value = _previousController;
    }
  }

  VideoPlayerController getController() {
    return currentController.value;
  }

  Future<void> loader() => currentController.value.initialize();
}

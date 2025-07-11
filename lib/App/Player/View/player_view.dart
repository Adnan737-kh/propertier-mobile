import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobs_player/mobs_player.dart';
import 'package:propertier/constant/colors.dart';

class PLayerView extends StatefulWidget {
  final videoUrl = Get.arguments;

  PLayerView({
    super.key,
  });

  @override
  _PLayerViewState createState() => _PLayerViewState();
}

class _PLayerViewState extends State<PLayerView> {
  late PodPlayerController _videoPlayerController;

  bool isPlaying = false;
  String? _image;
  @override
  void initState() {
    super.initState();
    _videoPlayerController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.videoUrl),
    )..initialise();
    // VideoPlayerController.networkUrl(
    //     Uri.parse( widget.videoUrl));


    // _chewieController = ChewieController(
    //   // useRootNavigator: false,
    //   // allowFullScreen: true,

    //   fullScreenByDefault: true,
    //   videoPlayerController: _videoPlayerController,
    //   // aspectRatio: _chewieController.maxScale,

    //   autoPlay: true,
    //   looping: false,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: PodVideoPlayer(
          onLoading: (val) {
            return const CircularProgressIndicator(
              color: AppColor.buttonColor,
            );
          },
          controller: _videoPlayerController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _videoPlayerController.pause();
  }
}

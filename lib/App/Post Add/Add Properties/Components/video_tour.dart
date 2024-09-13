import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobs_player/mobs_player.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

class AddVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String thumbnail;

  const AddVideoPlayer(
      {super.key, required this.videoUrl, required this.thumbnail});

  @override
  _AddVideoPlayerState createState() => _AddVideoPlayerState();
}

class _AddVideoPlayerState extends State<AddVideoPlayer> {
  late PodPlayerController _videoPlayerController;
  // late ChewieController _chewieController;
  final _isPlaying = false.obs;
  // final List<String> _image = [];
  // final bool _isLoading = false;
  late Future<void> _initializeVideoPlayerFuture;
  // late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    // getThumbnail();
    _videoPlayerController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.videoUrl),
    );
    // VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture = _videoPlayerController.initialise();
    // _videoPlayerController.initialize();
    _videoPlayerController.addListener(() {
      if (!_videoPlayerController.isVideoPlaying) {
        _isPlaying.value = false;
        print("ISPlaying $_isPlaying");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Container(
              // padding: const EdgeInsets.all(10),
              height: 160,
              width: context.getSize.width,
              decoration: _isPlaying.value == true
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.blackColor)
                  : BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.thumbnail),
                          fit: BoxFit.cover),
                      // color: AppColor.blackColor,
                      borderRadius: BorderRadius.circular(5)),
              child:
                  // VideoThumbnailTile(videoUrl: widget.videoUrl)
                  FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        return _isPlaying.value == false
                            ? Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Icon(Icons.share,
                                            color: AppColor.white,
                                            size:
                                                context.getSize.height * 0.030),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _videoPlayerController.play();
                                        setState(() {
                                          _isPlaying.value = true;
                                        });
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: border(
                                                  color: AppColor.buttonColor)),
                                          child: Icon(
                                            Icons.play_arrow,
                                            size: context.getSize.width * 0.040,
                                            color: AppColor.white,
                                          )),
                                    ),
                                    SizedBox(
                                        height: context.getSize.height * 0.030),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: GestureDetector(
                                    onTap: () {
                                      _videoPlayerController.pause();
                                      setState(() {
                                        _isPlaying.value = false;
                                      });
                                    },
                                    child: PodVideoPlayer(
                                      alwaysShowProgressBar: true,
                                      matchVideoAspectRatioToFrame: true,
                                      // matchFrameAspectRatioToVideo: true,
                                      onLoading: (context) =>
                                          const CircularProgressIndicator(
                                        color: AppColor.buttonColor,
                                      ),

                                      controller: _videoPlayerController,
                                    ),
                                  ),
                                ),
                              );
                      }),
            ),
          ],
        ));
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();

    // _chewieController.dispose();
  }
}

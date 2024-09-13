import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobs_player/mobs_player.dart';
import 'package:propertier/NetworkServices/network_services.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

class VideoTour extends StatefulWidget {
  final String videoUrl;

  const VideoTour({super.key, required this.videoUrl});

  @override
  _VideoTourState createState() => _VideoTourState();
}

class _VideoTourState extends State<VideoTour> {
  late PodPlayerController _videoPlayerController;
  // late ChewieController _chewieController;
  bool _isPlaying = false;
  String _image = '';
  bool _isLoading = false;
  late Future<void> _initializeVideoPlayerFuture;
  // late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    // getThumbnail();
    _videoPlayerController = PodPlayerController(
      podPlayerConfig: const PodPlayerConfig(autoPlay: false),
      playVideoFrom: PlayVideoFrom.youtube(widget.videoUrl),
    );
    // VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture = _videoPlayerController.initialise();
    // _videoPlayerController.initialize();
    _videoPlayerController.addListener(() {
      if (!_videoPlayerController.isVideoPlaying) {
        setState(() {
          _isPlaying = false;
        });

        print("ISPlaying $_isPlaying");
      } else {
        setState(() {
          _isPlaying = true;
        });
        print("ISPlaying $_isPlaying");
      }
    });
    getThumbnail();
  }

  getThumbnail() async {
    if (_image == '') {
      _isLoading = true;
      final data =
          await NetWorkServcies().generateThumbnail(video: widget.videoUrl);
      _image = data;
      _isLoading = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // padding: const EdgeInsets.all(10),
          height: context.isPhone ? 160 : 220,
          width: sizeWidth(1, 0.5),
          decoration: _isPlaying == true
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.blackColor)
              : BoxDecoration(
                  image: _image == ''
                      ? null
                      : DecorationImage(
                          image: NetworkImage(
                            _image,
                          ),
                          fit: BoxFit.cover),
                  color: AppColor.blackColor,
                  borderRadius: BorderRadius.circular(5)),
          child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                return _isPlaying == false
                    ? Center(
                        child: _isLoading == true
                            ? const CircularProgressIndicator(
                                color: AppColor.buttonColor,
                              )
                            : Column(
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
                                          size: context.getSize.height * 0.030),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _videoPlayerController.play();
                                      setState(() {
                                        _isPlaying = true;
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
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: GestureDetector(
                          onTap: () {
                            _videoPlayerController.pause();
                            setState(() {
                              _isPlaying = false;
                            });
                          },
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
              }),
        ),
        getHeight(context, 0.010),
      ],
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();

    // _chewieController.dispose();
  }
}

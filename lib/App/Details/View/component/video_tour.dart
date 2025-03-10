// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mobs_player/mobs_player.dart';
// import 'package:propertier/NetworkServices/network_services.dart';
// import 'package:propertier/Utils/border.dart';
// import 'package:propertier/Utils/height_width_box.dart';
// import 'package:propertier/constant/colors.dart';
// import 'package:propertier/extensions/size_extension.dart';
//
// class VideoTour extends StatefulWidget {
//   final String videoUrl;
//
//   const VideoTour({super.key, required this.videoUrl});
//
//   @override
//   _VideoTourState createState() => _VideoTourState();
// }
//
// class _VideoTourState extends State<VideoTour> {
//   late PodPlayerController _videoPlayerController;
//   bool _isPlaying = false;
//   String _image = '';
//   bool _isLoading = false;
//   late Future<void> _initializeVideoPlayerFuture;
//   @override
//   void initState() {
//     super.initState();
//     print("VideoTour youtube url ${widget.videoUrl}");
//     _videoPlayerController = PodPlayerController(
//       podPlayerConfig: const PodPlayerConfig(autoPlay: false),
//       playVideoFrom: PlayVideoFrom.youtube(widget.videoUrl),
//     );
//     _initializeVideoPlayerFuture = _videoPlayerController.initialise();
//     _videoPlayerController.addListener(() {
//       if (!_videoPlayerController.isVideoPlaying) {
//         setState(() {
//           _isPlaying = false;
//         });
//
//         print("ISPlaying $_isPlaying");
//       } else {
//         setState(() {
//           _isPlaying = true;
//         });
//         print("ISPlaying $_isPlaying");
//       }
//     });
//     getThumbnail();
//   }
//
//   getThumbnail() async {
//     if (_image == '') {
//       _isLoading = true;
//       final data =
//           await NetWorkServcies().generateThumbnail(video: widget.videoUrl);
//       _image = data;
//       _isLoading = false;
//     }
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("VideoTour youtube url ${widget.videoUrl}");
//
//     return Column(
//       children: [
//         Container(
//           // padding: const EdgeInsets.all(10),
//           height: context.isPhone ? 160 : 220,
//           width: sizeWidth(1, 0.5),
//           decoration: _isPlaying == true
//               ? BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: AppColor.blackColor)
//               : BoxDecoration(
//                   image: _image == ''
//                       ? null
//                       : DecorationImage(
//                           image: NetworkImage(
//                             _image,
//                           ),
//                           fit: BoxFit.cover),
//                   color: AppColor.blackColor,
//                   borderRadius: BorderRadius.circular(5)),
//           child: FutureBuilder(
//               future: _initializeVideoPlayerFuture,
//               builder: (context, snapshot) {
//                 return _isPlaying == false
//                     ? Center(
//                         child: _isLoading == true
//                             ? const CircularProgressIndicator(
//                                 color: AppColor.buttonColor,
//                               )
//                             : Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Align(
//                                     alignment: Alignment.topRight,
//                                     child: GestureDetector(
//                                       onTap: () {},
//                                       child: Icon(Icons.share,
//                                           color: AppColor.white,
//                                           size: context.getSize.height * 0.030),
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       _videoPlayerController.play();
//                                       setState(() {
//                                         _isPlaying = true;
//                                       });
//                                     },
//                                     child: Container(
//                                         padding: const EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             border: border(
//                                                 color: AppColor.buttonColor)),
//                                         child: Icon(
//                                           Icons.play_arrow,
//                                           size: context.getSize.width * 0.040,
//                                           color: AppColor.white,
//                                         )),
//                                   ),
//                                   SizedBox(
//                                       height: context.getSize.height * 0.030),
//                                 ],
//                               ),
//                       )
//                     : ClipRRect(
//                         borderRadius: BorderRadius.circular(5),
//                         child: GestureDetector(
//                           onTap: () {
//                             _videoPlayerController.pause();
//                             setState(() {
//                               _isPlaying = false;
//                             });
//                           },
//                           child: PodVideoPlayer(
//                             onLoading: (val) {
//                               return const CircularProgressIndicator(
//                                 color: AppColor.buttonColor,
//                               );
//                             },
//                             controller: _videoPlayerController,
//                           ),
//                         ),
//                       );
//               }),
//         ),
//         getHeight(context, 0.010),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     super.dispose();
//
//     // _chewieController.dispose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class VideoTour extends StatefulWidget {
//   final String videoUrl;
//
//   const VideoTour({super.key, required this.videoUrl});
//
//   @override
//   _VideoTourState createState() => _VideoTourState();
// }
//
// class _VideoTourState extends State<VideoTour> {
//   late YoutubePlayerController _youtubeController;
//   bool _isPlaying = false;
//   String _image = '';
//   bool _isLoading = false;
//   bool _isInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     print("VideoTour youtube url: ${widget.videoUrl}");
//
//     // Extract Video ID from URL
//     String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
//     print("Extracted Video ID: $videoId");
//
//     if (videoId != null) {
//       _youtubeController = YoutubePlayerController(
//         initialVideoId: videoId,
//         flags: const YoutubePlayerFlags(
//           autoPlay: false,
//           mute: false,
//           enableCaption: true,
//         ),
//       )..addListener(() {
//         setState(() {
//           _isPlaying = _youtubeController.value.isPlaying;
//         });
//       });
//
//       _isInitialized = true; // ✅ Mark as initialized
//     } else {
//       print("Error: Invalid Video URL or Extraction Failed");
//     }
//
//     getThumbnail();
//   }
//
//   Future<void> getThumbnail() async {
//     if (_image.isEmpty) {
//       setState(() {
//         _isLoading = true;
//       });
//
//       await Future.delayed(const Duration(seconds: 2));
//       _image = "https://img.youtube.com/vi/${YoutubePlayer.convertUrlToId(widget.videoUrl)}/hqdefault.jpg";
//
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 220,
//           width: MediaQuery.of(context).size.width * 0.9,
//           decoration: _isPlaying || _isInitialized
//               ? BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: Colors.black,
//           )
//               : BoxDecoration(
//             image: _image.isEmpty
//                 ? null
//                 : DecorationImage(
//               image: NetworkImage(_image),
//               fit: BoxFit.cover,
//             ),
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: _isInitialized
//               ? ClipRRect(
//             borderRadius: BorderRadius.circular(5),
//             child: YoutubePlayer(
//               controller: _youtubeController,
//               showVideoProgressIndicator: true,
//               progressIndicatorColor: Colors.amber,
//               progressColors: const ProgressBarColors(
//                 playedColor: Colors.amber,
//                 handleColor: Colors.amberAccent,
//               ),
//               onReady: () {
//                 print("YouTube Player is Ready");
//                 _youtubeController.addListener(() {
//                   setState(() {});
//                 });
//               },
//             ),
//           )
//               : Center(
//             child: _isLoading
//                 ? const CircularProgressIndicator(
//               color: Colors.red,
//             )
//                 : GestureDetector(
//               onTap: () {
//                 if (_isInitialized) {
//                   _youtubeController.play();
//                   setState(() {
//                     _isPlaying = true;
//                   });
//                 } else {
//                   print("YouTube Player is not ready yet.");
//                 }
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.red, width: 2),
//                 ),
//                 child: const Icon(
//                   Icons.play_arrow,
//                   size: 40,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     if (_isInitialized) {
//       _youtubeController.dispose();
//     }
//     super.dispose();
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'video_tour_controller.dart';

class VideoTour extends StatelessWidget {
  final String videoUrl;

  const VideoTour({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoTourController>(
      init: VideoTourController(videoUrl),
      builder: (controller) {
        return Column(
          children: [
            Container(
              height: 220,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: controller.isPlaying.value
                  ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
              )
                  : BoxDecoration(
                image: controller.image.isEmpty
                    ? null
                    : DecorationImage(
                  image: NetworkImage(controller.image.value),
                  fit: BoxFit.cover,
                ),
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Obx(() {
                if (!controller.isInitialized.value) {
                  return Center(
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.red)
                        : GestureDetector(
                      onTap: controller.playVideo,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }

                return ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: YoutubePlayer(
                    controller: controller.youtubeController,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.amber,
                    progressColors: const ProgressBarColors(
                      playedColor: Colors.amber,
                      handleColor: Colors.amberAccent,
                    ),
                    onReady: () {
                      if (kDebugMode) {
                        print("YouTube Player is Ready");
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Player/YTPlayer.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoThumbnailTile extends StatefulWidget {
  final String videoUrl;

  const VideoThumbnailTile({
    required this.videoUrl,
    super.key,
  });

  @override
  State<VideoThumbnailTile> createState() => _VideoThumbnailTileState();
}

class _VideoThumbnailTileState extends State<VideoThumbnailTile> {
  final bool _isLoading = false;

  Future<String> getThumbnail() async {
    if (widget.videoUrl.contains("youtu")) {
      final videoId = extractVideoIdFromUrl(widget.videoUrl);
      final yt = YoutubeExplode();

      final video = await yt.videos.get(videoId);
      yt.close();
      return video.thumbnails.mediumResUrl;
    }
    return '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(AppRoutes.playerView, arguments: widget.videoUrl);
        Get.to(Ytplayer(), arguments: widget.videoUrl);
      },
      child: FutureBuilder<String>(
          future: getThumbnail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                width: context.isPhone ? 290 : 320,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.buttonColor,
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                width: context.isPhone ? 290 : 320,
                // height: 200,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: AppColor.blackColor,
                    borderRadius: BorderRadius.circular(5),
                    image: snapshot.data!.isEmpty
                        ? null
                        : DecorationImage(
                            image: NetworkImage(
                              snapshot.data!,
                            ),
                            fit: BoxFit.cover)),
                child: _isLoading == false
                    ? const Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: AppColor.white,
                        ),
                      )
                    : const SizedBox(
                        width: 250,
                        child: Center(
                          child: CircularProgressIndicator(
                              color: AppColor.buttonColor),
                        ),
                      ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }

  String extractVideoIdFromUrl(String url) {
    print("MY URL is $url");
    RegExp regExp = RegExp(
        r'^.*(?:youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*');
    Match? match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    } else {
      // Invalid YouTube URL
      throw Exception('Invalid YouTube URL');
    }
  }
}

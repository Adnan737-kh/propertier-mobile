import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class NetWorkServcies {
//   Future<List<String>> generateThumbnails({required List<String> videosUrls}) async {
//   List<String> thumbnailPaths = [];

//   for (var video in videosUrls) {
//     List<String> createdPath = video.split('//');
//     List<String> nd = createdPath[1].split('/');
// print("Last ${nd.last}");
//     final String videoFileName = '${nd.last}';
//     final Directory tempDir = await getTemporaryDirectory();
//     final String videoPath = '${tempDir.path}/$videoFileName';

//     final http.Client client = http.Client();
//     final http.Response response = await client.get(Uri.parse(video));

//     if (response.statusCode == 200) {
//       final File videoFile = File(videoPath);
//       await videoFile.writeAsBytes(response.bodyBytes);

//       final thumbnailPath = await VideoThumbnail.thumbnailFile(
//         video: videoPath,
//         thumbnailPath: tempDir.path,
//         imageFormat: ImageFormat.PNG,
//         maxHeight: 100,
//         quality: 100,
//       );

//       thumbnailPaths.add(thumbnailPath!);
//     } else {
//       throw Exception('Failed to load video: $video');
//     }
//   }

//   return thumbnailPaths;
// }
  Future<String> generateThumbnail({
    required String video,
  }) async {
    final videoId = extractVideoIdFromUrl(video);
    final yt = YoutubeExplode();
    final videoData = await yt.videos.get(videoId);
    yt.close();
    return videoData.thumbnails.mediumResUrl;
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

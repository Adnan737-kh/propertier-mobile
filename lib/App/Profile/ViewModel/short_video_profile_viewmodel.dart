import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/ShortVideo/Model/short_video_model.dart';
import 'package:propertier/constant/constant.dart';
import 'package:video_player/video_player.dart';

class ShortVideoProfileViewModel extends GetxController {
  late final VideoPlayerController controller;
  List<ShortVideoModel> shortVideosList = <ShortVideoModel>[
    ShortVideoModel(
        videoUrl: "https://www.youtube.com/watch?v=Fla-zqY89V4",
        // Constant.dummyVideo,
        title: 'House For Sale',
        subtitle: 'This is Beautiful House',
        avatarUrl: Constant.dummyImage),
    ShortVideoModel(
        videoUrl: "https://www.youtube.com/watch?v=70AZK5fqSAE",
        // 'https://onlinetestcase.com/wp-content/uploads/2023/06/1MB.mp4',
        title: 'House For Sale',
        subtitle: 'This is Beautiful House',
        avatarUrl: Constant.dummyImage),
    ShortVideoModel(
        videoUrl: "https://www.youtube.com/watch?v=DgYINBY0Kn0",
        // "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_20mb.mp4",
        title: 'Villa For Sale',
        subtitle: 'This is Beautiful Villa',
        avatarUrl: 'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
  ];
  final PageController pageController = PageController();
  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    controller.dispose();
    super.dispose();
  }
}

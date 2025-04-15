import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/App/ShortVideo/View/component/short_video_player_widget.dart';
import 'package:propertier/App/ShortVideo/ViewModel/short_video_view_model.dart';
import 'package:propertier/constant/colors.dart';
import 'package:video_player/video_player.dart';
import '../../../Model/property.dart';

class ShortVideoView extends StatefulWidget {
  const ShortVideoView({super.key});

  @override
  State<ShortVideoView> createState() => _ShortVideoViewState();
}

class _ShortVideoViewState extends State<ShortVideoView> {
  final viewModel = Get.put(ShortVideoViewModel());

  List<Property> dataList = [];
  List<Property> newShortVideosList = [];
  Property? property;

  late VideoPlayerController currentController;
  late VideoPlayerController _previousController;
  late VideoPlayerController _nextController;

  var previousNo = 0;

  Future<void> preloadController(bool isNext, String? videoUrl) async {
    if (videoUrl == null || videoUrl.isEmpty) return;

    VideoPlayerController controller =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    await controller.initialize().then((_) {
      if (isNext) {
        _nextController = controller;
      } else {
        _previousController = controller;
      }
    });
  }

  Future<void> loadTheCurrentController(String? videoUrl) async {
    if (videoUrl == null || videoUrl.isEmpty) return;

    VideoPlayerController controller =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    await controller.initialize().then((_) {
      currentController = controller;
    });
  }

  void updateControllers(bool isNext) {
    currentController = isNext ? _nextController : _previousController;
  }

  @override
  void dispose() {
    currentController.dispose();
    _previousController.dispose();
    _nextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Get arguments safely
    property = Get.arguments as Property?;
    if (kDebugMode) {
      print('property is not n ${property?.video.toString()}');
    }
    if (property == null) {
      if (kDebugMode) {
        print('property is $property');
      }
      Get.back();
      return;
    }

    // Fetch home data safely
    dataList =
        Get.find<HomeViewModel>().homeModel.value.data?.shortVideos ?? [];

    if (property!.id != null) {
      dataList.removeWhere((element) => element.id == property!.id);
      newShortVideosList.addAll(dataList);
      newShortVideosList.insert(0, property!);
    }

    if (newShortVideosList.isNotEmpty) {
      loadTheCurrentController(newShortVideosList[0].shortVideo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: PageView.builder(
        onPageChanged: (val) {
          viewModel.pageController.animateToPage(
            val,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
          );

          if (viewModel.previousNo < val) {
            if (val + 1 < newShortVideosList.length) {
              preloadController(true, newShortVideosList[val + 1].shortVideo);
            }
            preloadController(true, newShortVideosList[val].shortVideo);
          } else {
            if (val - 1 >= 0) {
              preloadController(false, newShortVideosList[val - 1].shortVideo);
            }
            preloadController(true, newShortVideosList[val].shortVideo);
          }
        },
        controller: viewModel.pageController,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: newShortVideosList.length,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: viewModel.pageController,
            builder: (context, child) {
              double value = 1.0;
              if (viewModel.pageController.position.haveDimensions) {
                value = viewModel.pageController.page! - index;
                value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
              }
              return SizedBox(
                  height: Curves.easeOut.transform(value) * 200,
                  width: Curves.easeOut.transform(value) * 200,
                  child: child);
            },
            child: ShortVideoPLayerWidget(
              agentId: property!.agent!.id.toString(),
              controller: VideoPlayerController.networkUrl(
                Uri.parse(newShortVideosList[index].shortVideo ?? ''),
              ),
              index: index,
              property: newShortVideosList[index],
            ),
          );
        },
      ),
    );
  }
}

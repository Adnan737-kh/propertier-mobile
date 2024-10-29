import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/App/ShortVideo/View/component/short_video_player_widget.dart';
import 'package:propertier/App/ShortVideo/ViewModel/short_video_view_model.dart';
import 'package:propertier/constant/colors.dart';
import 'package:video_player/video_player.dart';
import '../../../Model/property.dart';


// ignore: must_be_immutable
class ShortVideoView extends StatefulWidget {
  const ShortVideoView({super.key});

  @override
  State<ShortVideoView> createState() => _ShortVideoViewState();
}

class _ShortVideoViewState extends State<ShortVideoView> {
  final viewModel = Get.put(ShortVideoViewModel());

  // final homeViewModel = Get.find<HomeViewModel>();
  List<Property> dataList = [];
  List<Property> newShortVideosList = [];
  Property property = Get.arguments;

  late VideoPlayerController currentController;
  late VideoPlayerController _previousController;
  late VideoPlayerController _nextController;
  late Future<void> loader;
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
        currentController = controller;
        debugPrint("Controller is initialized  => $videoUrl ");
      },
    );
  }

  void updateControllers(bool isNext) {
    if (isNext) {
      currentController = _nextController;
    } else {
      currentController = _previousController;
    }
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    currentController.dispose();
    _previousController.dispose();
    _nextController.dispose();
    super.dispose();
  }

  VideoPlayerController getController() {
    return currentController;
  }

  @override
  void initState() {
    super.initState();
    dataList = Get.find<HomeViewModel>().homeModel.value.data!.shortVideos;
    if (property.id != null) {
      dataList.removeWhere((element) => element.id == property.id);
      newShortVideosList.addAll(dataList);
      newShortVideosList.insert(0, property);
    }
    // currentController =
    //     VideoPlayerController.networkUrl(Uri.parse(property.shortVideo!));
    // loader = currentController.initialize();

    // currentController.addListener(() {
    //   debugPrint('Video Url Ok');
    // });
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
            debugPrint("This is from PageController :$val");
            if (viewModel.previousNo < val) {
              preloadController(true, newShortVideosList[val + 1].shortVideo!);
              preloadController(true, newShortVideosList[val].shortVideo!);
            } else {
              preloadController(false, newShortVideosList[val - 1].shortVideo!);
              preloadController(true, newShortVideosList[val].shortVideo!);
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
                  controller: VideoPlayerController.asset(''),
                  index: index,
                  property: newShortVideosList[index]),
              // child: FutureBuilder(
              //     future: loader,
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.done) {
              //         return ShortVideoPLayerWidget(
              //             controller: currentController,
              //             index: index,
              //             property: newShortVideosList[index]);
              //       } else {
              //         return const LoadingView();
              //       }
              //     })
              // : const LoadingView(),
            );
          }),
    );
  }
}

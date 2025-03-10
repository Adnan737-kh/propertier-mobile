import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobs_player/mobs_player.dart';
import 'package:propertier/App/Like%20And%20Unlike%20Service/Model/isLiked.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:propertier/extensions/tags_remove_extension.dart';
import 'package:video_player/video_player.dart';
import '../../../../Model/property.dart';
import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/height_width_box.dart';
import '../../../../constant/constant.dart';
import '../../../Like And Unlike Service/like_unlike_services.dart';

class ShortVideoPLayerWidget extends StatefulWidget {
  final Property property;
  final String agentId;
  final double positionTop;
  final int index;
  final double positionLeft;
  final double positionRight;
  final double fontSize;
  final bool isBackButton;
  final double titleWidth;
  final VideoPlayerController controller;
  final double positionBottom;

  const ShortVideoPLayerWidget({
    super.key,
    required this.property,
    required this.index,
    // required this.videoData,
    this.isBackButton = true,
    this.positionLeft = 0.030,
    this.positionRight = 0.030,
    this.fontSize = 20,
    this.titleWidth = 0.6,
    this.positionBottom = 0.090,
    this.positionTop = 0.060,
    required this.controller,
    required this.agentId,
  });

  @override
  _ShortVideoPLayerWidgetState createState() => _ShortVideoPLayerWidgetState();
}

class _ShortVideoPLayerWidgetState extends State<ShortVideoPLayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _showOverlay = true; // Initially show overlay


  var isLikeFree = false.obs;
  var isLiked = 0.obs;
  var propertyDetail = IsLiked().obs;
  getSpecificPropertyDetail() async {
    propertyDetail.value = await LikeAndUnlikeServices().getProperty(
        agentId: widget.property.agent!.id.toString(),
        propertyId: widget.property.id!.toString());
  }


  @override
  void initState() {
    print('agent id ShortVideoPLayerWidget ${widget.property.agent!.id.toString()}');
    try {
      String videoUrl = widget.property.shortVideo ?? "";

      if (videoUrl.startsWith("http://")) {
        videoUrl = videoUrl.replaceFirst("http://", "https://");
      }
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
      );

      _initializeVideoPlayerFuture = _controller.initialize().then((_) {
        _controller.play();
        setState(() {}); // Refresh UI after initialization
      }).catchError((error) {
        debugPrint("Video Player Error: $error");
      });
    } catch (e) {
      debugPrint("Exception in Video Player: $e");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
       return GestureDetector(
         behavior: HitTestBehavior.opaque,
         onTap: () {
           setState(() {
             print("Tapped! _showOverlay before: $_showOverlay");
             setState(() {
               _showOverlay = !_showOverlay;
             });
             print("Tapped! _showOverlay after: $_showOverlay");
           });
         },
         child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(

                    child: Chewie(
                      controller: ChewieController(
                          videoPlayerController: _controller,
                          aspectRatio: _controller.value.size.aspectRatio != 0.0
                              ? _controller.value.size.aspectRatio
                              : null,
                          autoPlay: true,
                          looping: true),
                    ),
                  ),
                  //!Back BTN
                  if (_showOverlay)
                  Positioned(
                      top: context.getSize.height * widget.positionTop,
                      left: context.getSize.width * widget.positionLeft,
                      right: context.getSize.width * widget.positionRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.isBackButton == true
                              ? GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.white,
                                    ),
                                    child: Icon(
                                      Icons.keyboard_arrow_left,
                                      size: context.getSize.width * 0.080,
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  width: context.getSize.width * 0.080,
                                ),
                        ],
                      )),
                  if (_showOverlay)
                  Positioned(
                          bottom: context.getSize.height * widget.positionBottom,
                          left: context.getSize.width * widget.positionLeft,
                          right: context.getSize.width * widget.positionRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.offNamed(AppRoutes.detailView, arguments: {
                                    "id": widget.property.id!,
                                    "user": "null"
                                  });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColor.white,
                                              width: 1,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.offNamed(
                                                  AppRoutes
                                                      .serviceProviderProfile,
                                                  arguments: widget.property.agent!.id.toString());
                                              debugPrint("clicked profile");
                                            },
                                            child: CircleAvatar(
                                              radius: context.getSize.width * 0.040,
                                              backgroundImage: NetworkImage(
                                                  widget.property.image ??
                                                      Constant.dummyImage),
                                            ),
                                          ),
                                        ),
                                      ),
                                      getWidth(context, 0.020),
                                      SizedBox(
                                          width: context.getSize.width * 0.7,
                                          child: appText(
                                              fontSize: 18,
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColor.white,
                                              fontWeight: FontWeight.bold,
                                              title: widget.property.title!,
                                              context: context))
                                    ],
                                  ),
                                ),
                              ),
                              getHeight(context, 0.010),
                              appText(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  context: context,
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: widget.fontSize - 4,
                                  title: widget.property.description!
                                      .parseHtmlString()),
                            ],
                          ),
                        ),
                  if (_showOverlay)
                  Positioned(
                    right: context.getSize.width * widget.positionRight,
                    bottom: context.getSize.height * 0.2,
                    child: Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          propertyDetail.value.property != null
                              ? InkWell(
                                  onTap: () async {
                                    await LikeAndUnlikeServices()
                                        .likeService(
                                            context: context,
                                            agentId: GetStorage()
                                                .read("id")
                                                .toString(),
                                            propertyId:
                                                widget.property.id!.toString())
                                        .then((value) {
                                      // getSpecificPropertyDetail();
                                      isLikeFree.value = true;
                                      if (propertyDetail.value.liked!) {
                                        isLiked.value -= 1;
                                        propertyDetail.value.liked = false;
                                      } else if (isLiked.value == 1) {
                                        isLiked.value -= 1;
                                        propertyDetail.value.liked = false;
                                      } else {
                                        propertyDetail.value.liked = true;

                                        isLiked.value += 1;
                                      }
                                    });
                                  },
                                  child: propertyDetail.value.liked!
                                      ? SvgPicture.asset(Constant.heartRedFill)
                                      : SvgPicture.asset(
                                          Constant.heartUnFill,
                                        ))
                              : const Gap(0),
                          appText(
                              title: widget.isBackButton
                                  ? propertyDetail.value.property != null
                                      ? "${propertyDetail.value.property!.likes! + isLiked.value}"
                                      : ""
                                  : widget.property.likes!.toString(),
                              context: context,
                              fontSize: widget.fontSize - 2,
                              fontWeight: FontWeight.w500,
                              color: AppColor.white),
                          getHeight(context, 0.060),
                          SvgPicture.asset(
                            Constant.shareRight,
                            width: context.getSize.width * 0.065,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
              // return const LoadingView();
            }
          }),
       );
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}

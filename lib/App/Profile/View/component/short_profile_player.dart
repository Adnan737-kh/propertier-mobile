import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobs_player/mobs_player.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:propertier/extensions/tags_remove_extension.dart';
import 'package:video_player/video_player.dart';
import '../../../../Model/property.dart';
import '../../../../RoutesAndBindings/app_routes.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/height_width_box.dart';
import '../../../../constant/constant.dart';
import '../../../Like And Unlike Service/Model/isLiked.dart';
import '../../../Like And Unlike Service/like_unlike_services.dart';

class ShortVideoPLayerWidget extends StatefulWidget {
  // final Property videoData;
  final Property property;
  final double positionTop;
  final int index;
  final double positionLeft;
  final double positionRight;
  final double fontSize;
  final bool isBackButton;
  final double titleWidth;
  final bool isUserSide;
  final double positionBottom;

  const ShortVideoPLayerWidget({
    super.key,
    required this.property,
    required this.index,
    // required this.videoData,
    this.isBackButton = true,
    this.isUserSide = true,
    this.positionLeft = 0.030,
    this.positionRight = 0.030,
    this.fontSize = 20,
    this.titleWidth = 0.6,
    this.positionBottom = 0.090,
    this.positionTop = 0.060,
  });

  @override
  _ShortVideoPLayerWidgetState createState() => _ShortVideoPLayerWidgetState();
}

class _ShortVideoPLayerWidgetState extends State<ShortVideoPLayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final bool _isFullScreen = false;
  final _isPlaying = false.obs;

  var isLikeFree = false.obs;
  var isLiked = 0.obs;
  final _password = "".obs;
  final _email = "".obs;

  var propertyDetail = IsLiked().obs;
  getSpecificPropertyDetail() async {
    propertyDetail.value = await LikeAndUnlikeServices().getProperty(
        agentId: widget.property.agent!.id.toString(),
        propertyId: widget.property.id!.toString());
  }

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        widget.property.shortVideo != null ? widget.property.shortVideo! : ""));
    _initializeVideoPlayerFuture = _controller.initialize();

    widget.isBackButton == false ? null : _controller.play();
    _isPlaying.value = widget.isBackButton;
    getSpecificPropertyDetail();
    _controller.addListener(() {
      print('Video Url Ok');
    });
    super.initState();
  }

  double opacityValue = 1;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            // onTap: widget.isBackButton == false
            //     ? () {
            //         if (_isPlaying.value) {
            //           _controller.pause();
            //           _controller.setLooping(false);
            //           _isPlaying.value = false;
            //         } else {
            //           _controller.play();
            //           _controller.setLooping(true);
            //           _isPlaying.value = true;
            //         }
            //       }
            //     : () {
            //         if (_isPlaying.value) {
            //           _controller.pause();
            //           _controller.setLooping(false);
            //           _isPlaying.value = false;
            //         } else {
            //           _controller.play();
            //           _controller.setLooping(true);
            //           _isPlaying.value = true;
            //         }
            //       },

            child: Obx(
              () => Stack(
                alignment: Alignment.center,
                children: [
                  Chewie(
                    controller: ChewieController(
                        videoPlayerController: _controller,
                        aspectRatio: _controller.value.size.aspectRatio,
                        autoPlay: true,
                        looping: true),
                  ),
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
                  !_isPlaying.value
                      ? const SizedBox.shrink()
                      : Positioned(
                          bottom: context.getSize.height * widget.positionBottom,
                          left: context.getSize.width * widget.positionLeft,
                          right: context.getSize.width * widget.positionRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.offNamed(AppRoutes.propertyDetailView,
                                      arguments: {
                                        "slug": widget.property.slug!,
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
                                                  arguments: widget
                                                      .property.agent!.id
                                                      .toString());
                                              print("clicked profile");
                                            },
                                            child: CircleAvatar(
                                              radius:
                                                  context.getSize.width * 0.040,
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
                                          child: CustomText(
                                              fontSize: 18,
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColor.white,
                                              fontWeight: FontWeight.bold,
                                              title: widget.property.title!,))
                                    ],
                                  ),
                                ),
                              ),
                              getHeight(context, 0.010),
                              CustomText(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.justify,
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: widget.fontSize - 4,
                                  title: widget.property.description!
                                      .parseHtmlString()),
                            ],
                          ),
                        ),
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
                          CustomText(
                              title: widget.isBackButton
                                  ? propertyDetail.value.property != null
                                      ? "${propertyDetail.value.property!.likes! + isLiked.value}"
                                      : ""
                                  : widget.property.likes!.toString(),
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
              ),
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColor.buttonColor,
          ));
        }
      },
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

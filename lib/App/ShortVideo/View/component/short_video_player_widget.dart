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
import '../../../../Utils/loading_view.dart';
import '../../../../constant/constant.dart';
import '../../../Like And Unlike Service/like_unlike_services.dart';

class ShortVideoPLayerWidget extends StatefulWidget {
  final Property property;
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
  });

  @override
  // ignore: library_private_types_in_public_api
  _ShortVideoPLayerWidgetState createState() => _ShortVideoPLayerWidgetState();
}

class _ShortVideoPLayerWidgetState extends State<ShortVideoPLayerWidget> {
  late VideoPlayerController _controller;
  // final homeViewModel = Get.find<HomeViewModel>();
  // final viewModel = Get.find<ShortVideoViewModel>();
  late Future<void> _initializeVideoPlayerFuture;
  // final bool _isFullScreen = false;
  final _isPlaying = false.obs;

  var isLikeFree = false.obs;
  var isLiked = 0.obs;
  var propertDetail = IsLiked().obs;
  getSpecificPropertyDetail() async {
    propertDetail.value = await LikeAndUnlikeServices().getProperty(
        agentId: widget.property.agent!.id.toString(),
        propertyId: widget.property.id!.toString());
  }

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.property.shortVideo!));
    _initializeVideoPlayerFuture = _controller.initialize();
    // widget.controller.play();
    _controller.play();
    getSpecificPropertyDetail();
    _controller.addListener(() {
      debugPrint('Video Url Ok');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "This is from PageController :asdasdasdasdasdasd///sdasd/as/d/sad/as/d");
    // return Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     Chewie(
    //       controller: ChewieController(
    //           videoPlayerController: widget.controller,
    //           aspectRatio: widget.controller.value.size.aspectRatio != 0.0
    //               ? widget.controller.value.size.aspectRatio
    //               : null,
    //           autoPlay: true,
    //           looping: true),
    //     ),
    //     //!Back BTN
    //     Positioned(
    //         top: context.getSize.height * widget.positionTop,
    //         left: context.getSize.width * widget.positionLeft,
    //         right: context.getSize.width * widget.positionRight,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             widget.isBackButton == true
    //                 ? GestureDetector(
    //                     onTap: () {
    //                       Get.back();
    //                     },
    //                     child: Container(
    //                       alignment: Alignment.center,
    //                       decoration: const BoxDecoration(
    //                         shape: BoxShape.circle,
    //                         color: AppColor.white,
    //                       ),
    //                       child: Icon(
    //                         Icons.keyboard_arrow_left,
    //                         size: context.getSize.width * 0.080,
    //                       ),
    //                     ),
    //                   )
    //                 : SizedBox(
    //                     width: context.getSize.width * 0.080,
    //                   ),
    //           ],
    //         )),

    //     !_isPlaying.value
    //         ? const SizedBox.shrink()
    //         : Positioned(
    //             bottom: context.getSize.height * widget.positionBottom,
    //             left: context.getSize.width * widget.positionLeft,
    //             right: context.getSize.width * widget.positionRight,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 InkWell(
    //                   onTap: () {
    //                     Get.offNamed(AppRoutes.detailView, arguments: {
    //                       "id": widget.property.id!,
    //                       "user": "null"
    //                     });
    //                   },
    //                   child: Padding(
    //                     padding:
    //                         const EdgeInsets.symmetric(vertical: 8.0),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: [
    //                         InkWell(
    //                           child: Container(
    //                             decoration: BoxDecoration(
    //                               border: Border.all(
    //                                 color: AppColor.white,
    //                                 width: 1,
    //                               ),
    //                               shape: BoxShape.circle,
    //                             ),
    //                             child: GestureDetector(
    //                               onTap: () {
    //                                 Get.offNamed(
    //                                     AppRoutes
    //                                         .serviceProviderProfile,
    //                                     arguments: widget
    //                                         .property.agent!.id
    //                                         .toString());
    //                                 // debugPrint("clicked profile");
    //                               },
    //                               child: CircleAvatar(
    //                                 radius:
    //                                     context.getSize.width * 0.040,
    //                                 backgroundImage: NetworkImage(
    //                                     widget.property.image ??
    //                                         Constant.dummayImage),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                         getWidth(context, 0.020),
    //                         SizedBox(
    //                             width: context.getSize.width * 0.7,
    //                             child: appText(
    //                                 fontSize: 18,
    //                                 overflow: TextOverflow.ellipsis,
    //                                 color: AppColor.white,
    //                                 fontWeight: FontWeight.bold,
    //                                 title: widget.property.title!,
    //                                 context: context))
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 getHeight(context, 0.010),
    //                 appText(
    //                     maxLines: 3,
    //                     overflow: TextOverflow.ellipsis,
    //                     textAlign: TextAlign.justify,
    //                     context: context,
    //                     color: AppColor.white,
    //                     fontWeight: FontWeight.w400,
    //                     fontSize: widget.fontSize - 4,
    //                     title: widget.property.description!
    //                         .parseHtmlString()),
    //               ],
    //             ),
    //           ),
    //     Positioned(
    //       right: context.getSize.width * widget.positionRight,
    //       bottom: context.getSize.height * 0.2,
    //       child: Obx(
    //         () => Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             propertDetail.value.property != null
    //                 ? InkWell(
    //                     onTap: () async {
    //                       await LikeAndUnlikeServices()
    //                           .likeService(
    //                               context: context,
    //                               agentId: GetStorage()
    //                                   .read("id")
    //                                   .toString(),
    //                               propertyId:
    //                                   widget.property.id!.toString())
    //                           .then((value) {
    //                         // getSpecificPropertyDetail();
    //                         isLikeFree.value = true;
    //                         if (propertDetail.value.liked!) {
    //                           isLiked.value -= 1;
    //                           propertDetail.value.liked = false;
    //                         } else if (isLiked.value == 1) {
    //                           isLiked.value -= 1;
    //                           propertDetail.value.liked = false;
    //                         } else {
    //                           propertDetail.value.liked = true;

    //                           isLiked.value += 1;
    //                         }
    //                       });
    //                     },
    //                     child: propertDetail.value.liked!
    //                         ? SvgPicture.asset(Constant.heartRedFill)
    //                         : SvgPicture.asset(
    //                             Constant.heartunFill,
    //                           ))
    //                 : const Gap(0),
    //             appText(
    //                 title: widget.isBackButton
    //                     ? propertDetail.value.property != null
    //                         ? "${propertDetail.value.property!.likes! + isLiked.value}"
    //                         : ""
    //                     : widget.property.likes!.toString(),
    //                 context: context,
    //                 fontSize: widget.fontSize - 2,
    //                 fontWeight: FontWeight.w500,
    //                 color: AppColor.white),
    //             getHeight(context, 0.060),
    //             SvgPicture.asset(
    //               Constant.shareRight,
    //               width: context.getSize.width * 0.065,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // )

    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Chewie(
                  controller: ChewieController(
                      videoPlayerController: _controller,
                      aspectRatio: _controller.value.size.aspectRatio != 0.0
                          ? _controller.value.size.aspectRatio
                          : null,
                      autoPlay: true,
                      looping: true),
                ),
                //!Back BTN
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
                                                arguments: widget
                                                    .property.agent!.id
                                                    .toString());
                                            // debugPrint("clicked profile");
                                          },
                                          child: CircleAvatar(
                                            radius:
                                                context.getSize.width * 0.040,
                                            backgroundImage: NetworkImage(
                                                widget.property.image ??
                                                    Constant.dummayImage),
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
                Positioned(
                  right: context.getSize.width * widget.positionRight,
                  bottom: context.getSize.height * 0.2,
                  child: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        propertDetail.value.property != null
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
                                    if (propertDetail.value.liked!) {
                                      isLiked.value -= 1;
                                      propertDetail.value.liked = false;
                                    } else if (isLiked.value == 1) {
                                      isLiked.value -= 1;
                                      propertDetail.value.liked = false;
                                    } else {
                                      propertDetail.value.liked = true;

                                      isLiked.value += 1;
                                    }
                                  });
                                },
                                child: propertDetail.value.liked!
                                    ? SvgPicture.asset(Constant.heartRedFill)
                                    : SvgPicture.asset(
                                        Constant.heartunFill,
                                      ))
                            : const Gap(0),
                        appText(
                            title: widget.isBackButton
                                ? propertDetail.value.property != null
                                    ? "${propertDetail.value.property!.likes! + isLiked.value}"
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
            return SizedBox();
            // return const LoadingView();
          }
        });
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

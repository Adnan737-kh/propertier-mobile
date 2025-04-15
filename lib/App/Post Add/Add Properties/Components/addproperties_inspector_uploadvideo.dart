import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/ViewModel/add_properties_view_model.dart';
import 'package:propertier/constant/toast.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/height_width_box.dart';
import '../../../../constant/colors.dart';
import '../Views/add_properties_view.dart';
import 'video_tour.dart';

class AddPropertyUploadVideoView extends StatefulWidget {
  const AddPropertyUploadVideoView({super.key});

  @override
  State<AddPropertyUploadVideoView> createState() =>
      _AddPropertyUploadVideoViewState();
}

class _AddPropertyUploadVideoViewState
    extends State<AddPropertyUploadVideoView> {
  // File? _pickedFrontImage;

  // late YoutubePlayerController _controller;

  var showVideo = false.obs;
  var getThumbnail = "";
  final controller = Get.put(AddPropertiesViewModel());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appText(
              title: "Upload Video",
              context: context,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            getHeight(context, 0.015),
            Obx(() => showVideo.value
                ? AddVideoPlayer(
                    videoUrl: controller.urlController.text,
                    thumbnail: getThumbnail,
                  )
                : const Gap(0)),
            getHeight(context, 0.015),
            CustomAddTextField(
              textEditingController: controller.urlController,
              border: InputBorder.none,
              labelText: "Past Video Url here",
              onChanged: (p0) {
                try {
                  // urlController.text="https://www.youtube.com/watch?v=WP0h7utvaUc&ab_channel=MitchKoko";
                  var videoId = YoutubePlayerController.convertUrlToId(
                      controller.urlController.text);

                  setState(() {
                    getThumbnail =
                        YoutubePlayerController.getThumbnail(videoId: videoId!);
                  });
                  // Get.snackbar("Succuss", videoId.toString());

                  showVideo.value = true;
                } catch (e) {
                  // Get.snackbar("error", e.toString());
                  toast(title: e.toString(), context: context);
                }
              },
              suffixIcon: IconButton(
                onPressed: () async {
                  try {
                    // urlController.text="https://www.youtube.com/watch?v=WP0h7utvaUc&ab_channel=MitchKoko";
                    var videoId = YoutubePlayerController.convertUrlToId(
                        controller.urlController.text);

                    setState(() {
                      getThumbnail = YoutubePlayerController.getThumbnail(
                          videoId: videoId!);
                    });
                    // Get.snackbar("Succuss", videoId.toString());

                    showVideo.value = true;
                  } catch (e) {
                    // Get.snackbar("error", e.toString());
                    toast(title: e.toString(), context: context);
                  }
                },
                icon: const Icon(Icons.check),
              ),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please Enter Url';
              //   }
              //   return null;
              // },
            ),
            getHeight(context, 0.015),
          ],
        ),
      ),
    );
  }
}

Widget iDUploadTile(
    {required bool isLoading, required String image, Function()? onTap}) {
  var context = Get.context!;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 170,
      width: context.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColor.darkGreyColor.withOpacity(.25),
              blurRadius: 4,
              offset: const Offset(-1, 1),
            )
          ],
          color: AppColor.darkGreyColor.withOpacity(.3)),
      child: image == ''
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                    size: 38,
                  ),
                  appText(
                      title: "Upload Video Less Then 25MB",
                      context: context,
                      fontSize: 16,
                      color: AppColor.white,
                      fontWeight: FontWeight.bold),
                ],
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(image),
                fit: BoxFit.fill,
              )),
    ),
  );
}

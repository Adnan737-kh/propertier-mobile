import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Post%20Add/Add%20Properties/ViewModel/add_properties_view_model.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Utils/app_text.dart';

import '../../../../Utils/height_width_box.dart';

class AddPropertyUploadShortVideoView extends StatefulWidget {
  const AddPropertyUploadShortVideoView({super.key});

  @override
  State<AddPropertyUploadShortVideoView> createState() =>
      _AddPropertyUploadShortVideoViewState();
}

class _AddPropertyUploadShortVideoViewState
    extends State<AddPropertyUploadShortVideoView> {
  final TextEditingController urlController = TextEditingController();
  // late YoutubePlayerController _controller;

  var showVideo = false.obs;
  var getThumbnail = "";
  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    // _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    // _controller.dispose();
    urlController.dispose();
    super.dispose();
  }

  final viewModel = Get.put(AddPropertiesViewModel());
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appText(
              title: "Upload Short Video",
              context: context,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            getHeight(context, 0.015),
            //  VideoTour(videoUrl: urlController.text),
            // Obx(() =>
            // showVideo.value?
            // AddVideoPlayer(videoUrl: urlController.text, thumbnail: getThumbnail,):const Gap(0)
            // ),
            getHeight(context, 0.015),
            GestureDetector(
              onTap: () {
                viewModel.pickVideo();
              },
              child: Obx(() => Container(
                    height: context.getSize.height * 0.50,
                    width: context.getSize.width,
                    decoration: BoxDecoration(
                      image: viewModel.thumbNailPath == ''
                          ? null
                          : DecorationImage(
                              image: FileImage(File(viewModel.thumbNailPath)),
                              fit: BoxFit.cover),
                      color: viewModel.thumbNailPath != ''
                          ? null
                          : Colors.grey.withOpacity(.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: viewModel.thumbNailPath == ''
                        ? const Icon(Icons.add)
                        : null,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

///

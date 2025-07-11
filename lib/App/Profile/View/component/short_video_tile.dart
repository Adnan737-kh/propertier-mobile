import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:propertier/App/Profile/View/component/ShortVideoPlayer/VideoPlayerScreen.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../Model/property.dart';
import '../../../../RoutesAndBindings/app_routes.dart';

class ProfileShortVideosTile extends StatelessWidget {
  final List<Property> listOfProperties;
  const ProfileShortVideosTile({super.key, required this.listOfProperties});

  @override
  Widget build(BuildContext context) {
    List<Property> newShortVideoList = listOfProperties
        .where((element) => element.shortVideo != null)
        .toList();

    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.shortVideoProfileView, arguments: {
              "ListOfVideos": newShortVideoList,
              "property": newShortVideoList[0]
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomText(
                    title: context.local.short_videos,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  const Icon(
                    Ionicons.play_circle_outline,
                    size: 20,
                  )
                ],
              ),
              CustomText(
                title: context.local.view_more,
                color: AppColor.greenColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        getHeight(context, 0.011),
        newShortVideoList.isEmpty
            ? Text(context.local.no_data)
            : SizedBox(
                height: context.getSize.height * 0.33,
                width: context.getSize.width,
                child: ListView.builder(
                  // reverse: true,
                  addAutomaticKeepAlives: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(0),
                  cacheExtent: 500000,
                  physics: const BouncingScrollPhysics(),
                  itemCount: newShortVideoList.isNotEmpty
                      ? newShortVideoList.length <= 5
                          ? newShortVideoList.length
                          : 5
                      : 0,
                  itemBuilder: (context, index) {
                    return newShortVideoList[index].shortVideo != null
                        ? GestureDetector(
                            onTap: () async {
                              Get.to(VideoPlayerScreen(
                                properties: newShortVideoList,
                                property: newShortVideoList[index],
                              ));
                            },
                            child: FutureBuilder<String?>(
                              future:
                                  newShortVideoList[index].shortVideo != null
                                      ? generateThumbnail(
                                          newShortVideoList[index].shortVideo!,
                                        )
                                      : null,
                              builder: (context, snapshot) {
                                return SizedBox(
                                    width: context.getSize.width * 0.4,
                                    child: snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.data != null
                                        ? Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    context.getSize.width *
                                                        0.015,
                                                vertical: 5),
                                            // height: context.getSize.height / 2,
                                            width: context.getSize.width / 4,
                                            padding: const EdgeInsets.all(15),
                                            alignment: Alignment.bottomCenter,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: FileImage(
                                                      File(snapshot.data!)),
                                                  fit: BoxFit.cover,
                                                )),
                                            child: Container(
                                              height: context.getSize.height *
                                                  0.043,
                                              width:
                                                  context.getSize.width * 0.086,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: border(
                                                      color:
                                                          AppColor.buttonColor,
                                                      width: 1),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          newShortVideoList[
                                                                      index]
                                                                  .image ??
                                                              Constant
                                                                  .dummyImage),
                                                      fit: BoxFit.cover)),
                                            ),
                                          )
                                        : snapshot.error != null
                                            ? Text(context.local
                                                .error_generating_thumbnail)
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                color: AppColor.buttonColor,
                                              )));
                              },
                            ),
                          )
                        : const SizedBox();
                  },
                  // height: context.getSize.height * 0.325,
                ))
      ],
    );
  }

  Future<String?> generateThumbnail(String videoPath) async {
    try {
      final String? thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128, // specify the width of the thumbnail, can be adjusted
        quality: 75, // specify the quality of the thumbnail, can be adjusted
      );
      return thumbnailPath;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}

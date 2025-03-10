import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:propertier/App/Home/View/home_view.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../Model/property.dart';
import '../../../../Utils/thumbnail_tile.dart';
import '../../../Player/YTPlayer.dart';
// import '../../../Profile/PropertiesAndShortVideo/ViewModel/properties_and_Video_view_model.dart';

// ignore: must_be_immutable
class HomeVideosTile extends StatelessWidget {
  HomeViewModel viewModel;
  HomeVideosTile({super.key, required this.viewModel});
  // final propertiesVideoShortVideoVM = Get.put(PropertiesAndVideoViewModel());
  @override
  Widget build(BuildContext context) {
    List<Property> shortVideos =
        viewModel.homeModel.value.data!.propertiesWithVideos;

    return Obx(() {
      List<Property> newShortVideoList = [];
      if (viewModel.isSale == true) {
        newShortVideoList = shortVideos
            .where((element) => element.purpose!.toLowerCase() == 'sale')
            .toList();
      } else {
        newShortVideoList = shortVideos
            .where((element) => element.purpose!.toLowerCase() == 'rent')
            .toList();
      }
      return Column(
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.getSize.width * 0.036),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appText(
                  title: context.local.videos,
                  context: context,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.propertiesAndVideoView, arguments: {
                      "PropertyEnum": PropertiesAndVideoEnum.video,
                      "PropertiesType": ""
                    });
                  },
                  child: appText(
                    title: context.local.viewMore,
                    context: context,
                    color: AppColor.greenColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          getHeight(context, 0.011),
          SizedBox(
            height: context.isPhone ? 200 : 260,
            width: context.getSize.width,
            child: newShortVideoList.isEmpty
                ? Center(
                    child:
                        appText(title: 'No Data Avaliable', context: context),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    cacheExtent: 500000,
                    physics: const BouncingScrollPhysics(),
                    itemCount: newShortVideoList.isNotEmpty
                        ? newShortVideoList.length
                        : 0,
                    itemBuilder: (context, index) {
                      Property property = newShortVideoList[index];
                      return property.video == null &&
                              !property.video!.contains("youtu")
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () {
                                // Get.toNamed(AppRoutes.playerView,
                                //     arguments: property.video);
                                Get.to(const Ytplayer(), arguments: property.video);
                              },
                              child: VideoThumbnailTile(
                                videoUrl: property.video!,
                              ),
                            );
                      // });
                    }),
          )
        ],
      );
    });
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
      print(e);
      return null;
    }
  }
}

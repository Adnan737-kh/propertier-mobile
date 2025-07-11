import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Home/View/home_view.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Model/property.dart';
import '../../../../Utils/thumbnail_tile.dart';
import '../../../Player/YTPlayer.dart';

class HomeVideosTile extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeVideosTile({super.key, required this.viewModel});
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
                CustomText(
                  title: context.local.videos,
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
                  child: CustomText(
                    title: context.local.view_more,
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
                        CustomText(title: context.local.no_data_available),
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
                      return property.video == null ||
                              property.video!.isEmpty ||
                              !property.video!.contains("youtu")
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () {
                                Get.to(const YtPlayer(),
                                    arguments: property.video);
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
}
// Future<String?> generateThumbnail(String videoPath) async {
//   try {
//     final String? thumbnailPath = await VideoThumbnail.thumbnailFile(
//       video: videoPath,
//       thumbnailPath: (await getTemporaryDirectory()).path,
//       imageFormat: ImageFormat.JPEG,
//       maxWidth: 128, // specify the width of the thumbnail, can be adjusted
//       quality: 75, // specify the quality of the thumbnail, can be adjusted
//     );
//     return thumbnailPath;
//   } catch (e) {
//     if (kDebugMode) {
//       print(e);
//     }
//     return null;
//   }
// }

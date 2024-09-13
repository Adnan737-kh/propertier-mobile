// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:get/get.dart';

// import 'package:propertier/App/PropertiesAndShortVideo/Model/videos_model.dart';
// import 'package:propertier/App/VideoDetail/View/component/video_detail_tile.dart';
// import 'package:propertier/RoutesAndBindings/app_routes.dart';

// import 'package:propertier/Utils/details_view_appbar.dart';

// import 'package:propertier/Utils/height_width_box.dart';
// import 'package:propertier/App/VideoDetail/ViewModel/video_detail_view_model.dart';

// import 'package:propertier/Utils/talk_to_seller_tile.dart';

// import 'package:propertier/constant/colors.dart';

// import 'package:propertier/extensions/size_extension.dart';

// class VideoDetailView extends StatelessWidget {
//   VideoDetailView({super.key});
//   VideosModel videosModel = Get.arguments;
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: Brightness.dark,
//           systemNavigationBarIconBrightness: Brightness.dark,
//           systemNavigationBarColor: AppColor.backgroundColor),
//     );
//     return GetX<VideoDetailViewModel>(
//         init: VideoDetailViewModel(),
//         initState: (viewModel) {
//           viewModel.controller!.generateThumbnailImage(
//               videosModel.videoDetailModel.videosUrlList);
//         },
//         builder: (viewModel) {
//           return Scaffold(
//               body: Column(
//             children: [
//               detailsViewAppBar(
//                 context,
//                 viewModel: viewModel,
//                 favoriteCallBack: () {},
//                 playCallBack: () {
//                   Get.toNamed(AppRoutes.playerView,
//                       arguments: videosModel.videoDetailModel
//                           .videosUrlList[viewModel.selectedVideoIndex]);
//                 },
//               ),
//               getHeight(context, 0.015),
//               ListView(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: context.getSize.width * 0.090),
//                 shrinkWrap: true,
//                 physics: const BouncingScrollPhysics(),
//                 children: [
//                   videoDetailTile(context,videosModel:videosModel),
//                   getHeight(context, 0.030),
//                   talkToSellerTile(context,price:"12000",date:"/Mpnth",talkToSellerCallBack: (){}),
//                 ],
//               )
//             ],
//           ));
//         });
//   }

// }

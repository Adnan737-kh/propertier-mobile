// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:propertier/App/PropertiesAndShortVideo/Model/videos_model.dart';
// import 'package:propertier/App/PropertiesAndShortVideo/ViewModel/properties_and_Video_view_model.dart';
// import 'package:propertier/RoutesAndBindings/app_routes.dart';
// import 'package:propertier/Utils/app_text.dart';
// import 'package:propertier/Utils/box_shadow.dart';
// import 'package:propertier/Utils/height_width_box.dart';
// import 'package:propertier/Utils/scrollableText.dart';
// import 'package:propertier/Utils/textStyle.dart';
// import 'package:propertier/Utils/text_botton.dart';
// import 'package:propertier/constant/colors.dart';
// import 'package:propertier/constant/constant.dart';
// import 'package:propertier/extensions/localization_extension.dart';
// import 'package:propertier/extensions/size_extension.dart';

// propertiesShortDetailDialog(
//     {required BuildContext context,
//     required VideosModel videosModel,
//     required PropertiesAndVideoViewModel viewModel}) {
//   return showDialog(
//       // barrierColor: Colors.transparent,
//       barrierDismissible: true,
//       useRootNavigator: false,
//       context: context,
//       builder: (context) {
//         return Dialog(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             insetPadding: EdgeInsets.zero,
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             child: Container(
//               width: context.getSize.width * 0.8,
//               padding: EdgeInsets.only(bottom: context.getSize.height * 0.020),
//               decoration: BoxDecoration(
//                   color: AppColor.white,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [boxShadow()]),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: context.getSize.height * 0.3,
//                     width: context.getSize.width * 0.8,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         PageView(
//                           controller: viewModel.pageController,
//                           onPageChanged: (val) {
//                             viewModel.changeShortDetailIndex(val);
//                           },
//                           children: List.generate(
//                               videosModel.videoDetailModel.imageUrlList.length,
//                               (index) => Container(
//                                     alignment: Alignment.center,
//                                     decoration: BoxDecoration(
//                                         borderRadius: const BorderRadius.only(
//                                             topRight: Radius.circular(10),
//                                             topLeft: Radius.circular(10)),
//                                         image: DecorationImage(
//                                           image: NetworkImage(videosModel
//                                               .videoDetailModel
//                                               .imageUrlList[index]),
//                                           fit: BoxFit.fill,
//                                         )),
//                                   )),
//                         ),
//                         Positioned(
//                           right: 10,
//                           top: 10,
//                           child: GestureDetector(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: context.getSize.width * 0.010,
//                                   vertical: context.getSize.height * 0.005),
//                               decoration: BoxDecoration(
//                                   color: AppColor.white.withOpacity(0.5),
//                                   shape: BoxShape.circle),
//                               child: Icon(Icons.close),
//                             ),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Obx(
//                               () => viewModel.onShortDetailChangeIndex == 0
//                                   ? const SizedBox.shrink()
//                                   : GestureDetector(
//                                       onTap: () {
//                                         if (viewModel.onShortDetailChangeIndex >
//                                             0) {
//                                           viewModel.pageController.previousPage(
//                                             duration:
//                                                 Duration(milliseconds: 300),
//                                             curve: Curves.ease,
//                                           );
//                                         }
//                                       },
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal:
//                                                 context.getSize.width * 0.01,
//                                             vertical:
//                                                 context.getSize.height * 0.005),
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                           color:
//                                               AppColor.white.withOpacity(0.5),
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child:
//                                             Icon((Icons.keyboard_arrow_left)),
//                                       ),
//                                     ),
//                             ),
//                             Obx(
//                               () => viewModel.onShortDetailChangeIndex ==
//                                       videosModel.videoDetailModel.imageUrlList
//                                               .length -
//                                           1
//                                   ? const SizedBox.shrink()
//                                   : GestureDetector(
//                                       onTap: () {
//                                         if (viewModel.onShortDetailChangeIndex <
//                                             videosModel.videoDetailModel
//                                                 .imageUrlList.length) {
//                                           // Change 2 to the last page index
//                                           viewModel.pageController.nextPage(
//                                             duration:
//                                                 Duration(milliseconds: 300),
//                                             curve: Curves.ease,
//                                           );
//                                         }
//                                       },
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal:
//                                                 context.getSize.width * 0.020,
//                                             vertical:
//                                                 context.getSize.height * 0.010),
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                           color:
//                                               AppColor.white.withOpacity(0.5),
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child:
//                                             Icon((Icons.keyboard_arrow_right)),
//                                       ),
//                                     ),
//                             ),
//                           ],
//                         ).paddingSymmetric(
//                             horizontal: context.getSize.width * 0.01),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: context.getSize.width * 0.020),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         getHeight(context, 0.015),
//                         scrollableText(
//                             context: context,
//                             textStyle: textStyle(
//                                 context: context,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500),
//                             title: videosModel.title),
//                         getHeight(context, 0.008),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             appText(
//                                 title: '${context.local.price}: ',
//                                 context: context,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14),
//                             scrollableText(
//                                 context: context,
//                                 textStyle: textStyle(
//                                     context: context,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400),
//                                 title: videosModel.price)
//                           ],
//                         ),
//                         getHeight(context, 0.008),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             appText(
//                                 title: '${context.local.location}: ',
//                                 context: context,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14),
//                             scrollableText(
//                                 context: context,
//                                 textStyle: textStyle(
//                                     context: context,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400),
//                                 title: videosModel.location)
//                           ],
//                         ),
//                         getHeight(context, 0.008),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             appText(
//                                 title: '${context.local.area}: ',
//                                 context: context,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14),
//                             getWidth(context, 0.010),
//                             Image.asset(Constant.marla,
//                                 width: context.getSize.height * 0.030),
//                             getWidth(context, 0.010),
//                             scrollableText(
//                                 context: context,
//                                 textStyle: textStyle(
//                                     context: context,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400),
//                                 title: videosModel.videoDetailModel.area)
//                           ],
//                         ),
//                         getHeight(context, 0.008),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             appText(
//                                 title: '${context.local.type}: ',
//                                 context: context,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 14),
//                             scrollableText(
//                                 context: context,
//                                 textStyle: textStyle(
//                                     context: context,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400),
//                                 title: videosModel.videoDetailModel.type)
//                           ],
//                         ),
//                         getHeight(context, 0.015),
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: context.getSize.width * 0.040),
//                           child: Column(
//                             children: [
//                               textButton(
//                                   context: context,
//                                   title: context.local.seeProfile,
//                                   onClick: () {
//                                     Get.back();
//                                     Get.toNamed(AppRoutes.profileView);
//                                   },
//                                   height: 0.040,
//                                   buttonColor: AppColor.buttonColor,
//                                   textFontSize: 15),
//                               getHeight(context, 0.010),
//                               textButton(
//                                   context: context,
//                                   title: context.local.moreDetail,
//                                   onClick: () {
//                                     Get.back();
//                                     Get.toNamed(AppRoutes.detailView,
//                                         arguments: videosModel);
//                                   },
//                                   height: 0.040,
//                                   textColor: AppColor.buttonColor,
//                                   buttonColor: AppColor.white,
//                                   borderColor: AppColor.buttonColor,
//                                   textFontSize: 15),
//                               getHeight(context, 0.010),
//                               textButton(
//                                   context: context,
//                                   title: context.local.talk,
//                                   onClick: () {},
//                                   height: 0.040,
//                                   textColor: AppColor.buttonColor,
//                                   buttonColor: AppColor.white,
//                                   borderColor: AppColor.buttonColor,
//                                   textFontSize: 15),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ));
//       });
// }

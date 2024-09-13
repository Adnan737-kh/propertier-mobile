//  import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:propertier/App/PropertiesAndShortVideo/Model/videos_model.dart';
// import 'package:propertier/Utils/app_text.dart';
// import 'package:propertier/Utils/box_shadow.dart';
// import 'package:propertier/Utils/divider.dart';
// import 'package:propertier/Utils/height_width_box.dart';
// import 'package:propertier/Utils/info_tile.dart';
// import 'package:propertier/Utils/scrollableText.dart';
// import 'package:propertier/Utils/textStyle.dart';
// import 'package:propertier/constant/colors.dart';
// import 'package:propertier/constant/constant.dart';
// import 'package:propertier/extensions/localization_extension.dart';
// import 'package:propertier/extensions/size_extension.dart';

// Widget videoDetailTile(
//     BuildContext context,
//    { required VideosModel videosModel,}
//   ) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           horizontal: context.getSize.width * 0.010,
//           vertical: context.getSize.height * 0.005),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           color: AppColor.white,
//           boxShadow: [boxShadow()]),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               scrollableText(
//                   width: 0.55,
//                   title: videosModel.title,
//                   context: context,
//                   textStyle: textStyle(
//                       color: AppColor.blackColor.withOpacity(0.7),
//                       context: context,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500)),
//               appText(
//                 title: videosModel.price,
//                 context: context,
//                 fontSize: 10,
//                 color: AppColor.greenColor,
//                 fontWeight: FontWeight.w700,
//               ),
//             ],
//           ),
//           getHeight(context, 0.006),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Icon(
//                 Ionicons.location,
//                 color: AppColor.buttonColor,
//                 size: context.getSize.width * 0.030,
//               ),
//               scrollableText(
//                   context: context,
//                   textStyle: textStyle(
//                       context: context,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: AppColor.blackColor.withOpacity(0.8)),
//                   title: videosModel.location),
//             ],
//           ),
//           getHeight(context, 0.0072),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(
//                 videosModel.features.length,
//                 (index) => Row(
//                       children: [
//                         Icon(
//                           videosModel.features[index].icon,
//                           size: context.getSize.width * 0.040,
//                         ),
//                         getWidth(context, 0.005),
//                         appText(
//                             title: videosModel.features[index].quantity,
//                             context: context,
//                             fontSize: 8.852,
//                             fontWeight: FontWeight.w400)
//                       ],
//                     )),
//           ),
//           getHeight(context, 0.007),
//           divider(context: context, color: Color(0xffCFCFCF)),
//           getHeight(context, 0.015),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: appText(
//                 textAlign: TextAlign.left,
//                 colorOpecity: 0.7,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 title: context.local.description,
//                 context: context),
//           ),
//           getHeight(context, 0.002),
//           appText(
//               fontSize: 10,
//               fontWeight: FontWeight.w400,
//               colorOpecity: 0.8,
//               textAlign: TextAlign.left,
//               title: videosModel.videoDetailModel.description,
//               context: context),
//           getHeight(context, 0.007),
//           divider(context: context, color: Color(0xffCFCFCF)),
//           getHeight(context, 0.01),
//           infoTile(
//             context,
//             title: context.local.vendor,
//             subtitle: videosModel.videoDetailModel.vendor,
//           ),
//           getHeight(context, 0.01),
//           infoTile(context,
//               title: context.local.type,
//               subtitle: videosModel.videoDetailModel.type),
//           getHeight(context, 0.01),
//           infoTile(context,
//               title: context.local.area,
//               subtitle: videosModel.videoDetailModel.area,
//               isShowIcon: true,
//               icon: Constant.marla),
//           getHeight(context, 0.007),
//           divider(context: context, color: Color(0xffCFCFCF)),
//           getHeight(context, 0.007),
//           Row(
//             children: [
//               Expanded(
//                 child: GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                         padding: EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                               color: AppColor.buttonColor,
//                               width: 1,
//                             ),
//                             borderRadius: BorderRadius.circular(4),
//                             color: AppColor.buttonColor.withOpacity(0.2)),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(Constant.addtocart),
//                             getWidth(context, 0.010),
//                             appText(
//                                 color: AppColor.blackColor,
//                                 title: context.local.addtoCart,
//                                 context: context,
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w400),
//                           ],
//                         ))),
//               ),
//               getWidth(context, 0.020),
//               Expanded(
//                 child: GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                         padding: EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(4),
//                             color: AppColor.buttonColor),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(Constant.buy),
//                             getWidth(context, 0.010),
//                             appText(
//                                 color: AppColor.blackColor,
//                                 title: context.local.buy,
//                                 context: context,
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w400),
//                           ],
//                         ))),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

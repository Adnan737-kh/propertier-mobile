import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';

// ignore: must_be_immutable
class HomePostsTile extends StatelessWidget {
  HomeViewModel viewModel;
  HomePostsTile({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.whatAreYouSearchingView);
              },
              child: Image.asset(Constant.whatAreYouSearchingFor)),
        ),
        // RichText(
        //     text: TextSpan(
        //         style: textStyle(
        //             context: context,
        //             fontSize: 10,
        //             fontWeight: FontWeight.w500),
        //         text: "What are you searching for? ",
        //         children: [
        //       TextSpan(
        //           style: textStyle(
        //               fontSize: 12,
        //               context: context,
        //               fontWeight: FontWeight.w700,
        //               color: AppColor.greenColor),
        //           text: 'Post Here',
        //           recognizer: TapGestureRecognizer()..onTap = () {})
        //     ])),
        getHeight(context, 0.01),
        divider(context: context),

        // getHeight(context, 0.005),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Row(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Container(
        //           height: context.getSize.height * 0.040,
        //           width: context.getSize.height * 0.040,
        //           decoration: const BoxDecoration(
        //               shape: BoxShape.circle,
        //               image: DecorationImage(
        //                   image: NetworkImage(
        //                     Constant.dummayImage,
        //                   ),
        //                   fit: BoxFit.cover)),
        //         ),
        //         getWidth(context, 0.020),
        //         Expanded(
        //           child: TextFormField(
        //             style: textStyle(
        //                 context: context,
        //                 color: const Color(0xff797979),
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.w400),
        //             maxLines: 5,
        //             decoration: InputDecoration(
        //                 hintText: 'Post here...',
        //                 hintStyle: textStyle(
        //                     context: context,
        //                     color: const Color(0xff797979),
        //                     fontSize: 14,
        //                     fontWeight: FontWeight.w400),
        //                 border: InputBorder.none,
        //                 focusedBorder: InputBorder.none,
        //                 enabledBorder: InputBorder.none,
        //                 contentPadding: const EdgeInsets.all(0)),
        //           ),
        //         ),
        //       ],
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         getWidth(
        //           context,
        //           context.getSize.width * 0.00025,
        //         ),
        //         Image.asset(
        //           Constant.earth,
        //           height: context.getSize.height * 0.020,
        //         ),
        //         getWidth(
        //           context,
        //           context.getSize.width * 0.00005,
        //         ),
        //         appText(
        //           title: 'Everyone can reply',
        //           context: context,
        //           color: const Color(0xff797979),
        //           fontSize: 10,
        //           fontWeight: FontWeight.w600,
        //         )
        //       ],
        //     ),
        //     getHeight(context, 0.011),
        //     divider(
        //       context: context,
        //     ),
        //     getHeight(context, 0.007),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             getWidth(
        //               context,
        //               context.getSize.width * 0.00025,
        //             ),
        //             Row(
        //               children: List.generate(3, (index) {
        //                 List<IconData> icons = [
        //                   Icons.photo_outlined,
        //                   Icons.emoji_emotions_outlined,
        //                   Icons.gif_outlined
        //                 ];
        //                 return Padding(
        //                   padding:
        //                       EdgeInsets.only(right: index == 3 - 1 ? 0 : 23),
        //                   child: Icon(icons[index]),
        //                 );
        //               }),
        //             ),
        //           ],
        //         ),
        //         GestureDetector(
        //           onTap: () {},
        //           child: Container(
        //             alignment: Alignment.center,
        //             padding: const EdgeInsets.all(3),
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(10),
        //                 color: AppColor.greenColor),
        //             child: appText(
        //                 title: 'Send',
        //                 context: context,
        //                 color: AppColor.white,
        //                 fontSize: 10,
        //                 fontWeight: FontWeight.w600),
        //           ),
        //         )
        //       ],
        //     ),
        //     getHeight(context, 0.007),
        //     divider(context: context),
        //     getHeight(context, 0.010),
        //     Column(
        //       children: List.generate(
        //           viewModel.isShowMoreComment == false
        //               ? 1
        //               : viewModel.homeModel.value.data!.posts!.length,
        //           (index) {
        //         Post post = viewModel.isShowMoreComment == false
        //             ? viewModel.homeModel.value.data!.posts![0]
        //             : viewModel.homeModel.value.data!.posts![index];
        //         return Column(
        //           children: [
        //             Row(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Container(
        //                   height: context.getSize.height * 0.040,
        //                   width: context.getSize.height * 0.040,
        //                   decoration: const BoxDecoration(
        //                       shape: BoxShape.circle,
        //                       image: DecorationImage(
        //                           image: NetworkImage(
        //                             Constant.dummayImage,
        //                           ),
        //                           fit: BoxFit.cover)),
        //                 ),
        //                 getWidth(context, 0.020),
        //                 Expanded(
        //                   // width: context.getSize.width * 0.70,
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       appText(
        //                           textAlign: TextAlign.start,
        //                           title: post.title!.parseHtmlString(),
        //                           context: context),
        //                       Row(
        //                         mainAxisSize: MainAxisSize.max,
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceBetween,
        //                         children: List.generate(
        //                             viewModel.commentButtonsList.length,
        //                             (index) => Row(children: [
        //                                   Icon(viewModel
        //                                       .commentButtonsList[index]
        //                                       .icon),
        //                                   getWidth(context, 0.003),
        //                                   viewModel.commentButtonsList[index]
        //                                               .title ==
        //                                           ''
        //                                       ? const SizedBox.shrink()
        //                                       : appText(
        //                                           title: index == 3
        //                                               ? post.viewCount!
        //                                                   .toString()
        //                                               : viewModel
        //                                                   .commentButtonsList[
        //                                                       index]
        //                                                   .title,
        //                                           context: context,
        //                                           fontSize: 10,
        //                                           fontWeight: FontWeight.w400,
        //                                           color:
        //                                               AppColor.darkGreyColor)
        //                                 ])),
        //                       )
        //                     ],
        //                   ),
        //                 )
        //               ],
        //             ),
        //             getHeight(context, 0.020)
        //           ],
        //         );
        //       }),
        //     )
        //   ],
        // ),
        // getHeight(context, 0.015),
        // GestureDetector(
        //   onTap: () {
        //     viewModel.showMoreComment(!viewModel.isShowMoreComment);
        //   },
        //   child: appText(
        //       title: viewModel.isShowMoreComment == false
        //           ? 'View More'
        //           : "View Less",
        //       context: context,
        //       color: AppColor.greenColor,
        //       fontSize: 12,
        //       fontWeight: FontWeight.w500),
        // )
      ],
    );
  }
}

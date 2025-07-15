import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Services/Model/services_model.dart';
import 'package:propertier/App/ServicesSearch/View/component/description_text_field.dart';
import 'package:propertier/App/ServicesSearch/View/component/services_search_tab_tile.dart';
import 'package:propertier/App/ServicesSearch/View/component/upload_work_photos_tile.dart';
import 'package:propertier/App/ServicesSearch/View/component/custom_textfield.dart';
import 'package:propertier/App/ServicesSearch/ViewModel/services_search_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/search_text_field.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Utils/box_shadow.dart';

class ServicesSearchView extends StatelessWidget {
  ServicesSearchView({super.key});

  final ParentServicesModel parentServicesModel = Get.arguments['parentServiceModel'];
  final Subservices subServices = Get.arguments['subService'];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColor.backgroundColor),
    );
    return GetX<ServicesSearhViewModel>(
        init: ServicesSearhViewModel(),
        builder: (viewModel) {
          return Scaffold(
              body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(alignment: Alignment.topCenter, children: [
              Image.asset(
                Constant.curve,
                width: context.getSize.width,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.getSize.width * 0.09),
                  child: Column(
                    children: [
                      getHeight(context, 0.050),
                      customAppBar(
                          context: context,
                          onTap: () {
                            Get.back();
                          }),
                      getHeight(context, 0.04),
                      SearchTextField(
                          horizontalPadding: 0,
                          searchController: viewModel.searchController,
                          suFixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(Constant.mic)),
                              getWidth(context, 0.010),
                              Container(
                                height: context.getSize.height * 0.015,
                                width: 1,
                                color: AppColor.blackColor,
                              ),
                              getWidth(context, 0.010),
                              GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Ionicons.location,
                                    size: context.getSize.width * 0.035,
                                    color: const Color(0xffF24E1E),
                                  )),
                            ],
                          )),
                      getHeight(context, 0.015),
                      parentServicesModel.image != null?
                          Image.network(parentServicesModel.image??Constant.dummyImage,height: 100,
                            width: 86,):
                      SvgPicture.asset(
                        Constant.servicesSearchIcon,
                        height: 100,
                        width: 86,
                      ),
                      getHeight(context, 0.01),
                      CustomText(
                          title: parentServicesModel.title??"",
                          fontSize: 18,
                          colorOpecity: 0.6,
                          fontWeight: FontWeight.w500,
                          ),
                      getHeight(context, 0.01),
                      Column(
                        children: [
                          InstaImageViewer(
                            imageUrl:
                            subServices.coverImageUrl??
                                Constant.dummyImage2,
                            child: Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(
                                  left: 36,
                                  right: 36,
                                  top: context.getSize.height * 0.050),
                              width: context.getSize.width,
                              height: context.getSize.height * 0.20,
                              decoration: BoxDecoration(
                                // border: Border.all(width: 5),
                                  boxShadow: [boxShadow()],
                                  image: subServices.coverImageUrl == null
                                      ? null
                                      : DecorationImage(
                                      image: NetworkImage(subServices.coverImageUrl??
                                          Constant.dummyImage2),
                                      fit: BoxFit.cover)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox.shrink(),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.share,
                                      color: AppColor.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 36),
                            width: context.getSize.width,
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                boxShadow: [boxShadow()],
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            // height: context.getSize.height * 0.12,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        title: subServices.title ??"",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                    getWidth(context, 0.010),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColor.buttonColor),
                                      child: Icon(
                                        Icons.check,
                                        size: context.getSize.width * 0.03,
                                        color: AppColor.blackColor,
                                      ),
                                    )
                                  ],
                                ),
                                getHeight(context, 0.010),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: RatingBarIndicator(
                                    rating: 4,
                                    unratedColor: AppColor.greenColor,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: context.getSize.width * 0.034,
                                    direction: Axis.horizontal,
                                  ),
                                ),
                                getHeight(context, 0.020),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CustomText(
                                      colorOpecity: 0.6,
                                      title: subServices.description??"",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      getHeight(context, 0.016),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                              controller: viewModel.yourSelfController),
                          getHeight(context, 0.01),
                          SizedBox(
                            height: context.getSize.height * 0.03,
                            // width: context.getSize.width,
                            child: Center(
                              child: ListView(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                    viewModel.tabsList.length,
                                    (index) => servicesSearchTabsTile(context,
                                            onTap: () {
                                          viewModel.onChangeTab(index);
                                        },
                                            selectedColor:
                                                viewModel.selectedTabIndex ==
                                                        index
                                                    ? AppColor.buttonColor
                                                    : null,
                                            title: viewModel.tabsList[index])),
                              ),
                            ),
                          ),
                          getHeight(context, 0.01),
                          divider(
                              context: context,
                              color: AppColor.blackColor.withOpacity(0.75)),
                          getHeight(context, 0.015),
                          CustomText(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              title: context.local.upload_work_photo,
                              ),
                          getHeight(context, 0.008),
                          const UploadWorkPhotosTile(),
                          getHeight(context, 0.015),
                          CustomText(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              title: context.local.description_about_your_work,
                          ),
                          getHeight(context, 0.008),
                          DescriptionTextField(
                            descriptionController:
                                viewModel.descriptionController,
                          ),
                          getHeight(context, 0.024),
                          textButton(
                              textFontSize: 20,
                              textFontWeight: FontWeight.w500,
                              context: context,
                              title: 'Offer to Plumber',
                              onClick: () {
                                viewModel.createBidByCustomer(context,parentServicesModel,subServices);
                              })
                        ],
                      )
                    ],
                  )),
            ]),
          ));
        });
  }
}

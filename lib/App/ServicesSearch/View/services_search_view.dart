import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Services/Model/services_model.dart';
import 'package:propertier/App/ServicesSearch/View/component/description_text_field.dart';
import 'package:propertier/App/ServicesSearch/View/component/services_search_tab_tile.dart';
import 'package:propertier/App/ServicesSearch/View/component/upload_work_photos_tile.dart';
import 'package:propertier/App/ServicesSearch/View/component/yourself_textfield.dart';
import 'package:propertier/App/ServicesSearch/ViewModel/services_search_view_model.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/search_text_field.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class ServicesSearchView extends StatelessWidget {
  ServicesSearchView({super.key});

  ServicesModel service = Get.arguments;
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
                          horzontalPadding: 0,
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
                      SvgPicture.asset(
                        Constant.servicesSearchIcon,
                        height: 100,
                        width: 86,
                      ),
                      getHeight(context, 0.01),
                      appText(
                          title: service.title,
                          fontSize: 18,
                          colorOpecity: 0.6,
                          fontWeight: FontWeight.w500,
                          context: context),
                      getHeight(context, 0.016),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          YourSelfTextField(
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
                          appText(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              title: context.local.uploadWorkPhoto,
                              context: context),
                          getHeight(context, 0.008),
                          const UploadWorkPhotosTile(),
                          getHeight(context, 0.015),
                          appText(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              title: context.local.descriptionAboutYourWork,
                              context: context),
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
                                Get.toNamed(AppRoutes.servicesSearch2View,
                                    arguments: service);
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

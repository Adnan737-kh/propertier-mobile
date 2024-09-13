import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/Home/View/component/carousel_slider_widget.dart';
import 'package:propertier/App/Home/View/home_view.dart';
import 'package:propertier/App/Services/Model/services_model.dart';
import 'package:propertier/App/Services/View/component/services_appbar.dart';
import 'package:propertier/App/Services/View/component/services_short_videos_tile.dart';
import 'package:propertier/App/Services/View/component/services_tile.dart';
import 'package:propertier/App/Services/View/component/services_video_tile.dart';
import 'package:propertier/App/Services/View/component/top_selling_services_tile.dart';
import 'package:propertier/App/Services/ViewModel/services_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/grid_title_tile.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/search_text_field.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class ServciesView extends StatelessWidget {
  ServciesView({super.key});
  final viewModel = Get.find<ServicesViewModel>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColor.backgroundColor),
    );
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: Platform.isAndroid
                ? context.getSize.height * (0.45)
                : context.getSize.height * (0.42),
            flexibleSpace: FlexibleSpaceBar(
              background: servciesAppBar(context, viewModel: viewModel),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Build the list of items
                return PopScope(
                  canPop: false,
                  // onPopInvoked: (val) {
                  //   // if (val == true) {
                  //   Get.offAllNamed(AppRoutes.navBarView);
                  //   // }
                  // },
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.getSize.width * 0.030,
                            vertical: context.getSize.height * 0.01),
                        child: Column(
                          children: [
                            GridView.builder(
                                padding: const EdgeInsets.all(0),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: context.getSize.height * 0.18,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                                itemCount: viewModel.servciesList.length,
                                itemBuilder: (context, index) {
                                  return servicesTile(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.servicesSearchView,
                                          arguments:
                                              viewModel.servciesList[index]);
                                    },
                                    service: viewModel.servciesList[index],
                                    context: context,
                                  );
                                }),
                            getHeight(context, 0.015),
                            textButton(
                                context: context,
                                title: 'Other',
                                onClick: () {}),
                            getHeight(context, 0.015),
                            gridTitleTile(context,
                                title: context.local.topSellingServices,
                                callBack: () {
                              Get.toNamed(AppRoutes.propertiesAndVideoView,
                                  arguments:
                                      PoropertiesAndVideoEnum.topselling);
                            }, fontSize: 14),
                            getHeight(context, 0.008),
                            GridView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(0),
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisExtent:
                                            context.getSize.height * 0.18,
                                        crossAxisSpacing:
                                            context.getSize.width * 0.016),
                                itemCount: viewModel.topSellingList.length,
                                itemBuilder: (context, index) {
                                  ServicesModel services =
                                      viewModel.topSellingList[index];
                                  return topSellingServices1(context, services,
                                      onClick: () {});
                                }),
                            getHeight(context, 0.015),
                            gridTitleTile(context,
                                title: context.local.topSellingServices,
                                callBack: () {},
                                fontSize: 14),
                            getHeight(context, 0.008),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.getSize.height * 0.2,
                        width: context.getSize.width,
                        child: ListView.builder(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.getSize.width * 0.082),
                            shrinkWrap: true,
                            itemCount: viewModel.topSellingList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              ServicesModel services =
                                  viewModel.topSellingList[index];
                              return topSellingServices2(context, services,
                                  onClick: () {});
                            }),
                      ),
                      getHeight(context, 0.015),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.getSize.width * 0.09),
                        child: Column(
                          children: [
                            ServicesShortVideoTile(viewModel: viewModel),
                            getHeight(context, 0.015),
                            gridTitleTile(context,
                                title: context.local.videos, callBack: () {}),
                            getHeight(context, 0.010),
                            const ServicesVideoTile(),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

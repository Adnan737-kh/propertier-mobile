import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Home/View/home_view.dart';
import 'package:propertier/App/PropertiesAndShortVideo/View/component/inside_appbar_tile.dart';
import 'package:propertier/App/PropertiesAndShortVideo/View/component/properties_and_video_app_bar.dart';
import 'package:propertier/App/PropertiesAndShortVideo/View/component/top_selling_tile.dart';
import 'package:propertier/App/PropertiesAndShortVideo/View/component/properties_tile.dart';
import 'package:propertier/App/PropertiesAndShortVideo/View/component/videos_tile.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Utils/loading_view.dart';
import '../ViewModel/properties_and_Video_view_model.dart';

// ignore: must_be_immutable
class PropertiesAndVideoView extends StatelessWidget {
  PropertiesAndVideoView({super.key});
  final viewModel = Get.find<PropertiesAndVideoViewModel>();

  var data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    var selectedTile = data["PropertyEnum"];
    viewModel.setSelectTab(
        data["PropertiesType"] != "" ? data["PropertiesType"] : "All Types");
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            // titleSpacing: 10,
            expandedHeight: Platform.isAndroid
                ? sizeHeight((0.28 - 0.030), (03 - 0.030))
                : sizeHeight((0.28 - 0.030), (0.3 - 0.030)),
            flexibleSpace: FlexibleSpaceBar(
              expandedTitleScale: 1,
              title: Obx(
                () => insideAppBarTile(
                  context,
                  title: selectedTile == PoropertiesAndVideoEnum.video
                      ? '${viewModel.propertyList.length} ${viewModel.selectedTab} in ${viewModel.currentLocation}'
                      : '${viewModel.propertyList.length} ${viewModel.selectedTab} in ${viewModel.currentLocation}',
                ),
              ),
              centerTitle: true,
              titlePadding: EdgeInsets.only(
                  left: context.getSize.width * 0.030,
                  right: context.getSize.width * 0.030,
                  bottom: context.getSize.height * 0.010),
              background: PropertiesAndVideosAppBar(
                viewModel: viewModel,
                poropertiesAndShortVideoEnum: selectedTile,
                propertiesType: data["PropertiesType"],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 5),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return switchPropertiesAndVideoTile(
                      data["PropertiesType"], selectedTile, context);
                },
                childCount: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget switchPropertiesAndVideoTile(
      // HomeViewModel homeVM,
      String type,
      PoropertiesAndVideoEnum data,
      BuildContext context) {
    switch (data) {
      case PoropertiesAndVideoEnum.topselling:
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.getSize.width * 0.030,
          ),
          child: Column(
            children: [
              getHeight(context, 0.010),
              ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: viewModel.architectureList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        topSellingListTile(context,
                            architecture: viewModel.architectureList[index]),
                        getHeight(context, 0.015),
                      ],
                    );
                  })
            ],
          ),
        );
      case PoropertiesAndVideoEnum.video:
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.getSize.width * 0.030,
          ),
          child: Column(
            children: [
              getHeight(context, 0.010),
              Obx(
                () => viewModel.isLoading.value
                    ? const Center(child: LoadingView())
                    : viewModel.propertyList.isEmpty
                        ? forNoData(context)
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount: viewModel.propertyList.length,
                            itemBuilder: (context, index) {
                              return videoTile(context,
                                  videoModel: viewModel.propertyList[index]);
                            }),
              )
            ],
          ),
        );
      case PoropertiesAndVideoEnum.properties:
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.getSize.width * 0.030,
          ),
          child: Column(
            children: [
              Obx(
                () => viewModel.isLoadingAll.value
                    ? const Center(child: LoadingView())
                    : viewModel.propertyList.isEmpty
                        ? forNoData(context)
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount: viewModel.propertyList.length,
                            itemBuilder: (context, index) {
                              return propertiesTile(context,
                                  property: viewModel.propertyList[index]);
                            }),
              )
            ],
          ),
        );
    }
  }

  Widget forNoData(BuildContext context) {
    return Center(
      child: appText(
          colorOpecity: 0.6,
          title: "Sorry! \nNo data Available",
          context: context),
    );
  }
}

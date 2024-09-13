import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Home/View/home_view.dart';
import '../ViewModel/profile_property_listing_view_model.dart';
import 'component/inside_appbar_tile.dart';
import 'component/properties_and_video_app_bar.dart';
import 'component/properties_tile.dart';
import 'component/top_selling_tile.dart';
import 'component/videos_tile.dart';

// ignore: must_be_immutable
class ProfilePropertyListingView extends StatelessWidget {
  ProfilePropertyListingView({super.key});
  final viewModel = Get.find<ProfilePropertyListingViewModel>();

  // final homeViewModel = Get.find<HomeViewModel>();
  var data = Get.arguments;

  // PoropertiesAndVideoEnum selectedTile = data[""];
  @override
  Widget build(BuildContext context) {
    var selectedTile = data["PropertyEnum"];
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            // titleSpacing: 10,
            expandedHeight: Platform.isAndroid
                ? context.getSize.height * (0.265 - 0.030)
                : context.getSize.height * (0.24 - 0.030),
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
                  left: context.getSize.width * 0.090,
                  right: context.getSize.width * 0.090,
                  bottom: context.getSize.height * 0.010),
              background: PropertiesAndVideosAppBar(
                viewModel: viewModel,
                poropertiesAndShortVideoEnum: selectedTile,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Build the list of items
                return switchPropertiesAndVideoTile(selectedTile, context);
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );

    // Column(
    //   children: [
    //     PropertiesAndVideosAppBar(
    //       viewModel: viewModel,
    //       poropertiesAndShortVideoEnum: selectedTile,
    //     ),
    //     getHeight(context, 0.015),
    //     switchPropertiesAndVideoTile(selectedTile, context)
    //   ],
    // ),
  }

  Widget switchPropertiesAndVideoTile(
      // HomeViewModel homeVM,
      PoropertiesAndVideoEnum data,
      BuildContext context) {
    print(data);
    switch (data) {
      case PoropertiesAndVideoEnum.topselling:
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.getSize.width * 0.090,
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
            horizontal: context.getSize.width * 0.090,
          ),
          child: Column(
            children: [
              getHeight(context, 0.010),
              Obx(
                () => ListView.builder(
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
            horizontal: context.getSize.width * 0.090,
          ),
          child: Column(
            children: [
              // insideAppBarTile(
              //   context,
              //   title: '6 Bungalows in Bahira town Pakistan',
              // ),
              getHeight(context, 0.010),
              Obx(
                () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: viewModel.propertyList.length,
                    itemBuilder: (context, index) {
                      return propertiesTile(context,
                          viewModel: viewModel,
                          property: viewModel.propertyList[index]);
                    }),
              )
            ],
          ),
        );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Home/View/component/grid_tile.dart';
import 'package:propertier/App/Home/View/component/home_videos_tile.dart';
import 'package:propertier/App/Home/View/component/posts_tile.dart';
import 'package:propertier/App/Home/View/component/properties.dart';
import 'package:propertier/App/Home/View/component/short_videos_tile.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/Utils/height_width_box.dart';

class CommercialView extends StatelessWidget {
  const CommercialView({super.key, required this.viewModel});
  final HomeViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(0),
      children: [
        GridTileWidget(
          viewModel: viewModel,
        ),
        getHeight(context, 0.025),
        viewModel.homeModel.value.data != null
            ? Obx(
                () => Properties(
                  propertyList: viewModel.homeModel.value.data!.properties,
                  viewModel: viewModel,
                ),
              )
            : const Gap(0),
        getHeight(context, 0.025),
        Obx(
          () => viewModel.homeModel.value.data != null
              ? ShortVideosTile(
                  viewModel: viewModel,
                  shortVidoesList: viewModel.homeModel.value.data!.shortVideos,
                )
              : const SizedBox(),
        ),
        getHeight(context, 0.015),
        viewModel.homeModel.value.data != null
            ? HomeVideosTile(
                viewModel: viewModel,
              )
            : const SizedBox(),
        getHeight(context, 0.015),
        HomePostsTile(viewModel: viewModel),
        getHeight(context, 0.12),
      ],
    );
  }
}

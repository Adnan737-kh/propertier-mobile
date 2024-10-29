import 'package:flutter/material.dart';

import 'package:get/get.dart';
// import 'package:propertier/App/Profile/Model/profile_model.dart';
// import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
// import 'package:propertier/App/ShortVideo/View/component/short_video_player_widget.dart';

import 'package:propertier/constant/colors.dart';

// import '../../ViewModel/profile_view_model.dart';
// import '../../../PropertiesAndShortVideo/Model/all_properties_model.dart';
import '../../../../Model/property.dart';
import '../../ViewModel/short_video_profile_viewmodel.dart';
import 'short_profile_player.dart';

// ignore: must_be_immutable
class ShortVideoProfileView extends StatelessWidget {
  ShortVideoProfileView({
    super.key,
  });
  final viewModel = Get.find<ShortVideoProfileViewModel>();
  // final homeViewModel = Get.find<ProfileViewModel>();
  var data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    List<Property> listOfProperties = data["ListOfVideos"];
    var property = data["property"];
    List<Property> dataList = listOfProperties
        .where(
          (element) => element.shortVideo != null,
        )
        .toList();
    List<Property> newShortVideosList = [];
    if (property.id != null) {
      dataList.removeWhere((element) => element.id == property.id);
      newShortVideosList.addAll(dataList);
      newShortVideosList.insert(0, property);
    }
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: PageView.builder(
          onPageChanged: (val) {
            viewModel.pageController.animateToPage(
              val,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
          controller: viewModel.pageController,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: newShortVideosList.length,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: viewModel.pageController,
              builder: (context, child) {
                double value = 1.0;
                if (viewModel.pageController.position.haveDimensions) {
                  value = viewModel.pageController.page! - index;
                  value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
                }
                return SizedBox(
                    height: Curves.easeOut.transform(value) * 200,
                    width: Curves.easeOut.transform(value) * 200,
                    child: child);
              },
              child: ShortVideoPLayerWidget(
                  index: index,
                  property: newShortVideosList[index]
              ),
            );
          }),
    );
  }
}

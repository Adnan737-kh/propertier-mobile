import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/MarketPlace/View/component/for_rent_tile.dart';
import 'package:propertier/App/MarketPlace/View/component/share_and_buy_tile.dart';
import 'package:propertier/App/MarketPlace/ViewModel/market_place_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/appbar.dart';
import 'package:propertier/Utils/grid_title_tile.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/search_text_field.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

class MarketPlaceView extends StatelessWidget {
  MarketPlaceView({super.key});
  final viewModel = Get.find<MarketPlaceViewModel>();
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          // fit: StackFit.loose,
          alignment: Alignment.topCenter,
          children: [
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
                              onTap: () {}, child: Image.asset(Constant.mic)),
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
                  getHeight(context, 0.030),
                  CustomText(
                      title: context.local.postYourVideoShortVideo,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff4286F5)),
                  getHeight(context, 0.02),
                  gridTitleTile(context,
                      title: context.local.for_sale, callBack: () {}),
                  getHeight(context, 0.010),
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: context.getSize.height * 0.375,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return customShareAndBuyTile(context,
                            onShareCallBack: () {});
                      }),
                  getHeight(context, 0.025),
                  gridTitleTile(context,
                      title: context.local.forRent, callBack: () {}),
                  getHeight(context, 0.015),
                  const ForRentTile(),
                  getHeight(context, 0.025),
                  gridTitleTile(context,
                      title: context.local.toBuy, callBack: () {}),
                  getHeight(context, 0.015),
                  GridView.builder(
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: context.getSize.height * 0.375,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return customShareAndBuyTile(context,
                            onShareCallBack: () {});
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

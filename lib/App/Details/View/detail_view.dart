import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Details/ViewModel/properties_detail_view_model.dart';
import 'package:propertier/App/Details/View/component/details_tile.dart';

import 'package:propertier/App/Details/View/component/details_view_appbar.dart';
import 'package:propertier/App/What%20are%20you%20searching/View/Components/custom_botton_wryf.dart';
import 'package:propertier/Utils/app_text.dart';

import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../extensions/navigate_to_dailpad.dart';

// ignore: must_be_immutable
class DetailsView extends StatelessWidget {
  DetailsView({super.key});
  var data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("details idd!${data["id"]}");
    }
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColor.backgroundColor),
    );
    return GetX<DetailsViewModel>(
        init: DetailsViewModel(),
        initState: (viewModel) {
          viewModel.controller!.getSpecificPropertyDetail(id: data["id"]);
        },
        builder: (viewModel) {
          // print("Youtube video url ${viewModel.specificPropertyModel
          //     .value.detailDataModel?.property?.video}");
          return Scaffold(
            body: viewModel.specificPropertyModel.value.detailDataModel == null
                ? const SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColor.buttonColor,
                      ),
                    ),
                  )
                : CustomScrollView(
                    controller: viewModel.scrollController,
                    physics: const BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverAppBar(
                        pinned: true,
                        automaticallyImplyLeading: false,
                        expandedHeight: Platform.isAndroid
                            ? context.getSize.height * (0.36 - 0.030)
                            : context.getSize.height * (0.31 - 0.030),
                        flexibleSpace: FlexibleSpaceBar(
                          expandedTitleScale: 1,
                          titlePadding: EdgeInsets.only(
                              top: context.getSize.height * 0.03,
                              left: context.getSize.width * 0.090,
                              right: context.getSize.width * 0.090),
                          centerTitle: true,
                          title: AnimatedOpacity(
                            opacity: viewModel.isCollapsed ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.white,
                                    ),
                                    child: Icon(
                                      Icons.keyboard_arrow_left,
                                      size: context.isPhone ? 30 : 40,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.share,
                                        size: context.isPhone ? 30 : 40,
                                        color: AppColor.blackColor,
                                      ),
                                    ),
                                    getWidth(context, 0.020),
                                    GestureDetector(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                        Constant.heartUnFill,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          background: detailsAppBar(
                            // detail: viewModel.specificPropertyModel.value.data!.property,
                            context,
                            viewModel: viewModel,
                            favoriteCallBack: () {},
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            // Build the list of items
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.getSize.width * 0.010),
                              child: detailTile(context,
                                  dataModel: viewModel.specificPropertyModel
                                      .value.detailDataModel!),
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                    ],
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: data["user"] == "null"
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8, horizontal: context.getSize.width * 0.070),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.blackColor.withOpacity(0.3),
                        ),
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: appText(
                                title: viewModel.specificPropertyModel.value
                                            .detailDataModel !=
                                        null
                                    ? "${double.parse(viewModel.specificPropertyModel.value.detailDataModel!.property!.price!).toInt().toString()} PKR"
                                    : "",
                                context: context,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                          Expanded(
                            flex: 1,
                            child: customButton(
                                fontSize: 14,
                                radius: 50,
                                fontWeight: FontWeight.w500,
                                buttonColor: AppColor.buttonColor,
                                textColor: AppColor.blackColor,
                                height: 39,
                                title: "Contact Seller",
                                onTap: () {
                                  Get.bottomSheet(
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          )),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          customButton(
                                            title: "Call",
                                            onTap: () {
                                              openDialer(viewModel
                                                      .specificPropertyModel
                                                      .value
                                                      .detailDataModel!
                                                      .property!
                                                      .agent!
                                                      .phoneNumberCountryCode! +
                                                  viewModel
                                                      .specificPropertyModel
                                                      .value
                                                      .detailDataModel!
                                                      .property!
                                                      .agent!
                                                      .phoneNumber!);
                                            },
                                          ),
                                          const Gap(10),
                                          customButton(
                                            title: "SMS",
                                            onTap: () {
                                              textMe(viewModel
                                                      .specificPropertyModel
                                                      .value
                                                      .detailDataModel!
                                                      .property!
                                                      .agent!
                                                      .phoneNumberCountryCode! +
                                                  viewModel
                                                      .specificPropertyModel
                                                      .value
                                                      .detailDataModel!
                                                      .property!
                                                      .agent!
                                                      .phoneNumber!);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  )
                : null,
          );
        });
  }
}

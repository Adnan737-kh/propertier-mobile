import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Home/Model/grid_tile_model.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../RoutesAndBindings/app_routes.dart';
import '../home_view.dart';

class GridTileWidget extends StatelessWidget {
  final HomeViewModel viewModel;
  const GridTileWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Wrap(
            direction: Axis.horizontal,
            spacing: 7,
            runSpacing: 7,
            children: List.generate(viewModel.isViewMore == false ? 6 : 14,
                // viewModel.seletcedTabIndex == 0
                //     ?   viewModel.comercialTileList.length
                //         : viewModel.residentialList.length,
                (index) {
              GridTileModel tileModel = viewModel.seletcedTabIndex == 0
                  ? viewModel.comercialTileList[index]
                  : viewModel.residentialList[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.propertiesAndVideoView, arguments: {
                    "PropertyEnum": PoropertiesAndVideoEnum.properties,
                    "PropertiesType": tileModel.title
                  });
                },
                child: Container(
                  // height: context.getSize.height * 0.130,
                  width: context.getSize.width * 0.27,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.white,
                      border: Border.all(
                        color: const Color(0xffF1F1F1),
                        width: 1,
                      ),
                      boxShadow: [boxShadow()]),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: context.getSize.height * 0.110,
                          width: context.getSize.width * 0.27,
                          child: SvgPicture.asset(
                              fit: BoxFit.cover, tileModel.IconLink),
                        ),
                        const Gap(10),
                        appText(
                            title: tileModel.title,
                            colorOpecity: 0.6,
                            context: context),
                        const Gap(10),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        getHeight(context, 0.008),
        Obx(() => viewModel.seletcedTabIndex == 0
            ? GestureDetector(
                onTap: () {
                  viewModel.viewMore(!viewModel.isViewMore);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => appText(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        title: viewModel.isViewMore == true ? 'Less' : 'More',
                        context: context,
                        textDecoration: TextDecoration.underline),
                  ),
                ),
              )
            : const SizedBox.shrink()),
      ],
    );
  }
}

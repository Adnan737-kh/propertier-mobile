import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:propertier/App/Home/View/component/carousel_slider_widget.dart';
// import 'package:propertier/App/Home/View/component/sell_and_rent_for_me_buttons.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';

import '../../ViewModel/my_orders_view_model.dart';

class TopWidgetwithAppBar extends StatelessWidget {
  const TopWidgetwithAppBar({
    super.key,
    required this.viewModel,
  });

  final MyOrderViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getHeight(context, 0.010),
        getHeight(context, 0.010),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(viewModel.tabList.length, (index) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      viewModel.changeTabIndex(index);
                    },
                    child: Obx(
                      () => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: viewModel.seletcedTabIndex == index
                                ? AppColor.buttonColor
                                : Colors.transparent,
                            border: viewModel.seletcedTabIndex == index
                                ? const Border(
                                    bottom: BorderSide(
                                    color: AppColor.buttonColor,
                                    width: 1,
                                  ))
                                : null),
                        child: Obx(
                          () => appText(
                              title: viewModel.tabList[index],
                              context: context,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: viewModel.seletcedTabIndex == index
                                  ? AppColor.primaryColor
                                  : AppColor.primaryColor.withOpacity(0.6)),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}

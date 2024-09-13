import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/My%20Orders/Model/order_model.dart';
import 'package:propertier/App/My%20Orders/View/component/order_tile.dart';
// import 'package:propertier/App/Home/View/component/home_videos_tile.dart';
// import 'package:propertier/App/Home/View/component/posts_tile.dart';
// import 'package:propertier/App/Home/View/component/properties.dart';
// import 'package:propertier/App/Home/View/component/short_videos_tile.dart';
// import 'package:propertier/App/Home/View/component/top_widget_with_appbar.dart';
// import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/App/My%20Orders/ViewModel/my_orders_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
// import 'package:propertier/App/Utils/app_text.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
// import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Utils/appbar.dart';
import 'component/top_widget_with_appbar.dart';

class MyOrdersView extends StatelessWidget {
  MyOrdersView({super.key});
  final viewModel = Get.find<MyOrderViewModel>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.width * 0.060),
                child: Column(
                  children: [
                    getHeight(context, 0.050),
                    customAppBar(
                        context: context,
                        onTap: () => Get.back(),
                        title: "My Orders",
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    getHeight(context, 0.050),
                  ],
                ),
              ),
              TopWidgetwithAppBar(viewModel: viewModel),
              getHeight(context, 0.015),
              SizedBox(
                height: context.getSize.height * 0.78,
                child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.tabList.length,
                    controller: viewModel.pageController,
                    onPageChanged: (value) {
                      viewModel.changeTabIndex(value);
                    },
                    itemBuilder: (context, index) {
                      return Obx(() => Container(
                            height: context.getSize.height * 0.8,
                            width: context.getSize.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.darkGreyColor
                                          .withOpacity(0.25),
                                      blurRadius: 4,
                                      offset: const Offset(0, 0))
                                ]),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: context.width * 0.050),
                              child: ListView(
                                children: [
                                  Column(
                                    children: List.generate(
                                        viewModel.isViewMore == false ? 1 : 3,
                                        (index) => Column(
                                              children: [
                                                OrderTile(
                                                    order: OrderModel(
                                                        orderId:
                                                            "213JKJH231J21",
                                                        orderDate: "30-3-2024",
                                                        serviceName: "Pulamber",
                                                        address:
                                                            "Bahria Town Phase 7 islamabad",
                                                        price: "PKR 4000",
                                                        area: "Commercial",
                                                        status: "Completed")),
                                                OrderTile(
                                                    order: OrderModel(
                                                        orderId:
                                                            "213JKJH231J21",
                                                        orderDate: "30-3-2024",
                                                        serviceName: "Pulamber",
                                                        address:
                                                            "Bahria Town Phase 7 islamabad",
                                                        price: "PKR 4000",
                                                        area: "Commercial",
                                                        status: "Processing")),
                                                OrderTile(
                                                    order: OrderModel(
                                                        orderId:
                                                            "213JKJH231J21",
                                                        orderDate: "30-3-2024",
                                                        serviceName: "Pulamber",
                                                        address:
                                                            "Bahria Town Phase 7 islamabad",
                                                        price: "PKR 4000",
                                                        area: "Commercial",
                                                        status: "Pending")),
                                                OrderTile(
                                                    order: OrderModel(
                                                        orderId:
                                                            "213JKJH231J21",
                                                        orderDate: "30-3-2024",
                                                        serviceName: "Pulamber",
                                                        address:
                                                            "Bahria Town Phase 7 islamabad",
                                                        price: "PKR 4000",
                                                        area: "Commercial",
                                                        status: "Rejected")),
                                                OrderTile(
                                                    order: OrderModel(
                                                        orderId:
                                                            "213JKJH231J21",
                                                        orderDate: "30-3-2024",
                                                        serviceName: "Pulamber",
                                                        address:
                                                            "Bahria Town Phase 7 islamabad",
                                                        price: "PKR 4000",
                                                        area: "Commercial",
                                                        status: "Pending")),
                                                OrderTile(
                                                    order: OrderModel(
                                                        orderId:
                                                            "213JKJH231J21",
                                                        orderDate: "30-3-2024",
                                                        serviceName: "Pulamber",
                                                        address:
                                                            "Bahria Town Phase 7 islamabad",
                                                        price: "PKR 4000",
                                                        area: "Commercial",
                                                        status: "Rejected")),
                                              ],
                                            )),
                                  ),
                                  getHeight(context, 0.015),
                                  GestureDetector(
                                    onTap: () {
                                      viewModel.viewMore(!viewModel.isViewMore);
                                    },
                                    child: appText(
                                        title: viewModel.isViewMore == false
                                            ? 'View More'
                                            : "View Less",
                                        context: context,
                                        color: AppColor.greenColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

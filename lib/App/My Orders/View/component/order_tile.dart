import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:propertier/App/My%20Orders/Model/order_model.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/constant.dart';
import '../../../../Utils/app_text.dart';
import '../../../../Utils/height_width_box.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: AppColor.darkGreyColor.withOpacity(0.25),
                  blurRadius: 4,
                  offset: const Offset(0, 0))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(2),
                      bottomRight: Radius.circular(2)),
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.darkGreyColor.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 0))
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        appText(
                            title: "Order ID: ",
                            context: context,
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            colorOpecity: 0.6),
                        appText(
                            title: order.orderId,
                            context: context,
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                            colorOpecity: 0.4)
                      ],
                    ),
                    appText(
                        title: order.orderDate,
                        context: context,
                        fontSize: 8,
                        fontWeight: FontWeight.normal,
                        colorOpecity: 0.4)
                  ],
                ),
              ),
            ),
            getHeight(context, 0.008),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(Constant.dummayImage),
                  ),
                  const Gap(5),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appText(
                          title: order.serviceName,
                          context: context,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        const Gap(5),
                        appText(
                            title: order.address,
                            context: context,
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                            colorOpecity: 0.7),
                        const Gap(5),
                        appText(
                            title: order.price,
                            context: context,
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                            colorOpecity: 1),
                        const Gap(11),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border: Border.all(color: Colors.green[600]!)),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: appText(
                                  title: "Detail",
                                  context: context,
                                  fontSize: 10,
                                  color: Colors.green[600]!,
                                  fontWeight: FontWeight.normal,
                                  colorOpecity: 1),
                            )),
                        const Gap(8),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        appText(
                            title: order.area,
                            context: context,
                            fontSize: 8,
                            fontWeight: FontWeight.normal,
                            colorOpecity: 0.7),
                        order.status != "Pending"
                            ? Column(
                                children: [
                                  const Gap(50),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        order.status == "Completed"
                                            ? Constant.completedIcon
                                            : order.status == "Processing"
                                                ? Constant.processingIcon
                                                : Constant.rejectedIcon,
                                        height: 10,
                                        width: 10,
                                      ),
                                      const Gap(2),
                                      appText(
                                          title: order.status,
                                          context: context,
                                          fontSize: 8,
                                          fontWeight: FontWeight.normal,
                                          colorOpecity: 0.5),
                                    ],
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  const Gap(20),
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green[600]!,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 3),
                                        child: appText(
                                            title: "Accept",
                                            context: context,
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                            colorOpecity: 1),
                                      )),
                                  const Gap(11),
                                  Container(
                                      decoration: const BoxDecoration(
                                        color: AppColor.secondaryColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 3),
                                        child: appText(
                                            title: "Reject",
                                            context: context,
                                            fontSize: 10,
                                            color: AppColor.blackColor,
                                            fontWeight: FontWeight.normal,
                                            colorOpecity: 1),
                                      )),
                                ],
                              )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/App/MyServiceOrder/ViewModel/OrderViewModel.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../../constant/colors.dart';
import '../Model/ServiceOrderModel.dart';

class OrderServiceDetail extends StatelessWidget {
  const OrderServiceDetail({super.key, required this.order});
  final ServiceOrderModel order;
  @override
  Widget build(BuildContext context) {
    OrderViewModel controller = Get.put(OrderViewModel());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back_ios,color: AppColor.blackColor,)),
        title:  Text(context.local.work_detail,style: const TextStyle(color: AppColor.blackColor),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          order.imageUrls == null || order.imageUrls!.isEmpty
              ? Center(
                  child: Text(context.local.work_not_submitted_yet),
                )
              : SizedBox(
            width: context.width,
                height: 300,
                child: CarouselView(
                    itemExtent: context.width,
                    children: order.imageUrls!.map((e) {
                      return Image.network(
                        e,
                        fit: BoxFit.cover,
                        errorBuilder: (context, obj, track) {
                          return const SizedBox();
                        },
                      );
                    }).toList()),
              ),
          const SizedBox(height: 20,),
          Expanded(
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(context.local.work_detail, style: const TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                  Text(order.workDescription??"",style: const TextStyle(
                      color: AppColor.blackColor
                  ),),
                  const SizedBox(height: 20,),
                   Text(context.local.extra_price,style: const TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                  Text(order.extraPrice??"0.00",style: const TextStyle(
                      color: AppColor.blackColor
                  ),),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            controller.rejectSubmission(context,order.id.toString());
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColor.googleColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text(context.local.reject,style: const TextStyle(
                              color: AppColor.white
                            ),),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            controller.acceptSubmission(context, order.id.toString());
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColor.greenColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child:  Text(context.local.accept,style: const TextStyle(
                              color: AppColor.white
                            ),),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

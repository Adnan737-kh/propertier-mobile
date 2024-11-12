import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:propertier/App/MyServiceOrder/ViewModel/OrderViewModel.dart';

import '../../../constant/colors.dart';
import '../Model/ServiceOrderModel.dart';

class Orderservicedetail extends StatelessWidget {
  Orderservicedetail({super.key, required this.order});
  ServiceOrderModel order;
  @override
  Widget build(BuildContext context) {
    OrderViewModel controller = Get.put(OrderViewModel());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: AppColor.blackColor,)),
        title: Text("Work Detail",style: TextStyle(color: AppColor.blackColor),),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          order.imageUrls == null || order.imageUrls!.isEmpty
              ? Center(
                  child: Text("Work not sumbit yet!"),
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
                          return SizedBox();
                        },
                      );
                    }).toList()),
              ),
          SizedBox(height: 20,),
          Expanded(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Work Detail",style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                  Text(order.workDescription??"",style: TextStyle(
                      color: AppColor.blackColor
                  ),),
                  SizedBox(height: 20,),
                  Text("Extra Price",style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),
                  Text(order.extraPrice??"0.00",style: TextStyle(
                      color: AppColor.blackColor
                  ),),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            controller.rejectSubmition(context,order.id.toString());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColor.googleColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text("Reject",style: TextStyle(
                              color: AppColor.white
                            ),),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            controller.acceptSubmition(context, order.id.toString());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColor.greenColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            alignment: Alignment.center,
                            child: Text("Accept",style: TextStyle(
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

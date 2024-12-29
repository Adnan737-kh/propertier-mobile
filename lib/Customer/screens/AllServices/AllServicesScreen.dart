import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Customer/screens/AllServices/AllServicesScreenController.dart';
import 'package:propertier/constant/colors.dart';

import 'components/serviceTile.dart';


class AllServicesScreen extends GetView<AllServicesScreenController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=> {Get.back()}, icon: Icon(Icons.arrow_back,color: AppColor.blackColor,)),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          itemCount: controller.services.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: serviceTile(context,
                  service: controller.services[index]),
            );
          }),
    );
  }
}
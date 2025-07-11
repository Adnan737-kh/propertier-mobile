import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Customer/screens/ServiceDetail/controller/services_details_controller.dart';

Widget detailsAppBar(
    BuildContext context, {
      required ServiceDetailsController controller,
      required VoidCallback favoriteCallBack,
    }) {
  return controller.serviceDetails.value.imageUrls == null || controller.serviceDetails.value.imageUrls!.isEmpty
      ? const SizedBox(
    height: 300,
    child: Center(
      child: Text("No Images Available!"),
    ),
  )
      : SizedBox(
    width: context.width,
    height: 300,
    child: CarouselView(
        itemExtent: context.width,
        children: controller.serviceDetails.value.imageUrls!.map((e) {
          return Image.network(
            controller.serviceDetails.value.service!.image.toString(),
            fit: BoxFit.cover,
            errorBuilder: (context, obj, track) {
              return const SizedBox();
            },
          );
        }).toList()),
  );
}
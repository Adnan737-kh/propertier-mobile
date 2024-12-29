import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:propertier/App/Details/ViewModel/properties_detail_view_model.dart';
import 'package:propertier/Customer/screens/ServiceDetail/ServiceDetailController.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget detailsAppBar(
    BuildContext context, {
      required ServiceDetailController controller,
      required VoidCallback favoriteCallBack,
    }) {
  return controller.service.imageUrls == null || controller.service.imageUrls!.isEmpty
      ? SizedBox(
      height: 300,
        child: const Center(
            child: Text("No Images Available!"),
          ),
      )
      : SizedBox(
    width: context.width,
    height: 300,
    child: CarouselView(
        itemExtent: context.width,
        children: controller.service.imageUrls!.map((e) {
          return Image.network(
            e,
            fit: BoxFit.cover,
            errorBuilder: (context, obj, track) {
              return SizedBox();
            },
          );
        }).toList()),
  );
}

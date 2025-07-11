import 'package:flutter/material.dart';
import 'package:propertier/App/Services/Model/services_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

Widget servicesTile({
  required VoidCallback onTap,
  required ParentServicesModel service,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: border(),
          boxShadow: [boxShadow()],
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Image.network(service.image??"",height: context.getSize.height * 0.12,),
          getHeight(context, 0.005),
          CustomText(title: service.title??"")
        ],
      ),
    ),
  );
}

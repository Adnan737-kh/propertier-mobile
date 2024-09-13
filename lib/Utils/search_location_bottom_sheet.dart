import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/AppTextField/app_textfield.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../App/What are you searching/ViewModel/what_are_viewmodel.dart';

Future<dynamic> searchLoactionBottomSheet({
  required RxList<Place> placesList,
  required BuildContext context,
  required TextEditingController searchController,
  required Function(String) onChange,
  required Function(String) onSelect,
}) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: context.getSize.height,
          width: context.getSize.width,
          child: Column(
            children: [
              getHeight(context, 0.01),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.getSize.width * 0.02),
                child: customTextField(
                    onChanged: onChange,
                    hintText: 'Search Address',
                    controller: searchController),
              ),
              getHeight(context, 0.010),
              Obx(
                () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: placesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          onSelect(placesList[index].description);
                        },
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        dense: true,
                        title: Text(placesList[index].description),
                      );
                    }),
              )
            ],
          ),
        );
      });
}

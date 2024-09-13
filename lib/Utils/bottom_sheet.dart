import 'package:flutter/material.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

typedef OnChange = Function(String);
showLocationBottonSheet({
  required BuildContext context,
  required List<String> dataList,
  required String selectedLocation,
  required OnChange onChange,
}) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: context.getSize.height * 0.020,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  onChange("All Locations");
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.getSize.width * 0.040,
                    vertical: context.getSize.height * 0.010,
                  ),
                  decoration: BoxDecoration(
                    color: selectedLocation == "All Locations"
                        ? AppColor.buttonColor
                        : AppColor.white,
                  ),
                  child: appText(
                      textAlign: TextAlign.start,
                      title: "All Locations",
                      fontSize: 16,
                      context: context),
                ),
              ),
              SizedBox(
                height: context.getSize.height * 0.3,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          onChange(dataList[index]);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.getSize.width * 0.040,
                            vertical: context.getSize.height * 0.010,
                          ),
                          decoration: BoxDecoration(
                            color: selectedLocation == dataList[index]
                                ? AppColor.buttonColor
                                : AppColor.white,
                          ),
                          child: appText(
                              textAlign: TextAlign.start,
                              title: dataList[index],
                              fontSize: 16,
                              context: context),
                        ),
                      );
                    }),
              ),
            ],
          ),
        );
      });
}

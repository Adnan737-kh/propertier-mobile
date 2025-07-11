import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:propertier/App/ServicesMap/ViewModel/services_map_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

void showCustomPopup(BuildContext context,
    {required String serviceName, required String id, required ServicesMapViewModel viewModel}) {
  showDialog(
    barrierColor: Colors.transparent,
    barrierDismissible: false,
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return PopScope(
        canPop: true,
        onPopInvoked: (val) {
          if (val == true) {
            viewModel.isShowCancelButton(true);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: GetX<ServicesMapViewModel>(
                init: ServicesMapViewModel(BitmapDescriptor.defaultMarker,),
                builder: (viewModel) {
                  return Container(
                      decoration: const BoxDecoration(color: AppColor.white),
                      width: context.getSize.width * 0.6,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: List.generate(
                                viewModel.cencelJobIssue.length, (index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.getSize.width * 0.010,
                                  vertical: context.getSize.height * 0.012,
                                ),
                                decoration: BoxDecoration(
                                    border: border(),
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      boxShadow(),
                                    ]),
                                child: GestureDetector(
                                  onTap: () {
                                    viewModel.changeSelectedIssue(index);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      if (viewModel.selectedCancelIssue ==
                                          index)
                                        const Icon(Icons.check,
                                            color: AppColor.buttonColor)
                                      else
                                        getWidth(context, 0.060),
                                      getWidth(context, 0.020),
                                      if (index == 0)
                                        CustomText(
                                            title:
                                                '$serviceName ${viewModel.cencelJobIssue[index]}',
                                             ),
                                      if (index == 1)
                                        CustomText(
                                            title:
                                                viewModel.cencelJobIssue[index],
                                            ),
                                      if (index == 2)
                                        CustomText(
                                            title:
                                                viewModel.cencelJobIssue[index],
                                             ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          getHeight(context, 0.045),
                          Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  hideOpenDialog(context: context);
                                  viewModel.isShowCancelButton(true);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      vertical: context.getSize.height * 0.008),
                                  decoration: BoxDecoration(
                                      color: AppColor.greenColor,
                                      borderRadius: BorderRadius.circular(3),
                                      border: border(),
                                      boxShadow: [
                                        boxShadow(),
                                      ]),
                                  child: Icon(
                                    Icons.close,
                                    color: AppColor.white,
                                    size: context.getSize.height * 0.040,
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () async{
                                  await viewModel.cancelOrder(id, viewModel.cencelJobIssue[viewModel.selectedCancelIssue]);
                                  hideOpenDialog(context: context);
                                  viewModel.isShowCancelButton(true);
                                  Get.back();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      vertical: context.getSize.height * 0.008),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffE4A951),
                                      borderRadius: BorderRadius.circular(3),
                                      border: border(),
                                      boxShadow: [
                                        boxShadow(),
                                      ]),
                                  child: Icon(
                                    Icons.check,
                                    color: AppColor.blackColor,
                                    size: context.getSize.height * 0.040,
                                  ),
                                ),
                              )),
                            ],
                          )
                        ],
                      ));
                }),
          ),
        ),
      );
    },
  );
}

void hideOpenDialog({
  required BuildContext context,
}) {
  Navigator.of(context).pop();
}

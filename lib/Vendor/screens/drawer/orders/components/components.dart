import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/extensions/size_extension.dart';
import '../../../../../Utils/box_shadow.dart';
import '../../../../../constant/colors.dart';
import '../viewmodel/OrderViewModel.dart';


class UploadWorkPhotosWidget extends StatelessWidget {
  const UploadWorkPhotosWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetX<OrderViewModel>(
        init: OrderViewModel(),
        builder: (viewModel) {
          return Wrap(
            children: List.generate(
                5,
                    (index) => GestureDetector(
                  onTap: index < viewModel.imageFileList.length
                      ? () {
                    viewModel.selectedImage(true, index);
                  }
                      : () {
                    viewModel.selectedImage(false, 0);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        right: index == 5 - 1
                            ? 0
                            : context.getSize.width * 0.016),
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        image: index < viewModel.imageFileList.length
                            ? DecorationImage(
                            image: FileImage(
                              File(viewModel.imageFileList[index].path),
                            ),
                            fit: BoxFit.cover)
                            : null,
                        boxShadow: [boxShadow()],
                        color: AppColor.white),
                    child: index < viewModel.imageFileList.length
                        ? null
                        : const Center(
                      child: Icon(
                        Ionicons.camera_outline,
                        size: 10,
                      ),
                    ),
                  ),
                )),
          );
        });
  }
}
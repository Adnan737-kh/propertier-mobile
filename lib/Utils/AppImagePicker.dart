import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> showOption(BuildContext context) async {
  File? file;
  await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Please Choose One.",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              ListTile(
                onTap: () async {
                  final XFile? photo =
                  await ImagePicker().pickImage(source: ImageSource.camera);
                  if (photo != null) file = File(photo.path);
                  Get.back();
                },
                title: Text("Camera"),
                trailing: Icon(Icons.camera_alt_outlined),
              ),
              ListTile(
                  onTap: () async {
                    final XFile? photo = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (photo != null) file = File(photo.path);
                    Get.back();
                  },
                  title: Text("Gallery"),
                  trailing: Icon(Icons.image)),
            ],
          ),
        );
      });
  return file;
}
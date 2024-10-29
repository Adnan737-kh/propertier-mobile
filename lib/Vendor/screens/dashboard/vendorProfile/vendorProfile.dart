import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Vendor/screens/dashboard/vendorProfile/vendorProfileController.dart';
import 'package:propertier/Vendor/screens/dashboard/vendorProfile/vendorProfileWidget.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../App/Auth/Login/Model/user_login_model/user_login_model.dart';

class VendorProfile extends GetView<VendorProfileController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(context.getSize.width, context.getSize.height * 3),
          child: Obx(()=> controller.user.value.id == null? const SizedBox():vendorProfileAppBar(context, controller.user.value))
      ),
      body: FutureBuilder(future: controller.getProfile(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.data == null){
                return Center(
                  child: appText(title: "User Not Found", context: context),
                );
              }
              User user = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40,),
                      vendorProfileInformationTile(context, user),
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: appText(title: "User Not Found", context: context),
            );
          }
      ),
    );
  }
}
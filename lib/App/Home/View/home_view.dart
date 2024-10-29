import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Home/View/component/comercial_view.dart';
import 'package:propertier/App/Home/View/component/top_widget_with_appbar.dart';
import 'package:propertier/App/Home/ViewModel/home_view_model.dart';
import 'package:propertier/Utils/App%20Ad%20Mob/app_banner_ads.dart';
import 'package:propertier/Utils/App%20Ad%20Mob/app_interstitial_ads.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:url_launcher/url_launcher.dart';

enum PoropertiesAndVideoEnum {
  topselling,
  video,
  properties,
}

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final viewModel = Get.find<HomeViewModel>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColor.backgroundColor),
    );
    return Scaffold(
        body: Obx(
      () => FutureBuilder(
          future: viewModel.isHomeDataAvailable.value == false
              ? viewModel.getHomePageData(context: context)
              : null,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColor.buttonColor,
                ),
              );
            }
            return Stack(alignment: Alignment.center, children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: Platform.isAndroid
                        ? context.isPhone
                            ? context.getSize.height * (0.55 - 0.030)
                            : context.getSize.height * (0.4 - 0.030)
                        : context.isPhone
                            ? context.getSize.height * (0.48 - 0.030)
                            : context.getSize.height * (0.5 - 0.030),
                    flexibleSpace: FlexibleSpaceBar(
                      background:
                          homeAppBar(viewModel: viewModel, context: context),
                    ),
                  ),

                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        // Build the list of items
                        return ComercialView(viewModel: viewModel);
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: context.getSize.width * 0.030,
                bottom: context.getSize.height * 0.1,
                child: GestureDetector(
                    onTap: () async {
                      String url = "https://support.propertier.com.pk/";
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {}
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: AppColor.buttonColor,
                          shape: BoxShape.circle,
                          border: border(
                              color: const Color.fromRGBO(255, 255, 255, 0.80),
                              width: 5.1)),
                      child: Image.asset(Constant.customerCare),
                    )),
              ),
            ]);
          }),
    ));
  }
}

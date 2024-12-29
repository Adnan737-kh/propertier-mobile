import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:propertier/App/Services/Model/ServiceDashboardModel.dart';
import 'package:propertier/App/Services/Model/services_model.dart';
import 'package:propertier/App/Services/View/component/services_appbar.dart';
import 'package:propertier/App/Services/View/component/services_short_videos_tile.dart';
import 'package:propertier/App/Services/View/component/services_tile.dart';
import 'package:propertier/App/Services/View/component/services_video_tile.dart';
import 'package:propertier/App/Services/View/component/top_selling_services_tile.dart';
import 'package:propertier/App/Services/ViewModel/services_view_model.dart';
import 'package:propertier/Utils/grid_title_tile.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/Utils/text_botton.dart';
import 'package:propertier/RoutesAndBindings/app_routes.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../Customer/screens/AllServices/components/serviceTile.dart';
import '../../Home/View/home_view.dart';

class ServciesView extends StatelessWidget {
  ServciesView({super.key});
  final viewModel = Get.put(ServicesViewModel());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: AppColor.backgroundColor),
    );
    // viewModel.getAllParentServices(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: Platform.isAndroid
                ? context.getSize.height * (0.45)
                : context.getSize.height * (0.42),
            flexibleSpace: FlexibleSpaceBar(
              background: servciesAppBar(context, viewModel: viewModel),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                // Build the list of items
                return PopScope(
                  canPop: false,
                  // onPopInvoked: (val) {
                  //   // if (val == true) {
                  //   Get.offAllNamed(AppRoutes.navBarView);
                  //   // }
                  // },
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.getSize.width * 0.030,
                            vertical: context.getSize.height * 0.01),
                        child: Column(
                          children: [
                            Obx(() => viewModel.serviceDashboardModel.value !=
                                    null
                                ? GridView.builder(
                                    padding: const EdgeInsets.all(0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent:
                                          context.getSize.height * 0.18,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                    itemCount: viewModel.serviceDashboardModel
                                        .value?.randomServices?.length,
                                    itemBuilder: (context, index) {
                                      if (viewModel.serviceDashboardModel.value!
                                              .randomServices ==
                                          null) return SizedBox();
                                      return servicesTile(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.subServices,
                                              arguments: viewModel
                                                  .serviceDashboardModel
                                                  .value!
                                                  .randomServices?[index]);
                                        },
                                        service: viewModel.serviceDashboardModel
                                            .value!.randomServices![index],
                                        context: context,
                                      );
                                    })
                                : SizedBox()),
                            getHeight(context, 0.015),
                            textButton(
                                context: context,
                                title: 'Other',
                                onClick: () {
                                  Get.toNamed(AppRoutes.AllParentServices);
                                }),
                            // Nearby Services
                            getHeight(context, 0.015),
                            gridTitleTile(context,
                                // title: context.local.topSellingServices,
                                title: "Nearest Services", callBack: () {
                              Get.toNamed(AppRoutes.AllServicesScreen,
                                  arguments: viewModel.serviceDashboardModel
                                      .value?.nearbyServices);
                              // Get.toNamed(AppRoutes.propertiesAndVideoView,
                              //     arguments:
                              //         PoropertiesAndVideoEnum.topselling);
                            }, fontSize: 14),
                            getHeight(context, 0.008),
                            Obx(() => viewModel.serviceDashboardModel.value !=
                                    null
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(0),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisExtent:
                                                context.getSize.height * 0.18,
                                            crossAxisSpacing:
                                                context.getSize.width * 0.016),
                                    itemCount: viewModel.serviceDashboardModel
                                        .value?.nearbyServices?.length,
                                    itemBuilder: (context, index) {
                                      SellingServices service = viewModel
                                          .serviceDashboardModel
                                          .value!
                                          .nearbyServices![index];
                                      return ServicesBox(context, service,
                                          onClick: () {
                                        Get.toNamed(AppRoutes.ServiceDetail,
                                            arguments: service);
                                      });
                                    })
                                : SizedBox()),
                            // Top selling services
                            getHeight(context, 0.015),
                            Obx(() => viewModel.serviceDashboardModel.value !=
                                    null
                                ? Column(children: [
                                  if(viewModel
                                      .serviceDashboardModel
                                      .value
                                      !.topsellingServices
                                      != null && viewModel
                                      .serviceDashboardModel
                                      .value
                                  !.topsellingServices!.isNotEmpty)
                                    gridTitleTile(context,
                                        // title: context.local.topSellingServices,
                                        title: "Top Selling Services",
                                        callBack: () {
                                      Get.toNamed(AppRoutes.AllServicesScreen,
                                          arguments: viewModel
                                              .serviceDashboardModel
                                              .value
                                              ?.topsellingServices);

                                      // Get.toNamed(AppRoutes.propertiesAndVideoView,
                                      //     arguments:
                                      //         PoropertiesAndVideoEnum.topselling);
                                    }, fontSize: 14),
                                    getHeight(context, 0.008),
                                    GridView.builder(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.all(0),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisExtent:
                                                    context.getSize.height *
                                                        0.18,
                                                crossAxisSpacing:
                                                    context.getSize.width *
                                                        0.016),
                                        itemCount: viewModel
                                            .serviceDashboardModel
                                            .value
                                            ?.topsellingServices
                                            ?.length,
                                        itemBuilder: (context, index) {
                                          SellingServices service = viewModel
                                              .serviceDashboardModel
                                              .value!
                                              .topsellingServices![index];
                                          return ServicesBox(context, service,
                                              onClick: () {
                                            Get.toNamed(AppRoutes.ServiceDetail,
                                                arguments: service);
                                          });
                                        })
                                  ])
                                : SizedBox()),
                            // Random Services
                            SizedBox(
                              height: 10,
                            ),
                            FutureBuilder(
                                future:
                                    viewModel.getPaginationServices(context),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColor.buttonColor,
                                      ),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    ServicePaginationModel? serviceModel =
                                        snapshot.data;
                                    List<SellingServices> services =
                                        serviceModel?.results ?? [];
                                    return Column(
                                      children: [
                                        gridTitleTile(context,
                                            // title: context.local.topSellingServices,
                                            title: "Other Services",
                                            callBack: () {
                                          Get.toNamed(
                                              AppRoutes.AllServicesScreen,
                                              arguments: services);
                                        }, fontSize: 14),
                                        ListView.builder(
                                            physics: const BouncingScrollPhysics(),
                                            padding: const EdgeInsets.all(0),
                                            shrinkWrap: true,
                                            itemCount: services.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                child: serviceTile(context,
                                                    service: services[index]),
                                              );
                                            }),
                                      ],
                                    );
                                  }
                                  return SizedBox();
                                })
                          ],
                        ),
                      ),
                      // FutureBuilder(
                      //     future: viewModel.getFixedServices(context),
                      //     builder: (context, snapshot){
                      //       if(snapshot.connectionState == ConnectionState.waiting){
                      //         return const Center(
                      //           child: CircularProgressIndicator(
                      //             color: AppColor.buttonColor,
                      //           ),
                      //         );
                      //       }
                      //       if(snapshot.connectionState == ConnectionState.done){
                      //         List<FixedServicesModel> services = snapshot.data??[];
                      //         return GridView.builder(
                      //             shrinkWrap: true,
                      //             padding: const EdgeInsets.all(0),
                      //             physics: const NeverScrollableScrollPhysics(),
                      //             gridDelegate:
                      //             SliverGridDelegateWithFixedCrossAxisCount(
                      //                 crossAxisCount: 3,
                      //                 mainAxisExtent:
                      //                 context.getSize.height * 0.18,
                      //                 crossAxisSpacing:
                      //                 context.getSize.width * 0.016),
                      //             itemCount: services.length,
                      //             itemBuilder: (context, index) {
                      //               FixedServicesModel service = services[index];
                      //               return fixedPriceServicesBox(context, service,
                      //                   onClick: () {
                      //                     Get.toNamed(AppRoutes.serviceDetail, arguments: service);
                      //                   });
                      //             });
                      //       }
                      //       return SizedBox();
                      //     }
                      // ),
                      // getHeight(context, 0.015),
                      // gridTitleTile(context,
                      //     title: context.local.topSellingServices,
                      //     callBack: () {},
                      //     fontSize: 14),
                      // getHeight(context, 0.008),
                      // SizedBox(
                      //   height: context.getSize.height * 0.2,
                      //   width: context.getSize.width,
                      //   child: ListView.builder(
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: context.getSize.width * 0.082),
                      //       shrinkWrap: true,
                      //       itemCount: viewModel.topSellingList.length,
                      //       scrollDirection: Axis.horizontal,
                      //       itemBuilder: (context, index) {
                      //         ServicesModel services =
                      //             viewModel.topSellingList[index];
                      //         return topSellingServices2(context, services,
                      //             onClick: () {}
                      //         );
                      //       }),
                      // ),
                      getHeight(context, 0.015),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: context.getSize.width * 0.09),
                      //   child: Column(
                      //     children: [
                      //       ServicesShortVideoTile(viewModel: viewModel),
                      //       getHeight(context, 0.015),
                      //       gridTitleTile(context,
                      //           title: context.local.videos, callBack: () {}),
                      //       getHeight(context, 0.010),
                      //       const ServicesVideoTile(),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

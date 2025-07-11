import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:propertier/App/ServicesMap/View/component/cancel_service_dialog.dart';
import 'package:propertier/App/ServicesMap/ViewModel/services_map_view_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/constant/constant.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../ServicesSearch/model/VendorResponseModel.dart';

// ignore: must_be_immutable
class ServicesMapView extends StatelessWidget {
  ServicesMapView({super.key});
  VendorOfferModel offer = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return GetX<ServicesMapViewModel>(
        init: ServicesMapViewModel(BitmapDescriptor.defaultMarker,),
        builder: (viewModel) {
          viewModel.startTracking(offer.bidResponse?.vendor?.id.toString());
          return Scaffold(
            backgroundColor: const Color.fromRGBO(19, 26, 34, 1),
            body: viewModel.showMap == false
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.buttonColor,
                    ),
                  )
                : PopScope(
                    canPop: true,
                    onPopInvoked: (val) {
                      if (val == true) {
                        print("is Val $val");
                        viewModel.isShowCancelButton(true);
                      }
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          height: context.getSize.height,
                          width: context.getSize.width,
                          child:Obx(()=>  GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: viewModel.markerPosition.value,
                              zoom: 14.0,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              viewModel.onMapCreated(controller);

                              // Load custom marker icon after map is created
                              BitmapDescriptor.fromAssetImage(
                                const ImageConfiguration(size: Size(48, 48)),
                                'assets/icons/person.png',
                              ).then((icon) {
                                viewModel.customIcon = icon;
                              });
                            },
                            markers: {
                              Marker(
                                markerId: const MarkerId('animated_marker'),
                                infoWindow:const  InfoWindow(title: "Vendor Location"),
                                position: viewModel.markerPosition.value,
                                // icon: viewModel.customIcon,
                              ),
                            },
                          )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.getSize.width * 0.090,
                              vertical: context.getSize.height * 0.080),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Get.toNamed(AppRoutes.servicesCompleteView,arguments: service);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: context.getSize.width * 0.016,
                                      vertical: context.getSize.height * 0.008),
                                  decoration: BoxDecoration(
                                      border: border(),
                                      borderRadius: BorderRadius.circular(3),
                                      boxShadow: [boxShadow()],
                                      color: AppColor.white),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius:
                                                context.getSize.height * 0.016,
                                            backgroundImage: const NetworkImage(
                                                Constant.dummyImage),
                                          ),
                                          getWidth(context, 0.010),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                  title: offer.bidResponse?.vendor?.name??"",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  ),
                                              getHeight(context, 0.002),
                                              CustomText(
                                                  title: context.local.on_the_way,
                                                  fontSize: 10,
                                                  colorOpecity: 0.7,
                                                  fontWeight: FontWeight.w500,
                                                  ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            child: const Icon(Ionicons.call,
                                                color: Color(0xff109B0E)),
                                          ),
                                          getWidth(context, 0.030),
                                          GestureDetector(
                                            onTap: () {},
                                            child: const Icon(
                                                Ionicons.chatbox_ellipses,
                                                color: AppColor.buttonColor),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (viewModel.showCancelButton == true)
                                GestureDetector(
                                  onTap: () {
                                    showCustomPopup(context,
                                        viewModel: viewModel,
                                        serviceName: offer.bidResponse?.vendor?.name??"",
                                    id: offer.bidResponse?.id.toString()??"");
                                    viewModel.isShowCancelButton(false);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            context.getSize.width * 0.040,
                                        vertical:
                                            context.getSize.height * 0.003),
                                    decoration: BoxDecoration(
                                        color: const Color(0xff109B0E),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: CustomText(
                                        title: context.local.cancel,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.white,
                                        ),
                                  ),
                                )
                              else
                                const SizedBox.shrink(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          );
        });
  }
}

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:propertier/App/What%20are%20you%20searching/ViewModel/what_are_viewmodel.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/textStyle.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../View/Components/custom_botton_wryf.dart';
import '../../View/what_are_you_search_view.dart';

class MapViewWRYSF extends StatefulWidget {
  const MapViewWRYSF({super.key});

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MapViewWRYSF> {
  final viewModel = Get.put(WhatAreYouSearchViewModel());

  // final Completer<GoogleMapController> _controller = Completer();

  // var _currentPostion = const LatLng(0, 0);
  // on below line we have specified camera position
  // static const CameraPosition _kGoogle = CameraPosition(
  //   target: LatLng(33.738045, 73.084488),
  //   zoom: 14.4746,
  // );

  // on below line we have created the list of markers
  // final List<Marker> _markers = <Marker>[
  //   const Marker(
  //       markerId: MarkerId('1'),
  //       position: LatLng(33.738045, 73.084488),
  //       infoWindow: InfoWindow(
  //         title: 'Islamabad',
  //       )),
  // ];

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      if (kDebugMode) {
        print("ERROR$error");
      }
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    Set<Circle> circles = {
      Circle(
          circleId: const CircleId("Circle_id"),
          center: LatLng(viewModel.latitude, viewModel.longitude),
          radius: viewModel.areaValue.value,
          fillColor: AppColor.buttonColor.withOpacity(0.3),
          strokeColor: AppColor.buttonColor,
          strokeWidth: 2),
      Circle(
          circleId: const CircleId("Circle_id_islamabad"),
          center: const LatLng(33.738045, 73.084488),
          radius: viewModel.areaValue.value,
          fillColor: AppColor.buttonColor.withOpacity(0.3),
          strokeColor: AppColor.buttonColor,
          strokeWidth: 2),
    };
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Stack(
              children: [
                SafeArea(
                  // on below line creating google maps
                  child: GoogleMap(
                    circles: circles,
                    // on below line setting camera position
                    initialCameraPosition:
                        viewModel.initialCameraPosition.value,
                    // on below line we are setting markers on the map
                    markers: Set<Marker>.of(viewModel.markerPosition),
                    // on below line specifying map type.
                    mapType: MapType.normal,
                    // on below line setting user location enabled.
                    myLocationEnabled: true,
                    // on below line setting compass enabled.
                    compassEnabled: true,
                    // on below line specifying controller on map complete.
                    onTap: (argument) {},
                    mapToolbarEnabled: true,
                    onMapCreated: viewModel.onMapCreated,
                  ),
                ),
                appBarWithSearch(context),
              ],
            )),
      ),
      // on pressing floating action button the camera will take to user current location
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColor.darkGreyColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(30)),
              child: CustomButton(
                  buttonColor: AppColor.buttonColor,
                  textColor: AppColor.blackColor,
                  height: 43,
                  fontSize: 16,
                  radius: 30,
                  fontWeight: FontWeight.bold,
                  title: "Done",
                  onTap: () {
                    Get.back();
                  }),
            )
          ],
        ),
      ),
    );
  }

  SizedBox appBarWithSearch(BuildContext context) {
    return SizedBox(
      height: context.getSize.height * 0.45,
      child: Stack(
        children: [
          Container(
            height: context.getSize.height * 0.14,
            padding:
                EdgeInsets.symmetric(horizontal: context.getSize.width * 0.040),
            decoration: const BoxDecoration(
                color: AppColor.buttonColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 4, 0, 5),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back_ios)),
                ),
                const Gap(5),
                Expanded(
                  child: SizedBox(
                    height: 34,
                    child: TextFormField(
                      controller: viewModel.searchAddressTextController,
                      onChanged: (value) {
                        viewModel.searchPlaces(value);
                        setState(() {});
                      },
                      style: textStyle(context: context, fontSize: 12),
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          hintText: "Search here ...",
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          filled: true,
                          fillColor: AppColor.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              bottom: context.getSize.height * 0.24,
              left: context.getSize.width * 0.040,
              right: context.getSize.width * 0.040,
              child: Column(
                children: [
                  Container(
                    width: context.width,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: const BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    title: context.local.area_range,
                                    fontSize: 12),
                                CustomText(
                                    title:
                                        "${viewModel.areaValue.value.toInt()} Meter",
                                    fontSize: 12,
                                     ),
                              ],
                            )),
                        Obx(
                          () => SfSlider(
                            min: 0.0,
                            max: 200.0,
                            value: viewModel.areaValue.value,
                            interval: 20,
                            stepSize: 1,
                            enableTooltip: true,
                            activeColor: AppColor.buttonColor,
                            minorTicksPerInterval: 1,
                            onChanged: (dynamic value) {
                              viewModel.areaValue.value = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          viewModel.places.isNotEmpty
              ? Positioned(
                  bottom: context.getSize.height * 0.0,
                  left: context.getSize.width * 0.040,
                  right: context.getSize.width * 0.040,
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: DestinationSection()))
              : const Positioned(bottom: 0, child: SizedBox())
        ],
      ),
    );
  }
}

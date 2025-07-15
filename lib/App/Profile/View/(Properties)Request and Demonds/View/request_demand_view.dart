import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:propertier/App/Profile/View/(Properties)Request%20and%20Demonds/Detail%20page/View/r_d_detail_view.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/divider.dart';
import 'package:propertier/extensions/localization_extension.dart';
// import 'package:order_tracker_zen/order_tracker_zen.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../../Utils/appbar.dart';
import '../../../../../Utils/height_width_box.dart';
import '../../../../../constant/colors.dart';
import '../Components/request_demand_toggle.dart';
import '../Components/stepper_order_view.dart';
import '../Model/request_model.dart';
import '../Service/request_demand_services.dart';
import '../ViewModel/request_demand_viewmodel.dart';

class RequestDemandView extends GetView<RequestDemandViewModel> {
  const RequestDemandView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.getSize.width * 0.060),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getHeight(context, 0.065),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customAppBar(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        context: context,
                        onTap: () {
                          Get.back();
                        },
                        title: 'Request Properties'),

                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        customButton: Icon(
                          Icons.tune,
                          size: context.getSize.width * 0.050,
                          // color: Colors.red,
                        ),
                        items: [
                          ...MenuItems.firstItems.map(
                            (item) => DropdownMenuItem<MenuItem>(
                              value: item,
                              child: MenuItems.buildItem(item),
                            ),
                          ),
                          const DropdownMenuItem<Divider>(
                              enabled: false,
                              child: Divider(
                                color: Colors.transparent,
                                height: 0,
                              )),
                          ...MenuItems.secondItems.map(
                            (item) => DropdownMenuItem<MenuItem>(
                              value: item,
                              child: MenuItems.buildItem(item),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          MenuItems.onChanged(context, value! as MenuItem);
                        },
                        dropdownStyleData: DropdownStyleData(
                          width: 110,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            // color: Colors.redAccent,
                          ),
                          offset: const Offset(0, 8),
                        ),
                        menuItemStyleData: MenuItemStyleData(
                          customHeights: [
                            ...List<double>.filled(
                                MenuItems.firstItems.length, 48),
                            8,
                            ...List<double>.filled(
                                MenuItems.secondItems.length, 48),
                          ],
                          padding: const EdgeInsets.only(left: 16, right: 16),
                        ),
                      ),
                    ),

                    // const Icon(Icons.tune)
                  ],
                ),
                getHeight(context, 0.045),
                RequestedDemandToggle(
                  values: const ["Received Requests", "Demanded Requests"],
                  onToggleCallback: (value) {
                    controller.setTabSelect(!controller.tabSelect.value);
                  },
                ),
                getHeight(context, 0.025),
                Obx(
                  () => !controller.tabSelect.value
                      ? FutureBuilder<CRequests>(
                          future: RequestDemandServices().requestService(
                              context: context,
                              agentId: GetStorage().read("id").toString()),
                          builder: (context, snapshot) {
                            return snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.data != null
                                ? snapshot.data!.nearbyRequests != null
                                    ? OrderTrackerZen(
                                        tracker_data: snapshot
                                            .data!.nearbyRequests!
                                            .map((e) => TrackerData(
                                                  onTap: () {
                                                    Get.to(RDDetailView(
                                                      property: e,
                                                      appBar:
                                                          "Request Properties",
                                                    ));
                                                  },
                                                  dayDate: DateFormat.d()
                                                      .format(e.createdAt!),
                                                  monthDate: DateFormat.MMM()
                                                      .format(e.createdAt!),
                                                  title: e.name.toString(),
                                                  date: "Received Request",
                                                  tracker_details: [
                                                    TrackerDetails(
                                                      content: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                  child: CustomText(
                                                                      title:
                                                                          "${e.city}, ${e.area}",
                                                                      fontSize:
                                                                          10,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,)),
                                                              CustomText(
                                                                  title: DateFormat
                                                                          .jm()
                                                                      .format(e
                                                                          .createdAt!),
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  colorOpecity:
                                                                      0.6,
                                                              )
                                                            ],
                                                          ),
                                                          getHeight(
                                                              context, 0.008),
                                                          divider(
                                                              context: context)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                            .toList())
                                    : CustomText(
                                        title: context.local.no_data, )
                                : snapshot.error != null
                                    ? const Text('Error generating thumbnail')
                                    : const Center(
                                        child: CircularProgressIndicator(
                                        color: AppColor.buttonColor,
                                      ));
                          })
                      : FutureBuilder<CRequests>(
                          future: RequestDemandServices().requestService(
                              context: context,
                              agentId: GetStorage().read("id").toString()),
                          builder: (context, snapshot) {
                            return snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.data != null
                                ? snapshot.data!.agentRequests != null
                                    ? OrderTrackerZen(
                                        tracker_data: snapshot
                                            .data!.agentRequests!
                                            .map((e) => TrackerData(
                                                  onTap: () {
                                                    Get.to(RDDetailView(
                                                      property: e,
                                                      appBar:
                                                          "Demand Properties",
                                                    ));
                                                  },
                                                  dayDate: DateFormat.d()
                                                      .format(e.createdAt!),
                                                  monthDate: DateFormat.MMM()
                                                      .format(e.createdAt!),
                                                  title: e.name.toString(),
                                                  date: "Demanded Request",
                                                  tracker_details: [
                                                    TrackerDetails(
                                                      content: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                  child: CustomText(
                                                                      title:
                                                                          "${e.city}, ${e.area}",
                                                                      fontSize:
                                                                          10,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400)),
                                                              CustomText(
                                                                  title: DateFormat
                                                                          .jm()
                                                                      .format(e
                                                                          .createdAt!),
                                                                  fontSize: 8,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  colorOpecity:
                                                                      0.6)
                                                            ],
                                                          ),
                                                          getHeight(
                                                              context, 0.008),
                                                          divider(
                                                              context: context)
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                            .toList())
                                    : CustomText(title: context.local.no_data)
                                : snapshot.error != null
                                    ? const Text('Error generating thumbnail')
                                    : const Center(
                                        child: CircularProgressIndicator(
                                        color: AppColor.buttonColor,
                                      ));
                          }),
                ),
                getHeight(context, 0.06),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [month];
  static const List<MenuItem> secondItems = [week];

  static const month = MenuItem(text: 'This Month', icon: Icons.delete);
  static const week = MenuItem(text: 'This Week', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        // Icon(item.icon, color: Colors.grey, size: 22),
        // const SizedBox(
        //   width: 10,
        // ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
                fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      // case MenuItems.home:
      //   //Do something
      //   break;
      case MenuItems.month:
        //Do something
        break;
      case MenuItems.week:
        //Do something
        break;
      // case MenuItems.share:
      //   //Do something
      //   break;
    }
  }
}

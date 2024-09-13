import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/divider.dart';
// import 'package:order_tracker_zen/order_tracker_zen.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../Utils/appbar.dart';
import '../../../../Utils/height_width_box.dart';
import '../Components/stepper_order_view.dart';
import '../ViewModel/searched_activity_viewmodel.dart';

class SearchedActivityView extends GetView<SearchedActivityViewModel> {
  const SearchedActivityView({super.key});

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
                        title: 'Post You Searched For'),

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
                OrderTrackerZen(
                  tracker_data: [
                    TrackerData(
                      dayDate: "1",
                      monthDate: "Apr",
                      title: "Anees Shahzad",
                      date: "Searched a Post",
                      tracker_details: [
                        TrackerDetails(
                          content: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  appText(
                                      title: "7 Marla Houser Bahria pase 8",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      context: context),
                                  appText(
                                      title: "01:20 Pm",
                                      fontSize: 8,
                                      fontWeight: FontWeight.w400,
                                      colorOpecity: 0.6,
                                      context: context)
                                ],
                              ),
                              getHeight(context, 0.008),
                              divider(context: context)
                            ],
                          ),
                        ),
                      ],
                    ),
                    TrackerData(
                      dayDate: "2",
                      monthDate: "Mar",
                      title: "Anees Shahzad",
                      date: "Searched a Post",
                      tracker_details: [
                        TrackerDetails(
                          content: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  appText(
                                      title: "7 Marla Houser Bahria pase 8",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      context: context),
                                  appText(
                                      title: "01:20 Pm",
                                      fontSize: 8,
                                      fontWeight: FontWeight.w400,
                                      colorOpecity: 0.6,
                                      context: context)
                                ],
                              ),
                              getHeight(context, 0.008),
                              divider(context: context)
                            ],
                          ),
                        ),
                      ],
                    ),
                    TrackerData(
                      dayDate: "8",
                      monthDate: "Jan",
                      title: "Anees Shahzad",
                      date: "Searched a Post",
                      tracker_details: [
                        TrackerDetails(
                          content: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  appText(
                                      title: "7 Marla Houser Bahria pase 8",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      context: context),
                                  appText(
                                      title: "01:20 Pm",
                                      fontSize: 8,
                                      fontWeight: FontWeight.w400,
                                      colorOpecity: 0.6,
                                      context: context)
                                ],
                              ),
                              getHeight(context, 0.008),
                              divider(context: context)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
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
                color: Colors.grey, fontWeight: FontWeight.bold),
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

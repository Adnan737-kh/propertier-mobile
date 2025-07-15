import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:propertier/extensions/localization_extension.dart';

import '../../../Utils/app_text.dart';
import '../../../Utils/divider.dart';
import '../../../Utils/height_width_box.dart';

Widget privacyTile({required BuildContext context, required String title}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: const Icon(
            Icons.more_horiz,
            size: 22,
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
                  height: 2,
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
              ...List<double>.filled(MenuItems.firstItems.length, 48),
              8,
              ...List<double>.filled(MenuItems.secondItems.length, 48),
            ],
            padding: const EdgeInsets.only(left: 16, right: 16),
          ),
        ),
      ),
      getHeight(context, 0.015),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              title: title,
              fontSize: 14,
              colorOpecity: 0.6,
              fontWeight: FontWeight.bold),
          CustomText(
              title: context.local.only_me,
              fontSize: 12,
              colorOpecity: 0.6,
              fontWeight: FontWeight.w400),
        ],
      ),
      getHeight(context, 0.015),
      divider(context: context),
    ],
  );
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

  static const month = MenuItem(text: 'Only me', icon: Icons.delete);
  static const week = MenuItem(text: 'Every one', icon: Icons.logout);

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
            style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.normal),
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

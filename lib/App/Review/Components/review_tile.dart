import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../constant/colors.dart';
import '../../../constant/constant.dart';
import '../../../Utils/app_text.dart';

Widget reviewTile({
  required String title,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(Constant.dummayImage),
                ),
                const Gap(8),
                appText(title: title, fontSize: 12, context: context)
              ],
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: Icon(
                  Icons.more_vert,
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
                      enabled: false, child: Divider()),
                ],
                onChanged: (value) {
                  MenuItems.onChanged(context, value! as MenuItem);
                },
                dropdownStyleData: DropdownStyleData(
                  width: 150,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: Colors.redAccent,
                  ),
                  offset: const Offset(0, 8),
                ),
                menuItemStyleData: MenuItemStyleData(
                  customHeights: [
                    ...List<double>.filled(MenuItems.firstItems.length, 48),
                    8,
                  ],
                  padding: const EdgeInsets.only(left: 16, right: 16),
                ),
              ),
            ),
          ],
        ),
        const Gap(8),
        Row(
          children: [
            RatingBarIndicator(
              rating: 4,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              unratedColor: AppColor.greenColor,
              itemCount: 5,
              itemSize: 15.0,
              direction: Axis.horizontal,
            ),
            const Gap(8),
            appText(
                title: "10-2-24",
                context: context,
                fontSize: 10,
                fontWeight: FontWeight.normal,
                colorOpecity: 0.5)
          ],
        ),
        const Gap(8),
        appText(
            // overflow: TextOverflow.clip,
            title:
                "This Privacy Policy sets out the commitment of Propertier Marketing PVT Ltd, the developer of Propertier, to protecting the privacy of our users. Our goal is to provide a safe and secure platform for users to search for and find real estate information.",
            context: context,
            fontSize: 14,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.normal,
            colorOpecity: 0.4)
      ],
    ),
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
  static const List<MenuItem> firstItems = [settings];

  static const settings = MenuItem(text: 'Delete', icon: Icons.delete);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: AppColor.blackColor, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.settings:
        //Do something
        break;
    }
  }
}

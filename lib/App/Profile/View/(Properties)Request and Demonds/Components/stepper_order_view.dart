// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace, prefer_typing_uninitialized_variables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:propertier/extensions/size_extension.dart';

import '../../../../../constant/constant.dart';

/// A data model representing a single tracker.
///
/// This model includes a title, date, and list of tracker details.
class TrackerData {
  /// The title of the tracker data.
  final String title;
  final String dayDate;
  final String monthDate;
  final Function()? onTap;

  /// The date associated with the tracker data.
  final String date;

  /// A list of tracker details.
  final List<TrackerDetails> tracker_details;

  /// Creates a new tracker data instance.
  ///
  /// The [title], [date], and [tracker_details] must not be null.
  TrackerData({
    this.onTap,
    required this.title,
    required this.date,
    required this.dayDate,
    required this.monthDate,
    required this.tracker_details,
  });
}

/// A data model representing the details of a tracker.
///
/// This model includes a title and a datetime.
class TrackerDetails {
  /// The title of the tracker details.
  final Widget content;

  /// The datetime associated with the tracker details.

  /// Creates a new tracker details instance.
  ///
  /// The [title] and [datetime] must not be null.
  TrackerDetails({
    required this.content,
  });
}

/// A stateless widget that displays an order tracking progress.
///
/// This widget takes a list of `TrackerData` as input and displays a
/// progress indicator with customizable colors and animation duration.
class OrderTrackerZen extends StatelessWidget {
  /// A list of tracker data.
  final List<TrackerData> tracker_data;

  /// The success color used in the widget.
  final Color? success_color;

  /// The background color used in the widget.
  final Color? background_color;

  /// The screen background color used in the widget.
  final Color? screen_background_color;

  /// The primary text color used in the widget.
  final Color? text_primary_color;

  /// The secondary text color used in the widget.
  final Color? text_secondary_color;

  /// The duration of the animation in milliseconds.
  final int animation_duration;

  /// If the widget is shrinked or not. If true, the widget will be shrinked and will only show title and time.
  final bool isShrinked;

  /// Creates an OrderTrackerZen widget.
  ///
  /// The [tracker_data] must not be null, and the [animation_duration] must be a positive integer.
  const OrderTrackerZen({
    super.key,
    required this.tracker_data,
    this.success_color,
    this.background_color,
    this.screen_background_color,
    this.text_primary_color,
    this.text_secondary_color,
    this.animation_duration = 1500,
    this.isShrinked = false,
  });

  @override
  Widget build(BuildContext context) {
    // Builds the list of tracker items
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var data = tracker_data[index];
        // Animate the status line
        return InkWell(
          onTap: data.onTap,
          child: TweenAnimationBuilder(
            tween: Tween<double>(
              begin: 0,
              end: tracker_data.length.toDouble(),
            ),
            duration: Duration(
              milliseconds: animation_duration * tracker_data.length,
            ),
            builder: (context, value, child) {
              // Build the main tracker item
              return TweenAnimationBuilder(
                builder: (context, val, child) {
                  return val == 1 || val == 0
                      ? OrderTrackerListItem(
                          historyDate: HistoryDate(
                            isShrinked: isShrinked,
                            text_primary_color: text_primary_color,
                            text_secondary_color: text_secondary_color,
                            MonthDate: tracker_data[index].monthDate,
                            dayDate: tracker_data[index].dayDate,
                          ),
                          success_color: success_color,
                          background_color: background_color,
                          screen_background_color: screen_background_color,
                          title: OrderTitleAndDate(
                            isShrinked: isShrinked,
                            title: data.title,
                            date: data.date,
                            text_primary_color: text_primary_color,
                            text_secondary_color: text_secondary_color,
                          ),
                          detailListItems: isShrinked
                              ? []
                              : [
                                  for (var i = 0;
                                      i < data.tracker_details.length;
                                      i++)
                                    OrderTrackerDetails(
                                      content: data.tracker_details[i].content,
                                    ),
                                ],
                          isLastItem: index == tracker_data.length - 1,
                          showLine: value > index,
                        )
                      : Container();
                },
                tween: Tween<double>(
                  begin: isShrinked ? 0 : 1,
                  end: isShrinked ? 1 : 0,
                ),
                duration: Duration(
                  milliseconds: 50,
                ),
              );
            },
          ),
        );
      },
      itemCount: tracker_data.length,
      padding: EdgeInsets.zero,
    );
  }
}

/// A stateful widget representing a single order tracker list item.
///
/// This widget displays a title, date, and details for a single order tracker item.
class OrderTrackerListItem extends StatefulWidget {
  /// The title and date widget of the main order status widget.
  final OrderTitleAndDate title;

  final HistoryDate historyDate;

  /// A list of order tracker details.
  final List<OrderTrackerDetails>? detailListItems;

  /// The success color used in the widget.
  final Color? success_color;

  /// The background color used in the widget.
  final Color? background_color;

  /// The screen background color used in the widget.
  final Color? screen_background_color;

  /// This is true if it is the last item in the list.
  final bool isLastItem;

  // This is true if the status line should be shown.
  final bool showLine;

  /// Creates an OrderTrackerListItem widget.
  ///
  /// The [title] must not be null, [isLastItem] and [showLine] default to false.
  const OrderTrackerListItem({
    super.key,
    required this.title,
    this.detailListItems,
    this.isLastItem = false,
    this.showLine = false,
    required this.historyDate,
    this.success_color,
    this.background_color,
    this.screen_background_color,
  });

  @override
  State<OrderTrackerListItem> createState() => _OrderTrackerListItemState();
}

class _OrderTrackerListItemState extends State<OrderTrackerListItem> {
  /// The key of the row widget. Used to get the height of the row.
  GlobalKey rowKey = GlobalKey();

  /// Gets the height of the row.
  double getRowHeight() {
    final RenderBox? rowRenderBox =
        rowKey.currentContext?.findRenderObject() as RenderBox?;
    return rowRenderBox?.size.height ?? 0.0;
  }

  // This is the height of the row, it shall be initialized later in the build method.
  var rowHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        rowHeight = getRowHeight();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.isLastItem
            ? Container()
            : Padding(
                padding: EdgeInsets.only(
                  left: 55,
                ),
                child: Container(
                  width: 2,
                  height: rowHeight,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: TweenAnimationBuilder(
                      builder: (context, value, child) {
                        return LinearProgressIndicator(
                          value: value,
                          color: widget.success_color ?? Colors.blueGrey,
                          backgroundColor:
                              widget.background_color ?? Colors.grey[400],
                        );
                      },
                      tween:
                          Tween<double>(begin: 0, end: widget.showLine ? 1 : 0),
                      duration: Duration(milliseconds: 1500),
                    ),
                  ),
                ),
              ),
        Row(
          key: rowKey,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 50, child: widget.historyDate),

            // Dot widget
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: widget.success_color ?? Colors.blueGrey,
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.screen_background_color ?? Colors.white,
                  width: 2,
                ),
              ),
            ),
            SizedBox(width: 10),
            const CircleAvatar(
              radius: 10,
              backgroundImage: NetworkImage(Constant.dummayImage),
            ),
            // Title and date widget
            Expanded(
              child: TweenAnimationBuilder(
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.title,
                          widget.detailListItems == null
                              ? SizedBox()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: widget.detailListItems!,
                                ),
                          widget.detailListItems == null
                              ? SizedBox()
                              : SizedBox(height: widget.isLastItem ? 0 : 13),
                        ],
                      ),
                    ),
                  );
                },
                tween: Tween<double>(
                  begin: 0.4,
                  end: widget.showLine ? 1 : 0.4,
                ),
                duration: Duration(milliseconds: 500),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// A stateless widget representing the details of an order tracker.
///
/// This widget displays a title and a datetime.
class OrderTrackerDetails extends StatelessWidget {
  /// The title of the order tracker details.
  final Widget content;

  /// Creates an OrderTrackerDetails widget.
  ///
  /// The [title] and [datetime] must not be null.
  const OrderTrackerDetails({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: content,
    );
  }
}

/// A stateless widget representing the title and date of an order tracker.
///
/// This widget displays a title and a date.
class OrderTitleAndDate extends StatelessWidget {
  /// The title of the order tracker.
  final title;

  /// The date associated with the order tracker.
  final date;

  /// The primary text color used in the widget.
  final Color? text_primary_color;

  /// The secondary text color used in the widget.
  final Color? text_secondary_color;

  /// If the widget is shrinked or not. If true, the widget will be shrinked and will only show title and time.
  final bool isShrinked;

  /// Creates an OrderTitleAndDate widget.
  ///
  /// The [title] and [date] must not be null.
  const OrderTitleAndDate({
    super.key,
    required this.title,
    required this.date,
    this.text_primary_color,
    this.text_secondary_color,
    this.isShrinked = false,
  });

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: text_primary_color ?? Colors.black.withOpacity(0.6),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: isShrinked ? 0 : 5, height: isShrinked ? 5 : 0),
          Text(
            date,
            style: TextStyle(
              color: text_secondary_color ?? Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: Icon(
            Icons.more_horiz,
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
            ],
            padding: const EdgeInsets.only(left: 16, right: 16),
          ),
        ),
      ),
    ];
    return Padding(
      padding: EdgeInsets.only(
          left: 0, right: 0, bottom: isShrinked ? 0 : 8, top: 0),
      child: isShrinked
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
    );
  }
}

class HistoryDate extends StatelessWidget {
  /// The date associated with the order tracker.
  final dayDate;
  final MonthDate;

  /// The primary text color used in the widget.
  final Color? text_primary_color;

  /// The secondary text color used in the widget.
  final Color? text_secondary_color;

  /// If the widget is shrinked or not. If true, the widget will be shrinked and will only show title and time.
  final bool isShrinked;

  /// Creates an OrderTitleAndDate widget.
  ///
  /// The [title] and [date] must not be null.
  const HistoryDate({
    super.key,
    this.dayDate,
    this.MonthDate,
    this.text_primary_color,
    this.text_secondary_color,
    this.isShrinked = false,
  });

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      Text(
        dayDate,
        style: TextStyle(
          color: text_primary_color ?? Colors.black.withOpacity(0.6),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(width: isShrinked ? 0 : 5, height: isShrinked ? 5 : 0),
      Text(
        MonthDate,
        style: TextStyle(
          color: text_secondary_color ?? Colors.grey,
          fontSize: isShrinked ? 13 : 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    ];
    return Padding(
      padding: EdgeInsets.only(
          left: 8, right: 8, bottom: isShrinked ? 0 : 8, top: 0),
      child: isShrinked
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
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
  static const List<MenuItem> firstItems = [settings];
  // static const List<MenuItem> secondItems = [logout];

  static const settings = MenuItem(text: 'Delete', icon: Icons.delete);
  // static const logout = MenuItem(text: 'Public  ', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.grey, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
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
      case MenuItems.settings:
        //Do something
        break;
      // case MenuItems.share:
      //   //Do something
      //   break;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:propertier/App/Analytics/Model/chart_data_model.dart';
import 'package:propertier/App/Analytics/Model/chart_subtitle_model.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/drop_down_input.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/localization_extension.dart';
import 'package:propertier/extensions/size_extension.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

Widget multiColumnChartTile(
  BuildContext context, {
  required String title,
  required String dropDownValue,
  required List<ChartSubtitleModel> subtitleList,
  required List<String> dropDownList,
  required Function(String) dropDownCallBack,
  required VoidCallback viewDetailsCallBack,
  required List<SalesData> income,
  required List<SalesData> expense,
}) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
            border: border(),
            boxShadow: [
              boxShadow(),
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        title: title,
                        color: AppColor.darkBack,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                            subtitleList.length,
                            (index) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: index == 0 ? 0 : 10, right: 5),
                                      height: 4,
                                      width: 4,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: subtitleList[index].color),
                                    ),
                                    CustomText(
                                        title: subtitleList[index].subtitle,
                                        color: AppColor.darkBack,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ],
                                )))
                  ],
                ),
                AppDropdownInput(
                  width: context.getSize.width * 0.24,
                  onChanged: dropDownCallBack,
                  options: dropDownList,
                  value: dropDownValue,
                )
              ],
            ),
            getHeight(context, 0.01),
          ],
        ),
      ),
      getHeight(context, 0.006),
      Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: viewDetailsCallBack,
          child: CustomText(
            title: context.local.view_detail,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: AppColor.darkBack,
          ),
        ),
      )
    ],
  );
}

// Widget multiColumnChart(BuildContext context,
//     {required List<SalesData> income, required List<SalesData> expense}) {
//   return SfCartesianChart(
//       // axes: [
//       //   NumericAxis(
//       //     opposedPosition: true,
//       //     title: AxisTitle(
//       //         text: 'Costs',
//       //         textStyle: textStyle(context: context, fontSize: 10)),
//       //     maximum: 2500,
//       //     minimum: 0,
//       //     interval: 250,
//       //     majorTickLines: const MajorTickLines(
//       //       size: 0, // Hide major ticks
//       //     ),
//       //     axisLine: AxisLine(width: 0),
//       //     majorGridLines: MajorGridLines(width: 0),
//       //   )
//       // ],
//       plotAreaBorderWidth: 0,
//       primaryXAxis: CategoryAxis(
//         majorTickLines: MajorTickLines(
//           size: 0, // Hide major ticks
//         ),
//         axisLine: AxisLine(width: 0),
//         majorGridLines: MajorGridLines(width: 0),
//         minimum: 0,
//         maximum: 11,
//         interval: 1,
//       ),
//       primaryYAxis: NumericAxis(
//         axisLabelFormatter: (axis) {
//           if (axis.value == 0) {
//             return ChartAxisLabel(
//                 "0",
//                 textStyle(
//                   context: context,
//                 ));
//           } else if (axis.value == 120) {
//             return ChartAxisLabel(
//                 "1K",
//                 textStyle(
//                   context: context,
//                 ));
//           } else if (axis.value == 240) {
//             return ChartAxisLabel(
//                 "10K",
//                 textStyle(
//                   context: context,
//                 ));
//           } else if (axis.value == 360) {
//             return ChartAxisLabel(
//                 "100K",
//                 textStyle(
//                   context: context,
//                 ));
//           } else if (axis.value == 480) {
//             return ChartAxisLabel(
//                 "250K",
//                 textStyle(
//                   context: context,
//                 ));
//           } else if (axis.value == 600) {
//             return ChartAxisLabel(
//                 "500K",
//                 textStyle(
//                   context: context,
//                 ));
//           } else if (axis.value == 720) {
//             return ChartAxisLabel(
//                 "750k",
//                 textStyle(
//                   context: context,
//                 ));
//           } else {
//             return ChartAxisLabel(
//                 "750k",
//                 textStyle(
//                   context: context,
//                 ));
//           }
//         },
//         axisLine: AxisLine(
//           width: 0,
//         ),
//         majorTickLines: MajorTickLines(
//           size: 0, // Hide major ticks
//         ),

//         minimum: 0,
//         maximum: 750,
//         interval: 120,
//         // labelFormat: '{value}K',

//         labelIntersectAction: AxisLabelIntersectAction.rotate45,
//         labelPosition: ChartDataLabelPosition.outside,
//         labelAlignment: LabelAlignment.center,

//         edgeLabelPlacement: EdgeLabelPlacement.shift,
//         // interval: 1,
//         // minorTicksPerInterval: 1,
//       ),
//       tooltipBehavior: TooltipBehavior(enable: false),
//       series: <CartesianSeries<SalesData, String>>[
//         ColumnSeries<SalesData, String>(
//             borderRadius: BorderRadius.circular(10),
//             dataSource: income,
//             xValueMapper: (SalesData data, _) => data.x,
//             yValueMapper: (SalesData data, _) => data.y,
//             color: AppColor.blackColor),
//         ColumnSeries<SalesData, String>(
//             borderRadius: BorderRadius.circular(10),
//             markerSettings: MarkerSettings(
//                 borderColor: Color(0xff5DC1FD),
//                 borderWidth: 0,
//                 color: Color(0xff5DC1FD),
//                 isVisible: false),
//             color: AppColor.lightBlueColor,
//             dataSource: expense,
//             xValueMapper: (SalesData sales, _) => sales.x,
//             yValueMapper: (SalesData sales, _) => sales.y)
//       ]);
// }

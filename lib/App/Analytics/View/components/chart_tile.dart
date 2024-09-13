import 'package:flutter/material.dart';
import 'package:propertier/App/Analytics/Model/chart_data_model.dart';
import 'package:propertier/App/Analytics/Model/chart_subtitle_model.dart';
import 'package:propertier/App/Analytics/View/analytics_view.dart';
import 'package:propertier/Utils/drop_down_input.dart';
import 'package:propertier/Utils/app_text.dart';
import 'package:propertier/Utils/border.dart';
import 'package:propertier/Utils/box_shadow.dart';
import 'package:propertier/Utils/height_width_box.dart';
import 'package:propertier/constant/colors.dart';
import 'package:propertier/extensions/size_extension.dart';

// typedef DropDownCallBack =String Function(String);
// DropDownCallBack onChange = (String val){
//   return val;
// };
Widget chartTile(
  BuildContext context, {
  required String title,
  required String dropDownValue,
  required List<ChartSubtitleModel> subtitleList,
  required List<String> dropDownList,
  required ChartsType chartType,
  required Function(String) dropDownCallBack,
  required VoidCallback viewDetailsCallBack,
  required List<SalesData> lineChartData,
  required List<SalesData> columnChartData,
  required List<SalesData> spline1Data,
  required List<SalesData> spline2Data,
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
                    appText(
                        title: title,
                        context: context,
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
                                    appText(
                                        title: subtitleList[index].subtitle,
                                        context: context,
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
            // SizedBox(
            //     height: context.getSize.height * 0.35,
            //     width: context.getSize.width,
            //     child: charts(
            //         chartType: chartType,
            //         context: context,
            //         spline1: spline1Data,
            //         spline2: spline2Data,
            //         lineChartData: lineChartData,
            //         columnChartData: columnChartData))
          ],
        ),
      ),
      getHeight(context, 0.006),
      Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: viewDetailsCallBack,
          child: appText(
            title: "View Detail",
            context: context,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: AppColor.darkBack,
          ),
        ),
      )
    ],
  );
}

// Widget charts(
//     {required ChartsType chartType,
//     required BuildContext context,
//     required List<SalesData> spline1,
//     required List<SalesData> spline2,
//     required List<SalesData> lineChartData,
//     required List<SalesData> columnChartData}) {
//   switch (chartType) {
//     // case ChartsType.line:
//     //   return lineChart(context, lineChartData: lineChartData);
//     // case ChartsType.combination:
//     //   return columnChart(context, columChartData: columnChartData);
//     // case ChartsType.spline:
//     //   return spLineChart(context, chartData: spline1, chartData2: spline2);
//     // case ChartsType.lineArea:
//     //   return lineAreaChart(context, lineChartData: lineChartData);
//   }
// }

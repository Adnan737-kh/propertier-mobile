// import 'package:flutter/material.dart';
// import 'package:propertier/App/Analytics/Model/chart_data_model.dart';
// import 'package:propertier/Utils/textStyle.dart';
// import 'package:propertier/constant/colors.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// import '../../../../Utils/app_text.dart';

// Widget lineAreaChart(BuildContext context,
//     {required List<SalesData> lineChartData}) {
//   return SfCartesianChart(
//       plotAreaBorderWidth: 0,
//       // tooltipBehavior: TooltipBehavior(
//       //   enable: true,
//       //   tooltipPosition: TooltipPosition.pointer,
//       //   builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
//       //       int seriesIndex) {
//       //     return Container(
//       //       decoration: BoxDecoration(
//       //         color: Color(0xff2A2626),
//       //         borderRadius: BorderRadius.circular(2),
//       //         boxShadow: [
//       //           BoxShadow(
//       //             color: Colors.black.withOpacity(0.2),
//       //             blurRadius: 4,
//       //             offset: const Offset(0, 2),
//       //           ),
//       //         ],
//       //       ),
//       //       padding: const EdgeInsets.all(1),
//       //       child: Column(
//       //         mainAxisAlignment: MainAxisAlignment.start,
//       //         crossAxisAlignment: CrossAxisAlignment.start,
//       //         mainAxisSize: MainAxisSize.min,
//       //         children: [
//       //           appText(
//       //               textAlign: TextAlign.left,
//       //               title: '${data.x.toString()}',
//       //               color: AppColor.white,
//       //               context: context,
//       //               fontSize: 8,
//       //               fontWeight: FontWeight.w400),
//       //           appText(
//       //               title: '${data.y.toString()}%',
//       //               color: AppColor.white,
//       //               context: context,
//       //               fontSize: 12,
//       //               fontWeight: FontWeight.w400),
//       //         ],
//       //       ),
//       //     );
//       //   },
//       // ),
//       primaryXAxis: const CategoryAxis(
//         majorTickLines: MajorTickLines(
//           size: 0, // Hide major ticks
//         ),

//         axisLine: AxisLine(width: 0),
//         majorGridLines: MajorGridLines(width: 0),
//         minimum: 0.0, maximum: 11, interval: 11,
//         // minorGridLines: MinorGridLines(width: 0)
//       ),
//       primaryYAxis: const NumericAxis(
//         axisLine: AxisLine(width: 0),
//         majorTickLines: MajorTickLines(
//           size: 0, // Hide major ticks
//         ),
//         maximum: 100,
//         minimum: 0.0,
//         labelFormat: '{value}%',
//         labelIntersectAction: AxisLabelIntersectAction.rotate45,
//         labelPosition: ChartDataLabelPosition.outside,
//         labelAlignment: LabelAlignment.center,
//         edgeLabelPlacement: EdgeLabelPlacement.shift,
//         interval: 25,
//         minorTicksPerInterval: 0,
//       ),
//       series: <CartesianSeries>[
//         SplineAreaSeries<SalesData, String>(
//             color: AppColor.lightBlueColor,
//             dataSource: lineChartData,
//             xValueMapper: (SalesData sales, _) => sales.x,
//             yValueMapper: (SalesData sales, _) => sales.y)
//       ]);
// }

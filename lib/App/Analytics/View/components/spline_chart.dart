// import 'package:flutter/material.dart';
// import 'package:propertier/App/Analytics/Model/chart_data_model.dart';
// import 'package:propertier/App/Analytics/View/components/line_chart.dart';
// import 'package:propertier/Utils/app_text.dart';
// import 'package:propertier/constant/colors.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// Widget spLineChart(BuildContext context,
//     {required List<SalesData> chartData, required List<SalesData> chartData2}) {
//   return SfCartesianChart(
//       plotAreaBorderWidth: 0,
//       // trackballBehavior: TrackballBehavior(
//       //     markerSettings: TrackballMarkerSettings(),
//       //     enable: true,
//       //     lineWidth: 1,
//       //     lineColor: AppColor.blackColor),
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
//       //       padding: const EdgeInsets.all(8),
//       //       child: Column(
//       //         mainAxisAlignment: MainAxisAlignment.start,
//       //         crossAxisAlignment: CrossAxisAlignment.center,
//       //         mainAxisSize: MainAxisSize.min,
//       //         children: [
//       //           if (seriesIndex == 0)
//       //             appText(
//       //                 // textAlign: TextAlign.left,
//       //                 title: '${data.y.toString()} Gain',
//       //                 color: AppColor.white,
//       //                 context: context,
//       //                 fontSize: 12,
//       //                 fontWeight: FontWeight.w400),
//       //           if (seriesIndex == 1)
//       //             appText(
//       //                 title: '${data.y.toString()} Lost',
//       //                 color: AppColor.white,
//       //                 context: context,
//       //                 fontSize: 12,
//       //                 fontWeight: FontWeight.w400),
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
//         minimum: 0, maximum: 11, interval: 1,
//         // minorGridLines: MinorGridLines(width: 0)
//       ),
//       primaryYAxis: const NumericAxis(
//         axisLine: AxisLine(width: 0),
//         minimum: 0,
//         maximum: 300,
//         interval: 50,
//         majorGridLines:
//             MajorGridLines(dashArray: <double>[5, 5], color: Colors.black),
//       ),
//       series: <CartesianSeries>[
//         SplineSeries<SalesData, String>(
//             color: AppColor.lightBlueColor,
//             dataSource: chartData,
//             xValueMapper: (SalesData sales, _) => sales.x,
//             yValueMapper: (SalesData sales, _) => sales.y),
//         SplineSeries<SalesData, String>(
//             color: AppColor.buttonColor,
//             dataSource: chartData2,
//             xValueMapper: (SalesData sales, _) => sales.x,
//             yValueMapper: (SalesData sales, _) => sales.y)
//       ]);
// }

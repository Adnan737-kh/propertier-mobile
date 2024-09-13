// import 'package:flutter/material.dart';
// import 'package:propertier/App/Analytics/Model/chart_data_model.dart';
// import 'package:propertier/App/Analytics/View/components/line_chart.dart';
// import 'package:propertier/Utils/textStyle.dart';
// import 'package:propertier/constant/colors.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// Widget columnChart(BuildContext context,
//     {required List<SalesData> columChartData}) {
//   return SfCartesianChart(
//       axes: [
//         NumericAxis(
//           opposedPosition: true,
//           title: AxisTitle(
//               text: 'Costs',
//               textStyle: textStyle(context: context, fontSize: 10)),
//           maximum: 2500,
//           minimum: 0,
//           interval: 250,
//           majorTickLines: const MajorTickLines(
//             size: 0, // Hide major ticks
//           ),
//           axisLine: AxisLine(width: 0),
//           majorGridLines: MajorGridLines(width: 0),
//         )
//       ],
//       plotAreaBorderWidth: 0,
//       primaryXAxis: const CategoryAxis(
//         majorTickLines: MajorTickLines(
//           size: 0, // Hide major ticks
//         ),
//         axisLine: AxisLine(width: 0),
//         majorGridLines: MajorGridLines(width: 0),
//         minimum: 0,
//         maximum: 6,
//         interval: 1,
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
//         interval: 10,
//         minorTicksPerInterval: 0,
//       ),
//       tooltipBehavior: TooltipBehavior(enable: false),
//       series: <CartesianSeries<SalesData, String>>[
//         ColumnSeries<SalesData, String>(
//             dataSource: columChartData,
//             xValueMapper: (SalesData data, _) => data.x,
//             yValueMapper: (SalesData data, _) => data.y,
//             color: const Color(0xff5DC1FD)),
//         LineSeries<SalesData, String>(
//             markerSettings: const MarkerSettings(
//                 borderColor: Color(0xff5DC1FD),
//                 borderWidth: 0,
//                 color: Color(0xff5DC1FD),
//                 isVisible: true),
//             color: AppColor.buttonColor,
//             dataSource: columChartData,
//             xValueMapper: (SalesData sales, _) => sales.x,
//             yValueMapper: (SalesData sales, _) => sales.y)
//       ]);
// }

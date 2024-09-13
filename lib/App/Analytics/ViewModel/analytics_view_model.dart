import 'package:get/get.dart';
import 'package:propertier/App/Analytics/Model/chart_data_model.dart';
import 'package:propertier/App/Analytics/Model/chart_subtitle_model.dart';
import 'package:propertier/App/Analytics/View/components/line_chart.dart';
import 'package:propertier/constant/colors.dart';

class AnalyticsViewModel extends GetxController {
  RxList<ChartSubtitleModel> chartSubtitleList = <ChartSubtitleModel>[
    ChartSubtitleModel(subtitle: 'Sales', color: AppColor.lightBlueColor)
  ].obs;
  final RxString _isThisWeekSplineData = 'This Week'.obs;
  String get isThisWeekSplineData => _isThisWeekSplineData.value;
  changeSplineWeek(String val) {
    _isThisWeekSplineData.value = val;
  }

  final RxString _isThisWeekColumnData = 'This Week'.obs;
  String get isThisWeekColumnData => _isThisWeekColumnData.value;
  changeColumnWeek(String val) {
    _isThisWeekColumnData.value = val;
  }

  final RxString _isThisWeekLineData = 'This Week'.obs;
  String get isThisWeekLineData => _isThisWeekLineData.value;
  changeLineWeek(String val) {
    _isThisWeekLineData.value = val;
  }

  final List<SalesData> spline1ThisWeek = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 90),
    SalesData('Apr', 32),
    SalesData('May', 50),
    SalesData('Jun', 90),
    SalesData('Jul', 200),
    SalesData('Aug', 40),
    SalesData('Sep', 150),
    SalesData('Oct', 100),
    SalesData('Nov', 89),
    SalesData('Dec', 2),
  ];
  final List<SalesData> splin2ThisWeek = [
    SalesData('Jan', 50),
    SalesData('Feb', 18),
    SalesData('Mar', 30),
    SalesData('Apr', 52),
    SalesData('May', 60),
    SalesData('Jun', 100),
    SalesData('Jul', 200),
    SalesData('Aug', 250),
    SalesData('Sep', 150),
    SalesData('Oct', 10),
    SalesData('Nov', 89),
    SalesData('Dec', 2),
  ];
  final List<SalesData> spline1NextWeek = [
    SalesData('Jan', 100),
    SalesData('Feb', 28),
    SalesData('Mar', 90),
    SalesData('Apr', 32),
    SalesData('May', 50),
    SalesData('Jun', 30),
    SalesData('Jul', 150),
    SalesData('Aug', 40),
    SalesData('Sep', 150),
    SalesData('Oct', 100),
    SalesData('Nov', 89),
    SalesData('Dec', 2),
  ];
  final List<SalesData> splin2NextWeek = [
    SalesData('Jan', 50),
    SalesData('Feb', 18),
    SalesData('Mar', 30),
    SalesData('Apr', 52),
    SalesData('May', 60),
    SalesData('Jun', 30),
    SalesData('Jul', 200),
    SalesData('Aug', 250),
    SalesData('Sep', 150),
    SalesData('Oct', 10),
    SalesData('Nov', 89),
    SalesData('Dec', 2),
  ];
  final List<SalesData> columnDataThisWeek = [
    SalesData('Sat', 100),
    SalesData('Sun', 50),
    SalesData('Mon', 30),
    SalesData('Tue', 80),
    SalesData('Wed', 7),
    SalesData('Thu', 4),
    SalesData('Fri', 90),
  ];
  final List<SalesData> columnDataNextWeek = [
    SalesData('Sat', 12),
    SalesData('Sun', 15),
    SalesData('Mon', 30),
    SalesData('Tue', 6.4),
    SalesData('Wed', 14),
    SalesData('Thu', 4),
    SalesData('Fri', 34),
  ];
  final List<SalesData> lineChartData = [
    SalesData('Jan', 35),
    SalesData('Feb', 28),
    SalesData('Mar', 90),
    SalesData('Apr', 32),
    SalesData('May', 50),
    SalesData('Jun', 90),
    SalesData('Jul', 200),
    SalesData('Aug', 40),
    SalesData('Sep', 150),
    SalesData('Oct', 100),
    SalesData('Nov', 89),
    SalesData('Dec', 2),
  ];
  final List<SalesData> lineChartDataNext = [
    SalesData('Jan', 200),
    SalesData('Feb', 80),
    SalesData('Mar', 90),
    SalesData('Apr', 200),
    SalesData('May', 50),
    SalesData('Jun', 90),
    SalesData('Jul', 200),
    SalesData('Aug', 2),
    SalesData('Sep', 250),
    SalesData('Oct', 150),
    SalesData('Nov', 89),
    SalesData('Dec', 2),
  ];
  final List<SalesData> lineAreaChartData = [
    SalesData('0:00', 0),
    SalesData('0:12', 25),
    SalesData('2:18', 60),
    SalesData('2:30', 100),
    SalesData('2:80', 50),
    SalesData('3:10', 90),
    SalesData('0:10', 30),
    SalesData('3:80', 2),
    SalesData('1:10', 60),
    SalesData('1:90', 90),
    SalesData('4:80', 89),
    SalesData('5:10', 2),
  ];
}

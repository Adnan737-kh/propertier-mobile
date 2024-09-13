import 'package:get/get.dart';
import 'package:propertier/App/Analytics/Model/chart_data_model.dart';

class PayOutViewModel extends GetxController {
  final List<SalesData> thisMonthIncom = [
    SalesData('Jan', 100),
    SalesData('Feb', 500),
    SalesData('Mar', 200),
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
  final List<SalesData> thisMonthExpense = [
    SalesData('Jan', 10),
    SalesData('Feb', 750),
    SalesData('Mar', 500),
    SalesData('Apr', 52),
    SalesData('May', 60),
    SalesData('Jun', 100),
    SalesData('Jul', 200),
    SalesData('Aug', 250),
    SalesData('Sep', 300),
    SalesData('Oct', 10),
    SalesData('Nov', 89),
    SalesData('Dec', 2),
  ];
}

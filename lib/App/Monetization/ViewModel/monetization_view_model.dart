import 'package:get/get.dart';

class MonetizationViewModel extends GetxController {
  double convertDaysToFractionOfYear(int days) {
    const int totalDaysInYear = 365;

    double fractionOfYear = days / totalDaysInYear;

    fractionOfYear = fractionOfYear.clamp(0.0, 1.0);

    return fractionOfYear;
  }
}

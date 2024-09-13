extension ConvertAreaExtension on double {
  double convertArea({required String areaType}) {
    double value = 0.0;
    if (areaType.toLowerCase() == 'marla') {
      value = this / 272.25;
    } else if (areaType.toLowerCase() == "kanal") {
      value = this / 5445;
    } else if (areaType.toLowerCase() == 'acre') {
      value = this / 43560;
    } else if (areaType == 'ft²') {
      value = this / 1;
    } else {
      value = 0.0;
    }

    return double.parse(value.toStringAsFixed(2));
  }
}

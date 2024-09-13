import 'dart:math';

extension AreaToDimensions on double {
  String squareOrRectangleDimensions() {
    double sideLength = sqrt(this);
    return '${sideLength.toInt()}*${sideLength.toInt()}';
  }

  String circleDimensions() {
    double radius = sqrt(this / pi);
    return '${(2 * radius).toInt()}*${(2 * radius).toInt()}';
  }
}

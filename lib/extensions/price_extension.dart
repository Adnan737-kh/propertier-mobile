extension PriceExtension on double {
  String formatPrice() {
    if (this >= 1000000) {
      double m = this / 1000000;
      return '${m.toStringAsFixed(2)}M';
      // If number is less than 1 lakh, return as it is
    } else if (this >= 1000) {
      // If number is between 1 lakh and 1 crore
      double k = this / 1000;
      return '${k.toStringAsFixed(2)}K';
    } else {
      // If number is greater than or equal to 1 crore
      return toStringAsFixed(2);
    }
  }
}

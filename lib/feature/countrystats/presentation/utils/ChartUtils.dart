extension ChartCalculations on double {

  double calculateBarHeight({
    double maxHeight = 200.0,
    double minHeight = 50.0,
  }) {
    // this — это процент (например, 75.2)
    final rawHeight = maxHeight * (this / 100);
    return rawHeight.clamp(minHeight, maxHeight);
  }
}
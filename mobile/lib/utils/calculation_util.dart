class CalculationUtil {
  static double getTotal(List<double> totalList) {
    return (totalList.isEmpty
        ? 0.0
        : totalList.reduce((value, element) => value + element));
  }

  static double getTotalFor100(
      List<double> totalList, double multiplicationFactor) {
    // TODO: implement
    return 0.0;
  }
}

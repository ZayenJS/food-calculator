import 'package:food_calculator/classes/classes.dart';

class CalculationResult {
  final double total;
  final double for100;

  CalculationResult({required this.total, required this.for100});
}

class CalculationUtil {
  static double getTotal(List<double> totalList) {
    return totalList.isEmpty
        ? 0.0
        : totalList.reduce((value, element) => value + element);
  }

  static CalculationResult getTotalAndFor100(
      List<Ingredient> ingredientList, String field, double dividerFactor) {
    final _totalList = getTotalByField(ingredientList, field);

    final double _total = getTotal(_totalList);
    final for100Result = _total / dividerFactor;
    print(dividerFactor);
    final double for100 = for100Result.isNaN ? 0.00 : for100Result;

    return CalculationResult(
      total: _total,
      for100: for100,
    );
  }

  static List<double> getTotalByField(
      List<Ingredient> ingredientList, String field) {
    return ingredientList.map((i) {
      if (field == "quantity") return i.quantity as double;

      return ((i.quantity as double) / 100) * i.toJson()[field];
    }).toList();
  }
}

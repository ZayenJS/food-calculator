import 'package:flutter/material.dart';
import 'package:food_calculator/classes/ingredient.dart';
import 'package:food_calculator/utils/utils.dart';

class IngredientProvider with ChangeNotifier {
  List<Ingredient> _ingredientCalculationList = [];

  List<Ingredient> get ingredientCalculationList => _ingredientCalculationList;

  void addIngredient(Ingredient ingredient) {
    _ingredientCalculationList.add(
      Ingredient.withQuantity(
          id: ingredient.id,
          name: ingredient.name,
          calories: ingredient.calories,
          proteins: ingredient.proteins,
          carbohydrates: ingredient.carbohydrates,
          sugars: ingredient.sugars,
          fats: ingredient.fats,
          saturated: ingredient.saturated,
          fibers: ingredient.fibers,
          salt: ingredient.salt,
          quantity: 100.0),
    );
    notifyListeners();
  }

  void removeIngredient(int ingredientId) {
    _ingredientCalculationList
        .removeWhere((element) => element.id == ingredientId);
    notifyListeners();
  }

  void updateIngredientsCalculationList(Ingredient ingredient) {
    var newCalculationList = _ingredientCalculationList.map((i) {
      if (i.id == ingredient.id) {
        i = ingredient;
      }

      return i;
    }).toList();

    _ingredientCalculationList = newCalculationList;

    notifyListeners();
  }
}

import 'package:food_calculator/classes/ingredient.dart';

class ListUtil {
  static bool isInList(
      List<Ingredient> selectedIngredients, Ingredient ingredient) {
    List<int> selectedIngredientIds =
        selectedIngredients.map((e) => e.id!).toList();

    return selectedIngredientIds.contains(ingredient.id);
  }
}

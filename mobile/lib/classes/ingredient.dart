import 'dart:convert';

import 'package:food_calculator/constants/url.dart';
import 'package:http/http.dart' as http;

class Ingredient {
  int? id;
  String name;
  double calories;
  double proteins;
  double carbohydrates;
  double sugars;
  double fats;
  double saturated;
  double salt;

  Ingredient({
    this.id,
    required this.name,
    required this.calories,
    required this.proteins,
    required this.carbohydrates,
    required this.sugars,
    required this.fats,
    required this.saturated,
    required this.salt,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "calories": calories,
        "proteins": proteins,
        "carbohydrates": carbohydrates,
        "sugars": sugars,
        "fats": fats,
        "saturated": saturated,
        "salt": salt,
      };

  Future<dynamic> save() async {
    try {
      var response = await http.post(graphQlURL, body: {
        "query": """
              mutation(\$CreateIngredientData: CreateIngredientData!) {
                createIngredient(data: \$CreateIngredientData) {
                  id
                  name
                  calories
                  proteins
                  carbohydrates
                  sugars
                  fats
                  saturated
                  salt
                }
              }
        """,
        "variables": jsonEncode({"CreateIngredientData": toJson()}),
      });

      print(response);

      return this;
    } catch (error) {
      print(error);
    }

    return null;
  }

  static Future<List<Ingredient>> findByName(String name) async {
    try {
      var response = await http.post(graphQlURL, body: {
        "query": """
          query FindIngredientsByName(\$name: String!) {
            findIngredientsByName(name: \$name) {
              id
              name
              calories
              proteins
              carbohydrates
              sugars
              fats
              saturated
              salt
            }
          }
        """,
        "variables": jsonEncode({"name": name}),
      });

      var parsedData = jsonDecode(response.body);
      var data = parsedData['data'];

      if (data != null) {
        List<Ingredient> ingredients = List<Ingredient>.from(
          data['findIngredientsByName'].map(
            (ingredient) => Ingredient(
              id: int.tryParse(ingredient['id']),
              name: ingredient['name'],
              calories: double.parse(ingredient['calories'].toString()),
              proteins: double.parse(ingredient['proteins'].toString()),
              carbohydrates:
                  double.parse(ingredient['carbohydrates'].toString()),
              sugars: double.parse(ingredient['sugars'].toString()),
              fats: double.parse(ingredient['fats'].toString()),
              saturated: double.parse(ingredient['saturated'].toString()),
              salt: double.parse(ingredient['salt'].toString()),
            ),
          ),
        );

        return ingredients;
      }
    } catch (error) {
      print(error);
    }

    return [];
  }
}

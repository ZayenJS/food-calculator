import 'dart:convert';

import 'package:food_calculator/classes/api_error.dart';
import 'package:food_calculator/constants/url.dart';
import 'package:http/http.dart' as http;

class IngredientResponse {
  Ingredient? ingredient;
  List<ApiError> errors = [];

  IngredientResponse({this.ingredient, required this.errors});
}

class Ingredient {
  int? id;
  String name;
  double calories;
  double proteins;
  double carbohydrates;
  double sugars;
  double fats;
  double saturated;
  double fibers;
  double salt;

  double? quantity;

  Ingredient({
    this.id,
    required this.name,
    required this.calories,
    required this.proteins,
    required this.carbohydrates,
    required this.sugars,
    required this.fats,
    required this.saturated,
    required this.fibers,
    required this.salt,
  });

  Ingredient.withQuantity({
    required this.id,
    required this.name,
    required this.calories,
    required this.proteins,
    required this.carbohydrates,
    required this.sugars,
    required this.fats,
    required this.saturated,
    required this.fibers,
    required this.salt,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "calories": calories,
        "proteins": proteins,
        "carbohydrates": carbohydrates,
        "sugars": sugars,
        "fats": fats,
        "saturated": saturated,
        "fibers": fibers,
        "salt": salt,
      };

  Map<String, dynamic> toJsonWithQuantity() => {
        "name": name,
        "calories": calories,
        "proteins": proteins,
        "carbohydrates": carbohydrates,
        "sugars": sugars,
        "fats": fats,
        "saturated": saturated,
        "fibers": fibers,
        "salt": salt,
        "quantity": quantity,
      };

  Future<IngredientResponse> save() async {
    try {
      var response = await http.post(graphQlURL, body: {
        "query": """
              mutation(\$CreateIngredientData: CreateIngredientData!) {
                createIngredient(data: \$CreateIngredientData) {
                  errors {
                    field
                    type
                    message
                  }
                  ingredient {
                    id
                    name
                    calories
                    proteins
                    carbohydrates
                    sugars
                    fats
                    saturated
                    fibers
                    salt
                  }
                }
              }
        """,
        "variables": jsonEncode({"CreateIngredientData": toJson()}),
      });

      var parsedResponse = jsonDecode(response.body);
      var responseData = parsedResponse['data']['createIngredient'];

      if (responseData['ingredient'] != null) {
        return IngredientResponse(ingredient: this, errors: []);
      }

      List<ApiError> errors = List<ApiError>.from(
        responseData['errors']
            .map(
              (error) => ApiError(
                message: error['message'],
                field: error['field'],
                type: error['type'],
              ),
            )
            .toList(),
      );

      return IngredientResponse(errors: errors);
    } catch (error) {
      print("ingredient save error: $error");

      return IngredientResponse(ingredient: this, errors: []);
    }
  }

  static Future<List<Ingredient>> findByName(String name) async {
    // TODO: handle errors
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
              fibers
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
              fibers: double.parse(ingredient['fibers'].toString()),
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

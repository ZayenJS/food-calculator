import 'dart:convert';

import 'package:http/http.dart' as http;

class Ingredient {
  int? id;
  String name;
  String calories;
  String proteins;
  String carbohydrates;
  String sugars;
  String fats;
  String saturated;
  String salt;

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
        "calories": double.parse(calories),
        "proteins": double.parse(proteins),
        "carbohydrates": double.parse(carbohydrates),
        "sugars": double.parse(sugars),
        "fats": double.parse(fats),
        "saturated": double.parse(saturated),
        "salt": double.parse(salt),
      };

  void save() async {
    try {
      var url = Uri.parse("http://192.168.1.9:8008/graphql");

      var response = await http.post(url, body: {
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
        "variables": jsonEncode(
          {"CreateIngredientData": toJson()},
        ),
      });
    } catch (error) {
      print(error);
    }
  }
}

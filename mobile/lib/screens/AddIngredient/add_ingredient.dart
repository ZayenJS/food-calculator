import 'package:flutter/material.dart';
import 'package:food_calculator/classes/input.dart';

import '../../widgets/input_group.dart';

class AddIngredient extends StatelessWidget {
  final String title;

  AddIngredient({Key? key, required this.title}) : super(key: key);

  TextEditingController name = TextEditingController();
  TextEditingController calories = TextEditingController();
  TextEditingController proteins = TextEditingController();
  TextEditingController carbohydrates = TextEditingController();
  TextEditingController sugars = TextEditingController();
  TextEditingController fats = TextEditingController();
  TextEditingController saturated = TextEditingController();
  TextEditingController salt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.asset(
                  "assets/images/add-ingredient-banner.jpg",
                ),
              ),
              InputGroup(
                field1: Input(text: "Nom", controller: name),
              ),
              InputGroup(
                field1: Input(text: "Protéines", controller: proteins),
                field2: Input(text: "Calories", controller: calories),
              ),
              InputGroup(
                field1: Input(text: "Glucides", controller: carbohydrates),
                field2: Input(text: "Sucres", controller: sugars),
              ),
              InputGroup(
                field1: Input(text: "Lipides", controller: fats),
                field2: Input(text: "Saturés", controller: saturated),
              ),
              InputGroup(
                field1: Input(text: "Sel", controller: salt),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
                child: ElevatedButton(
                  onPressed: () => '',
                  child: const Text(
                    "Valider",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _AddIngredientState extends State<AddIngredient> {


// }

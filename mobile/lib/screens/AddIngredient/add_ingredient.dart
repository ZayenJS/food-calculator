import 'package:flutter/material.dart';
import 'package:food_calculator/classes/ingredient.dart';
import 'package:http/http.dart';

import '../../widgets/input_group.dart';

import '../../classes/input.dart';

class AddIngredient extends StatefulWidget {
  final String title;

  AddIngredient({Key? key, required this.title}) : super(key: key);

  @override
  _AddIngredientState createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {
  String _message = '';

  TextEditingController name = TextEditingController();
  TextEditingController calories = TextEditingController();
  TextEditingController proteins = TextEditingController();
  TextEditingController carbohydrates = TextEditingController();
  TextEditingController sugars = TextEditingController();
  TextEditingController fats = TextEditingController();
  TextEditingController saturated = TextEditingController();
  TextEditingController salt = TextEditingController();

  void _addIngredient() {
    Ingredient ingredient = Ingredient(
      name: name.text,
      calories: double.parse(calories.text),
      proteins: double.parse(proteins.text),
      carbohydrates: double.parse(carbohydrates.text),
      sugars: double.parse(sugars.text),
      fats: double.parse(fats.text),
      saturated: double.parse(saturated.text),
      salt: double.parse(salt.text),
    );

    ingredient.save();

    setState(() {
      _message = "Ingredient bien ajouté !";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _message,
                  style: TextStyle(fontSize: 22, color: Colors.deepPurple),
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
                  onPressed: _addIngredient,
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

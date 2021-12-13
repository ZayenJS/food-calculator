import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_calculator/classes/ingredient.dart';
import 'package:http/http.dart';

import '../widgets/input_group.dart';

import '../classes/input.dart';

class AddIngredient extends StatefulWidget {
  final String title;

  AddIngredient({Key? key, required this.title}) : super(key: key);

  @override
  _AddIngredientState createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {
  String _message = '';
  bool _hasError = false;

  Input name = Input(
    label: "Nom",
    controller: TextEditingController(),
    error: '',
  );
  Input calories = Input(
    label: "Calories",
    controller: TextEditingController(),
    error: '',
  );
  Input proteins = Input(
    label: "Protéines",
    controller: TextEditingController(),
    error: '',
  );
  Input carbohydrates = Input(
    label: 'Glucides',
    controller: TextEditingController(),
    error: '',
  );
  Input sugars = Input(
    label: 'Sucres',
    controller: TextEditingController(),
    error: '',
  );
  Input fats = Input(
    label: "Lipides",
    controller: TextEditingController(),
    error: '',
  );
  Input saturated = Input(
    label: 'Saturés',
    controller: TextEditingController(),
    error: '',
  );
  Input salt = Input(
    label: "Sel",
    controller: TextEditingController(),
    error: '',
  );

  void _addIngredient(BuildContext context) async {
    FocusScope.of(context).unfocus();

    List<Input> inputs = [
      name,
      calories,
      proteins,
      carbohydrates,
      sugars,
      fats,
      saturated,
      salt
    ];

    bool hasError = false;

    for (Input input in inputs) {
      if (input.controller.text == '') {
        input.error = "Champs requis";
        hasError = true;
        continue;
      }

      input.error = "";
    }

    if (hasError) {
      return setState(() {
        _hasError = true;
      });
    }

    try {
      Ingredient ingredient = Ingredient(
        name: name.controller.text.trim(),
        proteins: double.parse(proteins.controller.text.trim()),
        calories: double.parse(calories.controller.text.trim()),
        carbohydrates: double.parse(carbohydrates.controller.text.trim()),
        sugars: double.parse(sugars.controller.text.trim()),
        fats: double.parse(fats.controller.text.trim()),
        saturated: double.parse(saturated.controller.text.trim()),
        salt: double.parse(salt.controller.text.trim()),
      );

      dynamic response = await ingredient.save();

      if (response.errors.isEmpty) {
        setState(() {
          _message = "Ingredient bien ajouté !";
          _hasError = false;
          _resetInputs();
          Timer(
            const Duration(seconds: 2),
            () => Navigator.pushNamed(context, '/'),
          );
        });
        return;
      }

      setState(() {
        _message = "Une erreur est survenue";
        _hasError = true;
      });
    } on FormatException catch (error) {
      print(error);

      List<Input> inputs = [
        calories,
        proteins,
        carbohydrates,
        sugars,
        fats,
        saturated,
        salt
      ];

      // TODO: error handling
      switch (error.message) {
        case "Invalid double":
          inputs.forEach((element) => element.error = '');

          Input errorInput = inputs
              .where((element) => element.controller.text == error.source)
              .first;
          errorInput.error = "Valeur incorrecte";
          break;
        default:
          break;
      }
      setState(() {
        _message = "Une erreur est survenue";
        _hasError = true;
      });
    }
  }

  void _resetInputs() {
    name.controller.text = '';
    calories.controller.text = '';
    proteins.controller.text = '';
    carbohydrates.controller.text = '';
    sugars.controller.text = '';
    fats.controller.text = '';
    saturated.controller.text = '';
    salt.controller.text = '';
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
                  style: TextStyle(
                    fontSize: 22,
                    color: _hasError ? Colors.red : Colors.deepPurple,
                  ),
                ),
              ),
              InputGroup(
                field1: name,
              ),
              InputGroup(
                field1: proteins,
                field2: calories,
              ),
              InputGroup(
                field1: carbohydrates,
                field2: sugars,
              ),
              InputGroup(
                field1: fats,
                field2: saturated,
              ),
              InputGroup(
                field1: salt,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
                child: ElevatedButton(
                  onPressed: () => _addIngredient(context),
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

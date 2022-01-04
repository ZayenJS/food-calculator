import 'dart:async';
import 'package:flutter/material.dart';

import 'package:food_calculator/classes/classes.dart';
import 'package:food_calculator/widgets/widgets.dart';

class AddIngredient extends StatefulWidget {
  final String title;

  const AddIngredient({Key? key, required this.title}) : super(key: key);

  @override
  _AddIngredientState createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final int _snackbarDuration = 2;

  Input name = Input(
    label: "Nom",
    controller: TextEditingController(),
    keyboardType: TextInputType.text,
  );
  Input calories = Input(
    label: "Calories",
    controller: TextEditingController(),
    keyboardType: TextInputType.number,
  );
  Input proteins = Input(
    label: "Protéines",
    controller: TextEditingController(),
    keyboardType: TextInputType.number,
  );
  Input carbohydrates = Input(
    label: 'Glucides',
    controller: TextEditingController(),
    keyboardType: TextInputType.number,
  );
  Input sugars = Input(
    label: 'Sucres',
    controller: TextEditingController(),
    keyboardType: TextInputType.number,
  );
  Input fats = Input(
    label: "Lipides",
    controller: TextEditingController(),
    keyboardType: TextInputType.number,
  );
  Input saturated = Input(
    label: 'Saturés',
    controller: TextEditingController(),
    keyboardType: TextInputType.number,
  );
  Input fibers = Input(
    label: 'Fibres',
    controller: TextEditingController(),
    keyboardType: TextInputType.number,
  );
  Input salt = Input(
    label: "Sel",
    controller: TextEditingController(),
    keyboardType: TextInputType.number,
  );

  Future<Map<String, dynamic>> _addIngredient(BuildContext context) async {
    FocusScope.of(context).unfocus();
    Map<String, dynamic> result = {'message': '', 'hasError': false};

    try {
      Ingredient ingredient = Ingredient(
        name: name.controller.text.trim(),
        proteins: double.parse(proteins.controller.text.trim()),
        calories: double.parse(calories.controller.text.trim()),
        carbohydrates: double.parse(carbohydrates.controller.text.trim()),
        sugars: double.parse(sugars.controller.text.trim()),
        fats: double.parse(fats.controller.text.trim()),
        saturated: double.parse(saturated.controller.text.trim()),
        fibers: double.parse(fibers.controller.text.trim()),
        salt: double.parse(salt.controller.text.trim()),
      );

      IngredientResponse response = await ingredient.save();

      if (response.errors.isEmpty) {
        setState(
          () {
            _resetInputs();
            Timer(
              Duration(seconds: _snackbarDuration),
              () => Navigator.pushNamed(context, '/'),
            );
          },
        );

        result = {'message': 'Ingrédient ajouté!', 'hasError': false};
      }

      setState(() {});
      return result;
    } catch (error) {
      print("error: $error");
      setState(() {});
      result = {'message': 'Un des champs est erroné.', 'hasError': true};
      return result;
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.asset("assets/images/add-ingredient-banner.jpg"),
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
                  field1: fibers,
                  field2: salt,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> result =
                            await _addIngredient(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: _snackbarDuration),
                            dismissDirection: DismissDirection.startToEnd,
                            padding: const EdgeInsets.symmetric(vertical: 26.0),
                            content: Center(
                              heightFactor: 0.5,
                              child: Text(
                                result['message'],
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            backgroundColor: result['hasError']
                                ? Theme.of(context).errorColor
                                : Theme.of(context)
                                    .snackBarTheme
                                    .backgroundColor,
                          ),
                        );
                      }
                    },
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
      ),
    );
  }
}

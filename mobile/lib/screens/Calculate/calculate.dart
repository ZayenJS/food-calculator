import 'package:flutter/material.dart';
import 'package:food_calculator/classes/input.dart';
import 'package:food_calculator/widgets/input_group.dart';

class Calculate extends StatefulWidget {
  const Calculate({Key? key}) : super(key: key);

  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  TextEditingController _searchIngredient = TextEditingController();

  void _searchIngredientByName() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Calcul")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Container(
              child: Column(
                children: [
                  InputGroup(
                    field1: Input(
                        text: "Rechercher un ingrédient",
                        controller: _searchIngredient),
                  ),
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: _searchIngredientByName,
                      child: Text('Rechercher'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:food_calculator/classes/ingredient.dart';
import 'package:food_calculator/classes/input.dart';
import 'package:food_calculator/widgets/ingredient_search.dart';
import 'package:food_calculator/widgets/input_group.dart';

class Calculate extends StatefulWidget {
  const Calculate({Key? key}) : super(key: key);

  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  List<Ingredient> _ingredients = [];
  TextEditingController _searchIngredient = TextEditingController();

  void _searchIngredientByName() async {
    String name = _searchIngredient.text;
    var ingredients = await Ingredient.findByName(name);

    setState(() {
      _ingredients = ingredients;
    });
  }

  showAlertDialog(BuildContext context, String name) {
    Widget okButton = TextButton(
      child: Text("fermer"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Ingredient"),
      content: Text("Vous avez appuyé sur $name"),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
                IngredientSearch(
                  searchInput: Input(
                    text: "Rechercher un ingrédient",
                    controller: _searchIngredient,
                    onChanged: (_) => _searchIngredientByName(),
                  ),
                ),
                Column(
                  children: _searchIngredient.text != ''
                      ? _ingredients
                          .map(
                            (ingredient) => Card(
                              child: TextButton(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  width: double.infinity,
                                  child: Center(
                                    child: Text(
                                      ingredient.name,
                                    ),
                                  ),
                                ),
                                onPressed: () =>
                                    showAlertDialog(context, ingredient.name),
                              ),
                            ),
                          )
                          .toList()
                      : [],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

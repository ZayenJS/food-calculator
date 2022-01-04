import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:food_calculator/classes/classes.dart';
import 'package:food_calculator/providers/ingredient.dart';
import 'package:food_calculator/utils/utils.dart';

import 'package:food_calculator/widgets/ingredient_search.dart';

class SelectIngredient extends StatefulWidget {
  const SelectIngredient({Key? key}) : super(key: key);

  @override
  _SelectIngredientState createState() => _SelectIngredientState();
}

class _SelectIngredientState extends State<SelectIngredient> {
  final TextEditingController _searchIngredient = TextEditingController();
  List<Ingredient> _searchedIngredients = [];

  void _searchIngredientByName() async {
    String name = _searchIngredient.text;
    var ingredients = await Ingredient.findByName(name);

    setState(() {
      _searchedIngredients = ingredients;
    });
  }

  void selectIngredient(Ingredient ingredient, BuildContext context) {
    IngredientProvider ingredientProvider =
        Provider.of<IngredientProvider>(context, listen: false);

    if (ListUtil.isInList(
        ingredientProvider.ingredientCalculationList, ingredient)) {
      ingredientProvider.removeIngredient(ingredient.id!);
    } else {
      ingredientProvider.addIngredient(ingredient);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Ingredient> _selectedIngredients =
        Provider.of<IngredientProvider>(context, listen: false)
            .ingredientCalculationList;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recherche"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (_selectedIngredients.isNotEmpty) {
                      Navigator.of(context).pushNamed('/calculate');
                    }
                  },
                  icon: const Icon(
                    Icons.check,
                    size: 30,
                  ),
                ),
                Text(
                  _selectedIngredients.length.toString(),
                )
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              IngredientSearch(
                searchInput: Input(
                  label: "Rechercher un ingrédient",
                  controller: _searchIngredient,
                  onChanged: (_) => _searchIngredientByName(),
                  keyboardType: TextInputType.text,
                ),
              ),
              Column(
                children: _searchIngredient.text != ''
                    ? _searchedIngredients
                        .map(
                          (ingredient) => Card(
                            color: ListUtil.isInList(
                                    _selectedIngredients, ingredient)
                                ? Colors.deepPurple
                                : Colors.white,
                            child: TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(
                                    ListUtil.isInList(
                                            _selectedIngredients, ingredient)
                                        ? Colors.white
                                        : Colors.deepPurple),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20.0),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  ingredient.name,
                                ),
                              ),
                              onPressed: () =>
                                  selectIngredient(ingredient, context),
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
    );
  }
}

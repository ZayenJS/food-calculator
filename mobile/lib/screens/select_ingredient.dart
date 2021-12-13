import 'package:flutter/material.dart';
import 'package:food_calculator/classes/ingredient.dart';
import 'package:food_calculator/classes/input.dart';
import 'package:food_calculator/providers/ingredient.dart';
import 'package:food_calculator/widgets/ingredient_search.dart';
import 'package:provider/provider.dart';

class SelectIngredient extends StatefulWidget {
  const SelectIngredient({Key? key}) : super(key: key);

  @override
  _SelectIngredientState createState() => _SelectIngredientState();
}

class _SelectIngredientState extends State<SelectIngredient> {
  final TextEditingController _searchIngredient = TextEditingController();
  List<Ingredient> _ingredients = [];
  Set<Ingredient> _selectedIngredients = {};

  void _searchIngredientByName() async {
    String name = _searchIngredient.text;
    var ingredients = await Ingredient.findByName(name);

    setState(() {
      _ingredients = ingredients;
    });
  }

  void selectIngredient(Ingredient ingredient, BuildContext context) {
    Set<Ingredient> updatedSelectedIngredients = {..._selectedIngredients};

    if (isInSet(ingredient)) {
      updatedSelectedIngredients
          .removeWhere((element) => element.id == ingredient.id);
    } else {
      updatedSelectedIngredients.add(ingredient);
      Provider.of<IngredientProvider>(context, listen: false)
          .addIngredient(ingredient);
    }

    setState(() {
      _selectedIngredients = updatedSelectedIngredients;
    });
  }

  bool isInSet(Ingredient ingredient) {
    List<int> selectedIngredientIds =
        _selectedIngredients.map((e) => e.id!).toList();

    return selectedIngredientIds.contains(ingredient.id);
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<IngredientProvider>(context).ingredientCalculationList);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recherche"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => _selectedIngredients.isNotEmpty
                      ? Navigator.of(context).pushNamed(
                          '/calculate',
                          arguments: _selectedIngredients,
                        )
                      : null,
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
                ),
              ),
              Column(
                children: _searchIngredient.text != ''
                    ? _ingredients
                        .map(
                          (ingredient) => Card(
                            color: isInSet(ingredient)
                                ? Colors.deepPurple
                                : Colors.white,
                            child: TextButton(
                              style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                      isInSet(ingredient)
                                          ? Colors.white
                                          : Colors.deepPurple),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(20.0))),
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_calculator/classes/ingredient.dart';
import 'package:food_calculator/providers/ingredient.dart';
import 'package:food_calculator/utils/calculation_util.dart';
import 'package:provider/provider.dart';

class Calculate extends StatefulWidget {
  const Calculate({
    Key? key,
  }) : super(key: key);

  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  Map<String, TextEditingController> controllers = {};

  // double getTotal(BuildContext context, String column) {
  //   List<Ingredient> ingredients =
  //       Provider.of<IngredientProvider>(context).ingredientCalculationList;
  //   double total = 0;

  //   for (Ingredient ingredient in ingredients) {
  //     if (column == 'quantity') continue;

  //     total += ingredient.toJson()[column];
  //   }

  //   return total;
  // }

  void populateControllers(BuildContext context) {
    Map<String, TextEditingController> updatedControllers = {};
    List<Ingredient> ingredients =
        Provider.of<IngredientProvider>(context).ingredientCalculationList;

    for (Ingredient ingredient in ingredients) {
      updatedControllers[ingredient.name] = TextEditingController();
    }

    setState(() {
      controllers = updatedControllers;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controllers.isEmpty) {
      populateControllers(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calcul"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ...Provider.of<IngredientProvider>(context)
                  .ingredientCalculationList
                  .map<Widget>(
                    (ingredient) => _IngredientDetails(ingredient: ingredient),
                  )
                  .toList(),
              const _CalculationTotal()
            ],
          ),
        ),
      ),
    );
  }
}

class _IngredientDetails extends StatefulWidget {
  final Ingredient ingredient;

  const _IngredientDetails({
    Key? key,
    required this.ingredient,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IngredientDetailsState();
}

class _IngredientDetailsState extends State<_IngredientDetails> {
  String? _inputValue;
  bool _isDetailTableVisible = false;

  void _toggleDataTable() {
    setState(() {
      _isDetailTableVisible = !_isDetailTableVisible;
    });
  }

  @override
  void initState() {
    _inputValue = widget.ingredient.quantity?.toStringAsFixed(0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _inputChange(String value, BuildContext context) => setState(() {
        _inputValue = value.toString().isEmpty ? '0' : value;

        final Ingredient ingredient = widget.ingredient;

        Provider.of<IngredientProvider>(context, listen: false)
            .updateIngredientsCalculationList(
          Ingredient.withQuantity(
            id: ingredient.id,
            name: ingredient.name,
            calories: ingredient.calories,
            proteins: ingredient.proteins,
            carbohydrates: ingredient.carbohydrates,
            sugars: ingredient.sugars,
            fats: ingredient.fats,
            saturated: ingredient.saturated,
            fibers: ingredient.fibers,
            salt: ingredient.salt,
            quantity: double.parse(_inputValue!),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    final String ingredientName = widget.ingredient.name[0].toUpperCase() +
        widget.ingredient.name.substring(1);

    final double _muliplicationFactor =
        (double.parse(_inputValue ?? "100") / 100);

    Map<String, dynamic> jsonIngredient = widget.ingredient.toJson();

    List<DataRow> ingredientRow = [];

    jsonIngredient.forEach((key, value) {
      if (key != 'name') {
        final String unit = key == 'calories' ? 'kcal' : 'g';

        final String fixedValue =
            double.parse((value * _muliplicationFactor).toString())
                .toStringAsFixed(2);

        ingredientRow.add(
          DataRow(
            cells: [
              DataCell(Text(key[0].toUpperCase() + key.substring(1))),
              DataCell(Text("$fixedValue $unit")),
              DataCell(Text("$value $unit")),
            ],
          ),
        );
      }
    });

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(ingredientName),
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5.0,
                  child: TextFormField(
                    initialValue: _inputValue,
                    decoration: const InputDecoration(label: Text('Quantité')),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) => _inputChange(value, context),
                  ),
                ),
                const Text('g'),
                const SizedBox(
                  width: 50.0,
                ),
                IconButton(
                  onPressed: _toggleDataTable,
                  icon: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: Transform.rotate(
                      angle: _isDetailTableVisible ? 0.0 : 110.0,
                      child: const Icon(
                        Icons.arrow_drop_down_circle_outlined,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        if (_isDetailTableVisible)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text("Details $ingredientName"),
              ),
              DataTable(
                columns: <DataColumn>[
                  const DataColumn(label: Text('Nom')),
                  DataColumn(label: Text('${_inputValue}g')),
                  const DataColumn(label: Text('100g')),
                ],
                rows: ingredientRow,
              ),
            ],
          ),
      ],
    );
  }
}

class _CalculationTotal extends StatelessWidget {
  const _CalculationTotal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Ingredient> ingredientList =
        Provider.of<IngredientProvider>(context).ingredientCalculationList;
    List<double> quantities =
        CalculationUtil.getTotalByField(ingredientList, "quantity");

    double totalQuantity = CalculationUtil.getTotal(quantities);

    double dividerFactor = totalQuantity / 100;

    CalculationResult totalCalories = CalculationUtil.getTotalAndFor100(
        ingredientList, "calories", dividerFactor);

    CalculationResult totalProteins = CalculationUtil.getTotalAndFor100(
        ingredientList, "proteins", dividerFactor);

    CalculationResult totalCarbohydrates = CalculationUtil.getTotalAndFor100(
        ingredientList, "carbohydrates", dividerFactor);

    CalculationResult totalSugars = CalculationUtil.getTotalAndFor100(
        ingredientList, "sugars", dividerFactor);

    CalculationResult totalFats = CalculationUtil.getTotalAndFor100(
        ingredientList, "fats", dividerFactor);

    CalculationResult totalSaturated = CalculationUtil.getTotalAndFor100(
        ingredientList, "saturated", dividerFactor);

    CalculationResult totalFibers = CalculationUtil.getTotalAndFor100(
        ingredientList, "fibers", dividerFactor);

    CalculationResult totalSalt = CalculationUtil.getTotalAndFor100(
        ingredientList, "salt", dividerFactor);

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0),
          child: Text(
            "Resultat final du calcul",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        DataTable(columns: [
          const DataColumn(
            label: Text('Total'),
          ),
          DataColumn(
            label: Text('${totalQuantity.toStringAsFixed(2)}g'),
          ),
          const DataColumn(
            label: Text('100.00g'),
          ),
        ], rows: [
          DataRow(
            cells: [
              const DataCell(
                Text('Calories'),
              ),
              DataCell(
                Text('${totalCalories.total.toStringAsFixed(2)}kcal'),
              ),
              DataCell(
                Text('${totalCalories.for100.toStringAsFixed(2)}kcal'),
              ),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(
                Text('Protéines'),
              ),
              DataCell(
                Text('${totalProteins.total.toStringAsFixed(2)}g'),
              ),
              DataCell(
                Text('${totalProteins.for100.toStringAsFixed(2)}g'),
              ),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(
                Text('Glucides'),
              ),
              DataCell(
                Text('${totalCarbohydrates.total.toStringAsFixed(2)}g'),
              ),
              DataCell(
                Text('${totalCarbohydrates.for100.toStringAsFixed(2)}g'),
              ),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(
                Text('Sucres'),
              ),
              DataCell(
                Text('${totalSugars.total.toStringAsFixed(2)}g'),
              ),
              DataCell(
                Text('${totalSugars.for100.toStringAsFixed(2)}g'),
              ),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(
                Text('Lipides'),
              ),
              DataCell(
                Text('${totalFats.total.toStringAsFixed(2)}g'),
              ),
              DataCell(
                Text('${totalFats.for100.toStringAsFixed(2)}g'),
              ),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(
                Text('Saturés'),
              ),
              DataCell(
                Text('${totalSaturated.total.toStringAsFixed(2)}g'),
              ),
              DataCell(
                Text('${totalSaturated.for100.toStringAsFixed(2)}g'),
              ),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(
                Text('Fibres'),
              ),
              DataCell(
                Text('${totalFibers.total.toStringAsFixed(2)}g'),
              ),
              DataCell(
                Text('${totalFibers.for100.toStringAsFixed(2)}g'),
              ),
            ],
          ),
          DataRow(
            cells: [
              const DataCell(
                Text('Sel'),
              ),
              DataCell(
                Text('${totalSalt.total.toStringAsFixed(2)}g'),
              ),
              DataCell(
                Text('${totalSalt.for100.toStringAsFixed(2)}g'),
              ),
            ],
          ),
        ]),
      ],
    );
  }
}

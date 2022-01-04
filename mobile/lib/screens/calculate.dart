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

  double getTotal(BuildContext context, String column) {
    List<Ingredient> ingredients =
        Provider.of<IngredientProvider>(context).ingredientCalculationList;
    double total = 0;

    for (Ingredient ingredient in ingredients) {
      if (column == 'quantity') continue;

      total += ingredient.toJson()[column];
    }

    return total;
  }

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
  String _inputValue = '100';
  bool _isDetailTableVisible = false;

  void _toggleDataTable() {
    setState(() {
      _isDetailTableVisible = !_isDetailTableVisible;
    });
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
            quantity: double.parse(_inputValue),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    final String ingredientName = widget.ingredient.name[0].toUpperCase() +
        widget.ingredient.name.substring(1);
    final double _muliplicationFactor = (double.parse(_inputValue) / 100);
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
              DataCell(Text("$value $unit")),
              DataCell(
                Text("$fixedValue $unit"),
              ),
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
            Text(ingredientName),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
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
                  icon: const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (_isDetailTableVisible)
          DataTable(
            columns: <DataColumn>[
              const DataColumn(label: Text('Nom')),
              const DataColumn(label: Text('100g')),
              DataColumn(label: Text('${_inputValue}g')),
            ],
            rows: ingredientRow,
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
        ingredientList.map((i) => i.quantity as double).toList();
    List<double> calories = ingredientList.map((i) => i.calories).toList();
    List<double> proteins = ingredientList.map((i) => i.proteins).toList();
    List<double> carbohydrates =
        ingredientList.map((i) => i.carbohydrates).toList();
    List<double> sugars = ingredientList.map((i) => i.sugars).toList();
    List<double> fats = ingredientList.map((i) => i.fats).toList();
    List<double> saturated = ingredientList.map((i) => i.saturated).toList();
    List<double> fibers = ingredientList.map((i) => i.fibers).toList();
    List<double> salt = ingredientList.map((i) => i.salt).toList();

    double total = CalculationUtil.getTotal(quantities);
    double totalCalories = CalculationUtil.getTotal(calories);
    double totalProteins = CalculationUtil.getTotal(proteins);
    double totalCarbohydrates = CalculationUtil.getTotal(carbohydrates);
    double totalSugars = CalculationUtil.getTotal(sugars);
    double totalFats = CalculationUtil.getTotal(fats);
    double totalSaturated = CalculationUtil.getTotal(saturated);
    double totalFibers = CalculationUtil.getTotal(fibers);
    double totalSalt = CalculationUtil.getTotal(salt);

    double divisionFactor = total / 100;

    return DataTable(columns: [
      const DataColumn(
        label: Text('Total'),
      ),
      DataColumn(
        label: Text('${total.toStringAsFixed(2)}g'),
      ),
      const DataColumn(
        label: Text('100g'),
      ),
    ], rows: [
      DataRow(
        cells: [
          const DataCell(
            Text('Calories'),
          ),
          DataCell(
            Text('${totalCalories.toStringAsFixed(2)}kcal'),
          ),
          DataCell(
            Text('${(totalCalories / divisionFactor).toStringAsFixed(2)}kcal'),
          ),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(
            Text('Protéines'),
          ),
          DataCell(
            Text('${totalProteins.toStringAsFixed(2)}g'),
          ),
          DataCell(
            Text('${(totalProteins / divisionFactor).toStringAsFixed(2)}g'),
          ),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(
            Text('Glucides'),
          ),
          DataCell(
            Text('${totalCarbohydrates.toStringAsFixed(2)}g'),
          ),
          DataCell(
            Text(
                '${(totalCarbohydrates / divisionFactor).toStringAsFixed(2)}g'),
          ),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(
            Text('Sucres'),
          ),
          DataCell(
            Text('${totalSugars.toStringAsFixed(2)}g'),
          ),
          DataCell(
            Text('${(totalSugars / divisionFactor).toStringAsFixed(2)}g'),
          ),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(
            Text('Lipides'),
          ),
          DataCell(
            Text('${totalFats.toStringAsFixed(2)}g'),
          ),
          DataCell(
            Text('${(totalFats / divisionFactor).toStringAsFixed(2)}g'),
          ),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(
            Text('Saturés'),
          ),
          DataCell(
            Text('${totalSaturated.toStringAsFixed(2)}g'),
          ),
          DataCell(
            Text('${(totalSaturated / divisionFactor).toStringAsFixed(2)}g'),
          ),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(
            Text('Fibres'),
          ),
          DataCell(
            Text('${totalFibers.toStringAsFixed(2)}g'),
          ),
          DataCell(
            Text('${(totalFibers / divisionFactor).toStringAsFixed(2)}g'),
          ),
        ],
      ),
      DataRow(
        cells: [
          const DataCell(
            Text('Sel'),
          ),
          DataCell(
            Text('${totalSalt.toStringAsFixed(2)}g'),
          ),
          DataCell(
            Text('${(totalSalt / divisionFactor).toStringAsFixed(2)}g'),
          ),
        ],
      ),
    ]);
  }
}

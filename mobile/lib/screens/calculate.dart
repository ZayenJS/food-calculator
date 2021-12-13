import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_calculator/classes/ingredient.dart';
import 'package:food_calculator/providers/ingredient.dart';
import 'package:provider/provider.dart';

class Calculate extends StatefulWidget {
  Set<Ingredient> ingredients;

  Calculate({Key? key, required this.ingredients}) : super(key: key);

  @override
  _CalculateState createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  Map<String, TextEditingController> controllers = {};

  double getTotal(String column) {
    double total = 0;

    for (Ingredient ingredient in widget.ingredients) {
      if (column == 'quantity') continue;

      total += ingredient.toJson()[column];
    }

    return total;
  }

  void populateControllers() {
    Map<String, TextEditingController> updatedControllers = {};

    for (Ingredient ingredient in widget.ingredients) {
      updatedControllers[ingredient.name] = TextEditingController();
    }

    setState(() {
      controllers = updatedControllers;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controllers.isEmpty) {
      populateControllers();
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
    List<double?> quantities = ingredientList.map((i) => i.quantity).toList();

    print('quantities: $quantities');

    double? total = quantities.isEmpty
        ? 0.0
        : quantities.reduce((value, element) => value! + element!);

    return DataTable(columns: [
      const DataColumn(
        label: Text('Total'),
      ),
      DataColumn(
        label: Text('${total?.toStringAsFixed(2)}g'),
      ),
      const DataColumn(
        label: Text('100g'),
      ),
    ], rows: const [
      DataRow(
        cells: [
          DataCell(
            Text('Calories'),
          ),
          DataCell(
            Text('computed total'),
          ),
          DataCell(
            Text(''),
          ),
        ],
      ),
      DataRow(
        cells: [
          DataCell(
            Text('Protéines'),
          ),
          DataCell(
            Text('computed total'),
          ),
          DataCell(
            Text(''),
          ),
        ],
      ),
      DataRow(
        cells: [
          DataCell(
            Text('Glucides'),
          ),
          DataCell(
            Text('computed total'),
          ),
          DataCell(
            Text(''),
          ),
        ],
      ),
      DataRow(
        cells: [
          DataCell(
            Text('Sucres'),
          ),
          DataCell(
            Text('computed total'),
          ),
          DataCell(
            Text(''),
          ),
        ],
      ),
      DataRow(
        cells: [
          DataCell(
            Text('Lipides'),
          ),
          DataCell(
            Text('computed total'),
          ),
          DataCell(
            Text(''),
          ),
        ],
      ),
      DataRow(
        cells: [
          DataCell(
            Text('Sucres'),
          ),
          DataCell(
            Text('computed total'),
          ),
          DataCell(
            Text(''),
          ),
        ],
      ),
      DataRow(
        cells: [
          DataCell(
            Text('Sel'),
          ),
          DataCell(
            Text('computed total'),
          ),
          DataCell(
            Text(''),
          ),
        ],
      ),
    ]);
  }
}

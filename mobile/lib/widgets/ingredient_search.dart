import 'package:flutter/material.dart';
import 'package:food_calculator/classes/input.dart';

import 'input_group.dart';

class IngredientSearch extends StatelessWidget {
  final Input searchInput;

  IngredientSearch({
    required this.searchInput,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputGroup(
          field1: searchInput,
        ),
      ],
    );
  }
}

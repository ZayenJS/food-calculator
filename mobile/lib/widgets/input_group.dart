import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_calculator/classes/decimal_text_input_formatter.dart';

import '../classes/input.dart';

class InputGroup extends StatelessWidget {
  final Input field1;
  final Input? field2;

  const InputGroup({Key? key, required this.field1, this.field2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rowContent = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextFormField(
                keyboardType: field1.keyboardType,
                decoration: InputDecoration(labelText: field1.label),
                controller: field1.controller,
                onChanged: field1.onChanged,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ce champs est obligatoire';
                  }
                },
                inputFormatters: [
                  if (field1.keyboardType == TextInputType.number)
                    DecimalTextInputFormatter()
                ],
              ),
            ],
          ),
        ),
      )
    ];

    if (field2?.label != null) {
      rowContent.add(Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextFormField(
                keyboardType: field2!.keyboardType,
                decoration: InputDecoration(labelText: field2!.label),
                controller: field2!.controller,
                onChanged: field2!.onChanged,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ce champs est obligatoire';
                  }
                },
                inputFormatters: [
                  if (field2!.keyboardType == TextInputType.number)
                    DecimalTextInputFormatter()
                ],
              ),
            ],
          ),
        ),
      ));
    }

    return Row(children: rowContent);
  }
}

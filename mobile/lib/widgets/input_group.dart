import 'package:flutter/material.dart';

import '../classes/input.dart';

class InputGroup extends StatelessWidget {
  final Input field1;
  final Input? field2;

  InputGroup({required this.field1, this.field2});

  Padding getErrorMessage(Input? field) {
    if (field != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          field.error ?? '',
          style: TextStyle(
              color: field.error != '' ? Colors.red : Colors.transparent),
        ),
      );
    }

    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rowContent = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: field1.label),
                controller: field1.controller,
                onChanged: field1.onChanged,
              ),
              getErrorMessage(field1)
            ],
          ),
        ),
      )
    ];

    if (field2?.label != null) {
      rowContent.add(
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: field2!.label),
                  controller: field2!.controller,
                  onChanged: field2?.onChanged,
                ),
                getErrorMessage(field2)
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      children: rowContent,
    );
  }
}

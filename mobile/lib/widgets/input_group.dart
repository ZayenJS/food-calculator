import 'package:flutter/material.dart';

import '../classes/input.dart';

class InputGroup extends StatelessWidget {
  final Input field1;
  final Input? field2;

  InputGroup({required this.field1, this.field2});

  @override
  Widget build(BuildContext context) {
    List<Widget> rowContent = [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            decoration: InputDecoration(labelText: field1.text),
            controller: field1.controller,
          ),
        ),
      )
    ];

    if (field2?.text != null) {
      rowContent.add(
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(labelText: field2!.text),
              controller: field2!.controller,
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

import 'package:flutter/material.dart';
import 'package:food_calculator/classes/input.dart';

import '../../widgets/input_group.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  TextEditingController name = TextEditingController();
  TextEditingController calories = TextEditingController();
  TextEditingController proteins = TextEditingController();
  TextEditingController carbohydrates = TextEditingController();
  TextEditingController sugars = TextEditingController();
  TextEditingController fats = TextEditingController();
  TextEditingController saturated = TextEditingController();
  TextEditingController salt = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: const Icon(Icons.restaurant),
        ),
        leadingWidth: 40,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/add-ingredient'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec lacinia nec dolor in imperdiet. Quisque tristique dignissim tortor, in porta.")
            ],
          ),
        ),
      ),
    );
  }
}

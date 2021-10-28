import 'package:flutter/material.dart';
import 'package:food_calculator/screens/AddIngredient/add_ingredient.dart';

import './screens/Home/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Calculator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(title: 'Food Calculator'),
        "/add-ingredient": (context) =>
            AddIngredient(title: "Ajouter un ingrédient")
      },
    );
  }
}

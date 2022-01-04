import 'package:flutter/material.dart';
import 'package:food_calculator/classes/route_generator.dart';
import 'package:food_calculator/providers/ingredient.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IngredientProvider(),
      child: MaterialApp(
        title: 'Food Calculator',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          snackBarTheme: SnackBarThemeData(backgroundColor: Colors.deepPurple),
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_calculator/classes/ingredient.dart';
import 'package:food_calculator/screens/screens.dart';

class RouteGenerator {
  static Route<dynamic> _errorRoute() => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('Error'),
          ),
        ),
      );

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const Home(title: "Food Calculator"),
        );
      case '/add-ingredient':
        return MaterialPageRoute(
          builder: (_) => AddIngredient(title: "Ajouter un ingrédient"),
        );
      case "/search-ingredient":
        return MaterialPageRoute(
          builder: (_) => const SelectIngredient(),
        );
      case "/calculate":
        if (args is Set<Ingredient>) {
          return MaterialPageRoute(
            builder: (_) => Calculate(
              ingredients: args,
            ),
          );
        }

        return _errorRoute();
      default:
        return _errorRoute();
    }
  }
}

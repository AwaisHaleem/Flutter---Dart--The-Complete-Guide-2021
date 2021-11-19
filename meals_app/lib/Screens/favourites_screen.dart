import 'package:flutter/material.dart';
import 'package:meals_app/Models/meal.dart';

class FavouritesScreen extends StatelessWidget {
  List<Meal> favouriteMeals;

  FavouritesScreen({required this.favouriteMeals});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Favorite Meals"),
    );
  }
}

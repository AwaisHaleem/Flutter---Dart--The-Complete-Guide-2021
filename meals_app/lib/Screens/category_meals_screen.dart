import 'package:flutter/material.dart';

import '../Models/meal.dart';
import '../Widgets/meal_item.dart';


class CategoryMealsScreen extends StatefulWidget {
  static const routName = '/category-meals';
  final List<Meal> availableMeals;

  CategoryMealsScreen({required this.availableMeals});

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;
  bool _loadedInItData = false;


  @override
  void didChangeDependencies() {
    if (_loadedInItData == false) {
      final Map routArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routArgs['categoryTitle'];
      final String categoryId = routArgs['categoryId'];
      displayedMeals = widget.availableMeals
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      _loadedInItData = true;
    }

    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeals!.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("categoryTitle"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext ctx, index) {
          return MealItem(
            id: displayedMeals![index].id,
            url: displayedMeals![index].imageUrl,
            title: displayedMeals![index].title,
            duration: displayedMeals![index].duration,
            complexity: displayedMeals![index].complexity,
            affordability: displayedMeals![index].affordability,
            // removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals!.length,
      ),
    );
  }
}

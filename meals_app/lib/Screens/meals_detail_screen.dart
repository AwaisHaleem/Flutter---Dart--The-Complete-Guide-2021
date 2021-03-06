import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routName = "/meal_detail_screen";
  final Function toggleFavourite;
  final Function isMealFavourite;

  const MealDetailScreen({required this.toggleFavourite, required this.isMealFavourite});

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildTitle(selectedMeal.title, context),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (context, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      selectedMeal.ingredients[index],
                    ),
                  ),
                ),
              ),
            ),
            buildTitle("Steps", context),
            buildContainer(
              ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text("# ${(index + 1)}"),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider()
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isMealFavourite(mealId)? Icon(Icons.star): Icon(Icons.star_border),
        onPressed: ()=>toggleFavourite(mealId),
      ),
    );
  }

  Container buildTitle(String text, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}

Container buildContainer(Widget child) {
  return Container(
      height: 150,
      width: 300,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child);
}

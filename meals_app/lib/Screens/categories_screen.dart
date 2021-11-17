import 'package:flutter/material.dart';

import '../Widgets/category_item.dart';
import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES
            .map(
              (catDate) => CategoryItem(
                  id: catDate.id, title: catDate.title, color: catDate.color),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
      ),
    );
  }
}

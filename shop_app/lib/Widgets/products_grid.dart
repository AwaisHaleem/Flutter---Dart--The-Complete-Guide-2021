import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showfav;
  ProductsGrid({required this.showfav});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = showfav? productData.favoriteItems: productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (ctx) => products[i],
        value: products[i],
        child: ProductItem(
            // id: products[i].id,
            // title: products[i].title,
            // imgUrl: products[i].imageUrl
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}

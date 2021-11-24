import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Screens/edit_products_screen.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/user_product_item.dart';

import '../Provider/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';

  @override
  Widget build(BuildContext context) {
    final _productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (_, index) => Column(
            children: [
              UserProductItem(
                id: _productsData.items[index].id,
                title: _productsData.items[index].title,
                imageUrl: _productsData.items[index].imageUrl,
              ),
              Divider()
            ],
          ),
          itemCount: _productsData.items.length,
        ),
      ),
    );
  }
}

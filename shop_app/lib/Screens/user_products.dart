import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Screens/edit_products_screen.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/user_product_item.dart';

import '../Provider/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-product';

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndShow(true);
  }

  @override
  Widget build(BuildContext context) {
    // final _productsData = Provider.of<Products>(context);
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
      body: FutureBuilder(
        future: _refreshData(context),
        builder: (context, snapShot) =>
            snapShot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshData(context),
                    child: Consumer<Products>(
                      builder: (context, _productsData, _) => Padding(
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
                    ),
                  ),
      ),
    );
  }
}

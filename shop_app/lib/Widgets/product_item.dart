import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Provider/auth.dart';
import 'package:shop_app/Provider/cart.dart';
import 'package:shop_app/Provider/product.dart';
import 'package:shop_app/Screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imgUrl;

  // ProductItem({required this.id, required this.title, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailScreen.routName, arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border),
              onPressed: () async {
                try {
                  await product.toggleFavourite(product.isFavourite, product, auth.token, auth.userId);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Favourite Status couldn't changed",
                    textAlign: TextAlign.center,
                  )));
                }
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.title, product.price);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Product Added'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "Undo",
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}

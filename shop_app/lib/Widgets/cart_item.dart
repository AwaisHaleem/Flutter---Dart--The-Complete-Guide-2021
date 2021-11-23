import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/cart.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String id;
  final String prodId;
  final double price;
  final int quantity;

  CartItem(
      {required this.id,
      required this.prodId,
      required this.title,
      required this.price,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(prodId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(
                child: Text(
                  "\$${price.toString()}",
                ),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text("Total: \$${price * quantity}"),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}

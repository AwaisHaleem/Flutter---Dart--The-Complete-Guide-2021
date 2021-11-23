import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Widgets/app_drawer.dart';

import '../Provider/orders.dart' show Orders;
import '../Widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routName = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx, index) => OrderItem(
          order: ordersData.orders[index],
        ),
      ),
    );
  }
}

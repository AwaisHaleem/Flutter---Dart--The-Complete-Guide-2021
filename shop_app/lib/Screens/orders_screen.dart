import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Widgets/app_drawer.dart';

import '../Provider/orders.dart' show Orders;
import '../Widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future? _ordersFuture;

  Future _obtainedOrderFutur() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  // it will store futer even if our widgets rebuilds again and again
  @override
  void initState() {
    _ordersFuture = _obtainedOrderFutur();
    super.initState();
  }
  // @override
  // void initState() {
  //   Future.delayed(Duration.zero).then((_) async {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });

  //   super.initState();
  // }

  // @override
  // void initState() {
  //   _isLoading = true;
  //   Provider.of<Orders>(context, listen: false)
  //       .fetchAndSetOrders()
  //       .then((value) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future:
              // Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
              _obtainedOrderFutur(),
          builder: (ctx, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapShot.error != null) {
              return Center(
                child: Text("An erroe Occured"),
              );
            } else {
              return Consumer<Orders>(builder: (ctx, orderData, _) {
                return ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, index) => OrderItem(
                    order: orderData.orders[index],
                  ),
                );
              });
            }
          }),
    );
  }
}

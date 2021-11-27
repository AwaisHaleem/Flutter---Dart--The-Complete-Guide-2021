import 'package:flutter/cupertino.dart';
import 'package:shop_app/Provider/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        "https://shop-app-84dbd-default-rtdb.firebaseio.com/orders.json");
    final res = await http.get(url);
    final _loadedOrderData = json.decode(res.body) as Map<String, dynamic>;
    if (_loadedOrderData == null) {
      return;
    }
    List<OrderItem> _loadedOrders = [];
    _loadedOrderData.forEach((orderId, item) {
      _loadedOrders.add(OrderItem(
          id: orderId,
          amount: item["amount"],
          products: (item['products'] as List<dynamic>).map((prod) {
            return CartItem(
                id: prod['id'],
                title: prod['title'],
                quantity: prod['quantity'],
                price: prod['price']);
          }).toList(),
          dateTime: DateTime.parse(item['dateTime'])));
    });
    _orders = _loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        "https://shop-app-84dbd-default-rtdb.firebaseio.com/orders.json");

    final timeStamp = DateTime.now();

    await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((prod) => {
                    'id': timeStamp.toString(),
                    'price': prod.price,
                    'quantity': prod.quantity,
                    'title': prod.title
                  })
              .toList()
        }));
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}

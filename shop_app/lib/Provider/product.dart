import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/Models/fav_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isFavourite = false});

  Future<void> toggleFavourite(bool isFav, Product prod) async {
    final url = Uri.parse(
        "https://shop-app-84dbd-default-rtdb.firebaseio.com/products/${prod.id}.json");

    prod.isFavourite = !isFav;
    notifyListeners();

    final res =
        await http.patch(url, body: json.encode({"isFavourite": !isFav}));

    if (res.statusCode >= 400) {
      prod.isFavourite = isFav;
      notifyListeners();
      throw favEception(message: "Fav Status could not changed");
    }
  }
}

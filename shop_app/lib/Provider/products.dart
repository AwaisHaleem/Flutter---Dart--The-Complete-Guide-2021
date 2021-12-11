import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/Models/http_exception.dart';
import 'package:shop_app/Provider/product.dart';

class Products with ChangeNotifier {
  List<Product>? _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String? authToken;
  final String? userId;
  Products(this.authToken, this._items, this.userId);

  // var _showFavouriteOnly = false;

  List<Product> get items {
    // if (_showFavouriteOnly) {
    //   return _items!.where((prod) => prod.isFavourite).toList();
    // } else {
    return [..._items!];
  }

  List<Product> get favoriteItems {
    return _items!.where((prodItem) => prodItem.isFavourite).toList();
  }

  // void showFavouriteOnly() {
  //   _showFavouriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavouriteOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndShow([var filterByUser = false]) async {
    String filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';

    var url = Uri.parse(
        'https://shop-app-84dbd-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString');
    try {
      final res = await http.get(url);
      final Map _cloudLoadedProducts =
          json.decode(res.body) as Map<String, dynamic>;
      if (_cloudLoadedProducts == null) {
        return;
      }

      url = Uri.parse(
          "https://shop-app-84dbd-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$authToken");

      final favouritesResponse = await http.get(url);
      final _favouritesData = json.decode(favouritesResponse.body);

      List<Product> _cloudProducts = [];
      _cloudLoadedProducts.forEach((prodId, product) {
        _cloudProducts.add(Product(
            id: prodId,
            title: product['title'],
            description: product['description'],
            price: product['price'],
            imageUrl: product['imageUrl'],
            isFavourite: _favouritesData == null
                ? false
                : _favouritesData[prodId] ?? false));
      });
      _items = _cloudProducts;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProduct(Product prod) async {
    final url = Uri.parse(
        "https://shop-app-84dbd-default-rtdb.firebaseio.com/products.json?auth=$authToken");
    final String prodObj = json.encode({
      'title': prod.title,
      'description': prod.description,
      'price': prod.price,
      'imageUrl': prod.imageUrl,
      'creatorId': userId
    });
    try {
      final res = await http.post(url, body: prodObj);

      Product _newProd = Product(
          id: json.decode(res.body)['name'],
          title: prod.title,
          description: prod.description,
          price: prod.price,
          imageUrl: prod.imageUrl);

      _items!.add(_newProd);
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Product findById(String id) {
    return _items!.firstWhere((prod) => prod.id == id);
  }

  Future<void> replaceProduct(String id, Product newProduct) async {
    final int _itemIndex = _items!.indexWhere((element) => element.id == id);
    if (_itemIndex >= 0) {
      final url = Uri.parse(
          "https://shop-app-84dbd-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken");
      try {
        await http.patch(url,
            body: json.encode({
              "title": newProduct.title,
              "description": newProduct.description,
              "price": newProduct.price,
              "imageUrl": newProduct.imageUrl
            }));
      } catch (e) {}

      _items![_itemIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        "https://shop-app-84dbd-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken");

    final _existingProductId =
        _items!.indexWhere((element) => element.id == id);
    Product? _existingProduct = _items![_existingProductId];

    _items!.removeAt(_existingProductId);
    notifyListeners();

    final res = await http.delete(url);
    if (res.statusCode >= 400) {
      _items!.insert(_existingProductId, _existingProduct);
      throw httpException(message: "Product couldn't deleted");
    }
    _existingProduct = null;

    notifyListeners();
  }
}

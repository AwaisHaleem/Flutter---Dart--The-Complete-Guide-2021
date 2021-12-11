import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Provider/auth.dart';
import 'package:shop_app/Screens/auth_screen.dart';
import 'package:shop_app/Screens/edit_products_screen.dart';
import 'package:shop_app/Screens/orders_screen.dart';
import 'package:shop_app/Screens/splash_screen.dart';
import 'package:shop_app/Screens/user_products.dart';
import 'package:shop_app/Widgets/user_product_item.dart';

import '../Provider/cart.dart';
import '../Provider/orders.dart';
import './Screens/cart_screen.dart';
import './Screens/product_detail_screen.dart';
import './Screens/product_overview_screen.dart';
import './Provider/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products(null, [], null),
            update: (ctx, auth, previousProducts) => Products(
                auth.token,
                previousProducts == null ? [] : previousProducts.items,
                auth.userId),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) =>
                Orders(token: null, userId: null, initialOrders: []),
            update: (ctx, auth, previousOrders) => Orders(
                token: auth.token,
                userId: auth.userId,
                initialOrders:
                    previousOrders == null ? [] : previousOrders.orders),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyShop',
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato'),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogIn(),
                    builder: (ctx, authResultSnapShot) =>
                        authResultSnapShot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              // '/': (ctx) => ProductOverviewScreen(),
              ProductDetailScreen.routName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductsScreen.routeName: (ctx) => EditProductsScreen()
            },
          ),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}

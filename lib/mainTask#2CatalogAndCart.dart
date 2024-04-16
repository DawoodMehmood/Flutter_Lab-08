import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'providers/shopping_cart_provider.dart';
import 'screens/cart_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShoppingCart()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/catalog': (context) => CatalogScreen(),
        '/cart': (context) => CartScreen()
      },
    );
  }
}

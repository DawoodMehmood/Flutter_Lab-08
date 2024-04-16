import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ShoppingCart with ChangeNotifier {
  final uri = 'https://fakestoreapi.com/products/';

  List<Product> products = [];
  Set<int> shoppingCart = {};

  List<Product> get productInCarts =>
      products.where((element) => isInCart(element.id)).toList();

  double get totalPrice {
    var sum = 0.0;
    for (final product in productInCarts) {
      sum += product.price;
    }
    return sum;
  }

  Future<void> retrieveProducts() async {
    final result = await http.get(
      Uri.parse(uri),
    );
    products = (jsonDecode(result.body) as List).map((element) {
      return Product.fromJson(element as Map<String, dynamic>);
    }).toList();

    notifyListeners();
  }

  void addToCart(int id) {
    shoppingCart.add(id);
    notifyListeners();
  }

  void removeFromCart(int id) {
    shoppingCart.remove(id);
    notifyListeners();
  }

  bool isInCart(int id) {
    return shoppingCart.contains(id);
  }
}

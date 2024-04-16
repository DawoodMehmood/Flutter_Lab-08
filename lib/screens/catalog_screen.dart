import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/shopping_cart_provider.dart';

class CatalogScreen extends StatefulWidget {
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  void initState() {
    super.initState();
    final cart = context.read<ShoppingCart>();

    cart.retrieveProducts();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<ShoppingCart>();
    final products = cart.products;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catalog',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: products.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ListTile(
                    leading: Image.network(
                      products[index].url,
                      height: 50,
                    ),
                    title: Text(products[index].title),
                    trailing: cart.isInCart(products[index].id)
                        ? const Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : TextButton(
                            onPressed: () {
                              cart.addToCart(products[index].id);
                            },
                            child: const Text('ADD'),
                          ),
                  ),
                );
              },
              itemCount: products.length,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

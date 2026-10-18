import 'package:flutter/material.dart';
import '../models/product.dart';

class Cart extends ChangeNotifier {
  final Map<int, int> _quantities = {};
  final Map<int, Product> _products = {};
  List<Product> get products => List.unmodifiable(_products.values);
  int quantity(Product product) => _quantities[product.id] ?? 0;
  int get count => _quantities.values.fold(0, (a, b) => a + b);
  double get total => products.fold(0, (sum, p) => sum + p.price * quantity(p));
  void add(Product product) {
    _products[product.id] = product;
    _quantities[product.id] = quantity(product) + 1;
    notifyListeners();
  }

  void remove(Product product) {
    final next = quantity(product) - 1;
    if (next <= 0) {
      _quantities.remove(product.id);
      _products.remove(product.id);
    } else {
      _quantities[product.id] = next;
    }
    notifyListeners();
  }
}

import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class CatalogRepository {
  Future<List<Product>> load() async {
    final text = await rootBundle.loadString('assets/data/products.json');
    return (jsonDecode(text) as List)
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}

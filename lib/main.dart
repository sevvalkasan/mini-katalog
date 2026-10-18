import 'package:flutter/material.dart';
import 'models/product.dart';
import 'state/cart.dart';
import 'screens/home_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/cart_screen.dart';

void main() => runApp(const CatalogApp());

class CatalogApp extends StatefulWidget {
  const CatalogApp({super.key});
  @override
  State<CatalogApp> createState() => _CatalogAppState();
}

class _CatalogAppState extends State<CatalogApp> {
  final cart = Cart();
  @override
  void dispose() {
    cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Mini Katalog',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFAF9F6),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF284D3F),
        primary: const Color(0xFF284D3F),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFAF9F6),
        surfaceTintColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE2E5DE)),
        ),
      ),
    ),
    home: HomeScreen(cart: cart),
    onGenerateRoute: (settings) {
      if (settings.name == '/product' && settings.arguments is Product) {
        return MaterialPageRoute(
          settings: settings,
          builder: (_) =>
              DetailScreen(product: settings.arguments as Product, cart: cart),
        );
      }
      if (settings.name == '/cart')
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CartScreen(cart: cart),
        );
      return null;
    },
  );
}

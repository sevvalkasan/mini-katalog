import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/cart.dart';
import '../widgets/cart_button.dart';

class DetailScreen extends StatelessWidget {
  final Product product;
  final Cart cart;
  const DetailScreen({super.key, required this.product, required this.cart});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Ürün detayı'),
      actions: [CartButton(cart: cart)],
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Hero(
                tag: 'product-${product.id}',
                child: Image.asset(
                  product.image,
                  height: 320,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              product.category.toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 2,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                letterSpacing: -.8,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color(0xFFBA873C),
                  size: 20,
                ),
                Text(
                  ' ${product.rating.toStringAsFixed(1)}  •  Katalog seçkisi',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              money(product.price),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 24),
            const Text(
              'Küçük detaylar, iyi hisler.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Text(
              product.description,
              style: const TextStyle(
                height: 1.8,
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.info_outline),
              title: Text('Keşfetmek için tasarlandı'),
              subtitle: Text(
                'Bu bir eğitim uygulamasıdır. Sepet ve ürünler demo amaçlıdır.',
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton.icon(
          style: FilledButton.styleFrom(padding: const EdgeInsets.all(18)),
          onPressed: () {
            cart.add(product);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Ürün sepete eklendi')),
            );
          },
          icon: const Icon(Icons.add_shopping_cart),
          label: const Text('Sepete ekle'),
        ),
      ),
    ),
  );
}

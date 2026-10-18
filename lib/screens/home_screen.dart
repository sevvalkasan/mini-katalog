import 'package:flutter/material.dart';
import '../state/cart.dart';
import '../widgets/cart_button.dart';
import 'catalog_screen.dart';

class HomeScreen extends StatelessWidget {
  final Cart cart;
  const HomeScreen({super.key, required this.cart});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text(
        'mini katalog',
        style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -1),
      ),
      actions: [CartButton(cart: cart)],
    ),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.asset(
                'assets/images/kupa.png',
                height: 240,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'GÜNLÜK HAYATA KÜÇÜK DOKUNUŞLAR',
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 2,
                color: Color(0xFF284D3F),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'İyi tasarım,\ngüzel bir başlangıç.',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                height: 1.1,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Yaşam, teknoloji, aksesuar ve kırtasiye. Günlük hayatına eşlik edecek 8 özenli parçayı keşfet.',
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              style: FilledButton.styleFrom(padding: const EdgeInsets.all(18)),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CatalogScreen(cart: cart)),
              ),
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Kataloğu keşfet'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Çevrimdışı keşif • 4 kategori • Özenli seçki',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Mini Katalog',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Flutter ile geliştirilen eğitim uygulaması. Ürünler ve sepet demo amaçlıdır.',
              style: TextStyle(color: Colors.black54, height: 1.6),
            ),
          ],
        ),
      ),
    ),
  );
}

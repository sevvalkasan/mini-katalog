import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/cart.dart';

class CartScreen extends StatelessWidget {
  final Cart cart;
  const CartScreen({super.key, required this.cart});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Sepetim')),
    body: ListenableBuilder(
      listenable: cart,
      builder: (context, _) {
        if (cart.count == 0)
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.shopping_bag_outlined,
                  size: 68,
                  color: Color(0xFF284D3F),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Güzel keşifler seni bekliyor.',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                const Text('Sepetin henüz boş.'),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Koleksiyona dön'),
                ),
              ],
            ),
          );
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: cart.products.length,
                    itemBuilder: (context, i) {
                      final p = cart.products[i];
                      return Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  p.image,
                                  width: 74,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(money(p.price)),
                                    Row(
                                      children: [
                                        IconButton(
                                          tooltip: '${p.name} azalt',
                                          onPressed: () => cart.remove(p),
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                        ),
                                        Text('${cart.quantity(p)}'),
                                        IconButton(
                                          tooltip: '${p.name} artır',
                                          onPressed: () => cart.add(p),
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Toplam (${cart.count} ürün)'),
                            Text(
                              money(cart.total),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Icon(Icons.school_outlined, size: 18),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Sepet simülasyonu • Ödeme işlemi yapılmaz.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

import 'package:flutter/material.dart';
import '../state/cart.dart';

class CartButton extends StatelessWidget {
  final Cart cart;
  const CartButton({super.key, required this.cart});
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: cart,
    builder: (context, _) => Padding(
      padding: const EdgeInsets.only(right: 16),
      child: IconButton(
        tooltip: 'Sepetim',
        onPressed: () => Navigator.pushNamed(context, '/cart'),
        icon: Badge(
          label: Text('${cart.count}'),
          isLabelVisible: cart.count > 0,
          child: const Icon(Icons.shopping_bag_outlined),
        ),
      ),
    ),
  );
}

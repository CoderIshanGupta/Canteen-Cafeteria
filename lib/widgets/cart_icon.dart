import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final itemCount = cart.items.length;

    return IconButton(
      icon: Stack(
        children: [
          const Icon(Icons.shopping_cart),
          if (itemCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.red,
                child: Text(
                  itemCount.toString(),
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/cart');
      },
    );
  }
}

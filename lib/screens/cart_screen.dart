import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../providers/cart_provider.dart';
import '../providers/orders_provider.dart';
import '../models/order.dart';

class CartScreen extends StatelessWidget {
  void _handlePaymentAndPlaceOrder(BuildContext context) async {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final orders = Provider.of<OrdersProvider>(context, listen: false);

    final totalAmount = cart.totalAmount;

    // TODO: Integrate payment gateway here.
    // Simulating payment success for now
    final paymentSuccess = true; // Set this based on actual payment response

    if (paymentSuccess) {
      final order = Order(
        id: Uuid().v4(),
        items: cart.items.values
            .map((e) => OrderItem(
                  item: e.item,
                  quantity: e.quantity,
                ))
            .toList(),
        total: totalAmount,
        timestamp: DateTime.now(),
        status: 'Preparing',
      );

      await orders.addOrder(order);
      cart.clearCart();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment successful! Order placed.')),
      );

      Navigator.pushReplacementNamed(context, '/orders');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment failed. Try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) {
                      final cartItem = cart.items.values.toList()[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              cartItem.item.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.fastfood),
                            ),
                          ),
                          title: Text(cartItem.item.name),
                          subtitle: Text(
                            '₹${cartItem.item.price} x ${cartItem.quantity} = ₹${(cartItem.item.price * cartItem.quantity).toStringAsFixed(2)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  if (cartItem.quantity > 1) {
                                    cart.changeQuantity(
                                      cartItem.item.id,
                                      cartItem.quantity - 1,
                                    );
                                  } else {
                                    cart.removeItem(cartItem.item.id);
                                  }
                                },
                              ),
                              Text('${cartItem.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () => cart.changeQuantity(
                                  cartItem.item.id,
                                  cartItem.quantity + 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('₹${cart.totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.payment),
                        label: const Text('Pay & Order'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(45),
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () => _handlePaymentAndPlaceOrder(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

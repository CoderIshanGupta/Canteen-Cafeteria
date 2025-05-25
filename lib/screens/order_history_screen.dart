import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrdersProvider>(context).orders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: orders.isEmpty
          ? const Center(child: Text('No orders found.'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (ctx, index) {
                final order = orders[index];
                return ListTile(
                  title: Text('Order #${order.id.substring(0, 6)}'),
                  subtitle: Text('Total: ₹${order.total.toStringAsFixed(2)}'),
                  trailing: Text(order.status),
                  onTap: () {
                    // Navigate to order details screen if needed
                  },
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async'; // Import for Timer

import '../providers/orders_provider.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrdersProvider>(context, listen: false).loadOrders();

    // Set a timer to update order status after 2 minutes
    Timer(Duration(minutes: 2), () {
      _updateOrderStatus();
    });
  }

  void _updateOrderStatus() {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    final orders = ordersProvider.orders;

    for (var order in orders) {
      if (order.status == 'Preparing') {
        ordersProvider.updateOrderStatus(order.id, 'Ready');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final orders = ordersProvider.orders;

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: orders.isEmpty
          ? const Center(child: Text('No orders yet!'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (ctx, i) {
                final order = orders[i];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order #${order.id.substring(0, 6)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ...order.items.map((e) => Text(
                              '${e.quantity} x ${e.item.name}',
                              style: const TextStyle(fontSize: 14),
                            )),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹${order.total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Chip(
                              label: Text(
                                order.status,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: order.status == 'Preparing'
                                  ? Colors.orange
                                  : Colors.green,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

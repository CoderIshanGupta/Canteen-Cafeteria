import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/order.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final ordersData = prefs.getString('orders');
    if (ordersData != null) {
      final List<dynamic> decoded = json.decode(ordersData);
      _orders = decoded.map((e) => Order.fromMap(e)).toList();
      notifyListeners();
    }
  }

  Future<void> addOrder(Order order) async {
    _orders.insert(0, order);
    notifyListeners();
    await saveOrders();
  }

  Future<void> saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(_orders.map((e) => e.toMap()).toList());
    await prefs.setString('orders', encoded);
  }

  void updateOrderStatus(String orderId, String newStatus) {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _orders[index].status = newStatus;
      saveOrders();
      notifyListeners();
    }
  }
}

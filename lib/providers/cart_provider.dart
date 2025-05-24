import 'package:flutter/material.dart';
import '../models/food_item.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((_, cartItem) {
      total += cartItem.item.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(FoodItem foodItem) {
    if (_items.containsKey(foodItem.id)) {
      _items.update(
        foodItem.id,
        (existingItem) => CartItem(
          item: existingItem.item,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        foodItem.id,
        () => CartItem(item: foodItem, quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void changeQuantity(String id, int newQuantity) {
    if (!_items.containsKey(id)) return;
    if (newQuantity <= 0) {
      removeItem(id);
    } else {
      _items.update(
        id,
        (existingItem) => CartItem(
          item: existingItem.item,
          quantity: newQuantity,
        ),
      );
    }
    notifyListeners();
  }
}

class CartItem {
  final FoodItem item;
  final int quantity;

  CartItem({required this.item, required this.quantity});
}

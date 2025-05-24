import 'food_item.dart';

class Order {
  final String id;
  final List<OrderItem> items;
  final double total;
  final DateTime timestamp;
  String status; // e.g. Preparing, Ready for Pickup

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.timestamp,
    this.status = 'Preparing',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items.map((e) => e.toMap()).toList(),
      'total': total,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
    };
  }

  static Order fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      items: List<Map<String, dynamic>>.from(map['items'])
          .map((e) => OrderItem.fromMap(e))
          .toList(),
      total: map['total'],
      timestamp: DateTime.parse(map['timestamp']),
      status: map['status'],
    );
  }
}

class OrderItem {
  final FoodItem item;
  final int quantity;

  OrderItem({required this.item, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'item': {
        'id': item.id,
        'name': item.name,
        'description': item.description,
        'category': item.category,
        'imageUrl': item.imageUrl,
        'price': item.price,
        'isVeg': item.isVeg,
      },
      'quantity': quantity,
    };
  }

  static OrderItem fromMap(Map<String, dynamic> map) {
    return OrderItem(
      item: FoodItem(
        id: map['item']['id'],
        name: map['item']['name'],
        description: map['item']['description'],
        category: map['item']['category'],
        imageUrl: map['item']['imageUrl'],
        price: map['item']['price'],
        isVeg: map['item']['isVeg'],
      ),
      quantity: map['quantity'],
    );
  }
}
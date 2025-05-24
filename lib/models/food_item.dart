class FoodItem {
  final String id;
  final String name;
  final String description;
  final String category; // e.g. Snacks, Main Course
  final String imageUrl;
  final double price;
  final bool isVeg;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isVeg,
  });
}

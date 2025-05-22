import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../utils/dummy_data.dart';
import '../widgets/food_card.dart';
import '../widgets/cart_icon.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Snacks';
  String searchQuery = '';

  final List<String> categories = ['Snacks', 'Main Course', 'Beverages'];

  @override
  Widget build(BuildContext context) {
    final filteredItems = dummyMenu.where((item) {
      return item.category == selectedCategory &&
          item.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 900 ? 4 : screenWidth > 600 ? 3 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('College Cafeteria'),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            onPressed: () => Navigator.pushNamed(context, '/orders'),
          ),
          CartIcon(), // ✅ Remove 'const'
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search food...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      searchQuery = val;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((cat) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: selectedCategory == cat,
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = cat;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      body: filteredItems.isEmpty
          ? const Center(child: Text('No items found.'))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                itemCount: filteredItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 0.90,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (ctx, index) {
                  final foodItem = filteredItems[index];
                  return FoodCard(
                    foodName: foodItem.name,
                    foodImage: Image.asset(foodItem.imageUrl),
                    price: foodItem.price.toStringAsFixed(2),
                    currency: '₹ ',
                    backgroundColor: const Color.fromARGB(255, 223, 134, 33),
                    titleColor: Colors.white,
                    priceColor: const Color.fromARGB(255, 63, 253, 69),
                    currencyColor: const Color.fromARGB(255, 252, 34, 18),
                    btnAddColor: Colors.black,
                    fontFamily: 'Arial',
                    listen: () {},
                    onAddToCart: (name) {
                      Provider.of<CartProvider>(context, listen: false).addItem(foodItem);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Item added to cart')),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}

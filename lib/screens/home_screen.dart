import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../providers/cart_provider.dart';
import '../utils/dummy_data.dart';
import '../widgets/food_card.dart';
import '../widgets/cart_icon.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';
  final List<String> categories = ['All', 'Snacks', 'Main Course', 'Beverages'];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final filteredItems = dummyMenu.where((item) {
      final inCategory = selectedCategory == 'All' || item.category == selectedCategory;
      final matchesSearch = item.name.toLowerCase().contains(searchQuery.toLowerCase());
      return inCategory && matchesSearch;
    }).toList();

    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 900 ? 4 : screenWidth > 600 ? 3 : 2;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        title: const Text('College Cafeteria'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            onPressed: () => Navigator.pushNamed(context, '/orders'),
          ),
          CartIcon(),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search food...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  onChanged: (val) {
                    setState(() {
                      searchQuery = val;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemCount: categories.length,
                  itemBuilder: (ctx, index) {
                    final cat = categories[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: selectedCategory == cat,
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = cat;
                          });
                        },
                        selectedColor: Colors.orangeAccent,
                        backgroundColor: Colors.grey[300],
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user.name),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/profile.png'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Profile'),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Order History'),
              onTap: () => Navigator.pushNamed(context, '/order-history'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return filteredItems.isEmpty
                ? const Center(child: Text('No items found.'))
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: GridView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredItems.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 0.95,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
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
                  );
          },
        ),
      ),
    );
  }
}

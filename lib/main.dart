import 'package:canteen_cafeteria/providers/orders_provider.dart';
import 'package:canteen_cafeteria/screens/cart_screen.dart';
import 'package:canteen_cafeteria/screens/order_history_screen.dart';
import 'package:canteen_cafeteria/screens/orders_screen.dart';
import 'package:canteen_cafeteria/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/auth_screen.dart';
import 'providers/user_provider.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Cafeteria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/auth',
      routes: {
        '/auth': (_) => AuthScreen(),
        '/home': (_) => HomeScreen(),
        '/profile': (_) => ProfileScreen(),
        '/orders': (_) => OrdersScreen(),
        '/cart': (_) => CartScreen(),
        '/payment': (_) => PaymentScreen(),
        '/order-history': (_) => OrderHistoryScreen(),
      },
    );
  }
}

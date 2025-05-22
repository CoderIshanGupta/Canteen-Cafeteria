import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/orders_screen.dart';
import 'providers/cart_provider.dart';
import 'providers/orders_provider.dart';

void main() {
  runApp(CafeteriaApp());
}

class CafeteriaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child: MaterialApp(
        title: 'College Cafeteria',
        theme: ThemeData(primarySwatch: Colors.orange),
        initialRoute: '/',
        routes: {
          '/': (ctx) => HomeScreen(),
          '/cart': (ctx) => CartScreen(),
          '/orders': (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String foodName;
  final Image foodImage;
  final String price;
  final String currency;
  final Color backgroundColor;
  final Color titleColor;
  final Color priceColor;
  final Color currencyColor;
  final Color btnAddColor;
  final String fontFamily;
  final Function listen;
  final Function onAddToCart;

  const FoodCard({
    Key? key,
    required this.foodName,
    required this.foodImage,
    required this.price,
    required this.currency,
    required this.backgroundColor,
    required this.titleColor,
    required this.priceColor,
    required this.currencyColor,
    required this.btnAddColor,
    required this.fontFamily,
    required this.listen,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Container(
              width: double.infinity,
              height: 200,
              child: FittedBox(
                fit: BoxFit.cover, // Use cover for better image filling
                child: foodImage,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              foodName,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  currency,
                  style: TextStyle(
                    color: currencyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  price,
                  style: TextStyle(
                    color: priceColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: btnAddColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => onAddToCart(foodName), // Pass the whole FoodItem here
              child: Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

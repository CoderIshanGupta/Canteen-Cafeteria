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
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: SizedBox(
                  width: double.infinity,
                  height: constraints.maxHeight * 0.60, // 45% of card height
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: foodImage,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  foodName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 16,
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
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: btnAddColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () => onAddToCart(foodName),
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

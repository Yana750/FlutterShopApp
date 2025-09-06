import 'package:check/services/analytics_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/favorite_provider.dart';
import '../models/product_model.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final List<Product> products = [
    Product(id: '1', name: 'Худи', price: 5999, imageUrl: 'assets/photo1.jpeg'),
    Product(id: '2', name: 'Футболка', price: 999, imageUrl: 'assets/photo2.jpg'),
    Product(id: '3', name: 'Юбка', price: 1999, imageUrl: 'assets/photo3.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Стартовая страница"), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Builder(
            builder: (context) {
              final favoritesProvider = Provider.of<FavoriteProvider>(context);
              final isFavorite = favoritesProvider.isFavorite(product);

              return Card(
                margin: EdgeInsets.only(bottom: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Image.asset(
                        product.imageUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (product.price != null)
                              Text(
                                '${product.price!.toStringAsFixed(0)} ₽',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    AnalyticsService.trackAddToFavorites(context, product);
                                  },
                                  child: Text(
                                    isFavorite ? "В избранном" : "В избранное",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    AnalyticsService.trackPurchase(product);
                                  },
                                  child: Text(
                                    "Купить",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

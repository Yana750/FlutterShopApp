import 'package:check/Provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoriteProvider>(context);
    final favorites = favoritesProvider.favorites;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Избранное"), centerTitle: true),
      body: favorites.isEmpty
          ? Center(child: Text("Нет избранный товаров"))
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      product.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: product.price != null
                        ? Text('${product.price!.toStringAsFixed(0)} ₽')
                        : null,
                    trailing: IconButton(
                      onPressed: () {
                        favoritesProvider.removeFromFavorites(product);
                      },
                      icon: Icon(Icons.delete_outlined),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

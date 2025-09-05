import 'package:check/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:mytracker_sdk/mytracker_sdk.dart';
import 'package:provider/provider.dart';

import '../Provider/favorite_provider.dart';


void trackAddToFavorites(BuildContext context, Product product) {
  // добавление в избранное через Provider без listen
  final favoritesProvider = Provider.of<FavoriteProvider>(context, listen: false);
  favoritesProvider.addToFavorites(product);

  // отправка события в MyTracker
  MyTracker.trackEvent("add_to_favorites", {
    "product_id": product.id,
    "name": product.name,
    "price": product.price.toString(),
  });

  print("Event 'add_to_favorites' отправлен для ${product.name}");
}

void trackPurchase(Product product) {
  //имитация покупки
  MyTracker.trackEvent("purchase", {
    "product_id": product.id,
    "name": product.name,
    "price": ?product.price?.toString(),
    "currency": "RUB"
  });
  print("Revenue event отправлен для ${product.name} на сумму ${product.price}");
}
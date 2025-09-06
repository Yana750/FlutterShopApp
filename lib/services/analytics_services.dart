import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:check/Provider/favorite_provider.dart';
import 'package:check/models/product_model.dart';
import 'package:flutter/widgets.dart';
import 'package:mytracker_sdk/mytracker_sdk.dart';
import 'package:provider/provider.dart';

class AnalyticsService {
  //приватный конструктов, чтобы нельзя было создавать экземпляры
  AnalyticsService._();

  ///Отправка события "Добавление в избранное"
  static void trackAddToFavorites(BuildContext context, Product product) {
    final favoritesProvider = Provider.of<FavoriteProvider>(context, listen: false);
    favoritesProvider.addToFavorites(product);

    final eventName = "add_to_favorites";
    final params = <String, Object>{
      "product_id": product.id,
      "name": product.name,
      "price": product.price.toString()
    };
    _sendEvent(eventName, params);
    print("Event '$eventName' отправлен для ${product.name}");
  }
  ///Покупка
  static void trackPurchase(Product product) {
    final eventName = "purchase";
    final params = <String, Object>{
      "product_id": product.id,
      "name": product.name,
      "price": product.price.toString(),
      "currency": "RUB"
    };
    _sendEvent(eventName, params);
    print("Revenue event отправлен для ${product.name} на сумму ${product.price}");
  }
  ///Базовый метод отправки события в MyTracker и AppMetrica
  static void trackEvent(String eventName, Map<String, Object?> params) {
    _sendEvent(eventName, params);
    print("Custom event '$eventName' отправлен");
  }

  static void _sendEvent(String eventName, Map<String, Object?> params) {
    try {
      //MyTracker
      MyTracker.trackEvent(eventName, params.cast<String, String>());
    } catch (e) {
      print("Ошибка отправки в MyTracker: $e");
    }
    try {
      AppMetrica.reportEventWithJson(eventName, params as String?);
    } catch (e) {
      print("Ошибка отправки в AppMetrica: $e");
    }
  }
}
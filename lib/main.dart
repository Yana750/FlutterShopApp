import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:check/Provider/favorite_provider.dart';
import 'package:check/screen/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:mytracker_sdk/mytracker_sdk.dart';

void main() async {
  //неатрибутивная установка (install)
  //отслеживает установку приложения при первом запуске
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");

  final sdkKey = dotenv.env['MY_TRACKER_SDK'];
  final metricaKey = dotenv.env['APPMETRICA_KEY'];

  //Инициализация MyTracker
  try {
    await MyTracker.init(sdkKey!);

    print("MyTracker подключен");
  } catch (e) {
    print("Ошибка инициализации");
  }

  //Инициализация AppMetrica
  try {
    await AppMetrica.activate(AppMetricaConfig(metricaKey!)
      ..logs
    );
    print("AppMetrica подключена");
  } catch (e) {
    print("Ошибка инициализации");
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoriteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const BottomNavBer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

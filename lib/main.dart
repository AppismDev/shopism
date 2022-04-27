import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopism/Controllers/favorites_controller.dart';
import 'package:shopism/Core/Constants/Enums/preferences_keys.dart';
import 'package:shopism/Core/Init/Cache/favorites_cache_manager.dart';
import 'package:shopism/Core/Init/Cache/i_cache_manager.dart';
import 'package:shopism/Core/Init/Cache/user_cache_manager.dart';
import 'package:shopism/Core/Init/Theme/app_theme_light.dart';
import 'package:shopism/Views/Splash/splash_screen.dart';

import 'Controllers/product_details_controller.dart';
import 'Controllers/user_controller.dart';
import 'Core/Constants/Enums/getx_keys.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  // runApp(MyApp());
  runApp(
    DevicePreview(
      enabled: false,
      builder: (BuildContext context) => MyApp(),
    ),
  );
}

Future<void> initializeApp() async {
  await Hive.initFlutter();
  UserCacheManager _cacheManager = UserCacheManager.instance;
  FavoritesCacheManager _favoritesCacheManager = FavoritesCacheManager.instance;
  await _favoritesCacheManager.init();
  await _cacheManager.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppThemeLight.instance.themeData,
      title: 'Shopism',
      home: SplashScreen(),
    );
  }
}

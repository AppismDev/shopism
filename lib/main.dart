import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopism/Core/Constants/Enums/preferences_keys.dart';
import 'package:shopism/Core/Init/Theme/app_theme_light.dart';
import 'package:shopism/Views/Splash/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeApp();
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
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}

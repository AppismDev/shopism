import 'package:flutter/material.dart';
import 'package:shopism/Core/Init/Theme/app_theme_light.dart';

import 'Views/Tab/View/tab_page_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeLight.instance.themeData,
      title: 'Shopism',
      home: Scaffold(
        body: TabPageView(),
      ),
    );
  }
}

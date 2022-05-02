import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopism/Core/Init/Theme/i_app_theme.dart';

class AppThemeLight implements IAppTheme {
  static final AppThemeLight _instance = AppThemeLight._init();

  static AppThemeLight get instance => _instance;

  AppThemeLight._init();

  @override
  ThemeData themeData = ThemeData.light().copyWith(
      primaryColor: Color(0xffE58228),
      navigationBarTheme: NavigationBarThemeData().copyWith(

        indicatorColor: Colors.white.withOpacity(0.3),
        backgroundColor: Colors.teal,
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        // iconTheme: MaterialStateProperty.all<IconThemeData>(IconThemeData(color: Colors.white))
      ),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData().copyWith(selectedItemColor: Color(0xffE58228), selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold)),
      tabBarTheme: TabBarTheme().copyWith(
        unselectedLabelColor: Colors.grey,
        labelColor: Color(0xffE58228),
      ),
      indicatorColor: Color(0xffE58228),
      appBarTheme: AppBarTheme().copyWith(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData().copyWith(color: Colors.grey.shade600))
      // textTheme: GoogleFonts.robotoTextTheme(),
      );
}

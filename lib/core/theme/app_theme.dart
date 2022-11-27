
import 'package:ecom_app/core/theme/theme_const.dart';
import 'package:flutter/material.dart';

mixin AppThemeMixin {

  final lightTheme = ThemeData(
    primarySwatch: Colors.pink,
    brightness: Brightness.light,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.pinkAccent,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),    
    textTheme: ThemeData.light().textTheme.copyWith(
      button: const TextStyle(
        fontSize: 24,
        color: Colors.black,
      ),
    ),
  );

  final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: Colors.amber,
    ),
    brightness: Brightness.dark,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black38,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  ThemeMode currentTheme(String? theme) {
    switch (theme) {
      case null:
        return ThemeMode.light;
      case kLight:
        return ThemeMode.light;
      case kDark:
        return ThemeMode.dark;
      default:
       return ThemeMode.system;
    }
  }
}
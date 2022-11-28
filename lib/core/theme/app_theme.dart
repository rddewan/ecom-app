
import 'package:ecom_app/core/theme/theme_const.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
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

  FlexSubThemesData flexSubThemesDataLight = const FlexSubThemesData(
    blendOnLevel: 10,
    blendOnColors: false,
    bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
    bottomNavigationBarUnselectedLabelSchemeColor: SchemeColor.tertiary,
    bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
    bottomNavigationBarUnselectedIconSchemeColor: SchemeColor.tertiary,
    bottomNavigationBarBackgroundSchemeColor: SchemeColor.primaryContainer,
    bottomNavigationBarElevation: 4.5,
    navigationBarSelectedLabelSchemeColor: SchemeColor.onSecondary,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.surface,
    navigationBarSelectedIconSchemeColor: SchemeColor.onSecondary,
    navigationBarUnselectedIconSchemeColor: SchemeColor.surface,
    navigationBarIndicatorOpacity: 0.25,
    navigationBarBackgroundSchemeColor: SchemeColor.secondary,
  );

  FlexSubThemesData flexSubThemesDataDark = const FlexSubThemesData(
    blendOnLevel: 20,
    bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
    bottomNavigationBarUnselectedLabelSchemeColor: SchemeColor.tertiary,
    bottomNavigationBarSelectedIconSchemeColor: SchemeColor.primary,
    bottomNavigationBarUnselectedIconSchemeColor: SchemeColor.tertiary,
    bottomNavigationBarBackgroundSchemeColor: SchemeColor.primaryContainer,
    bottomNavigationBarElevation: 4.5,
    navigationBarSelectedLabelSchemeColor: SchemeColor.onSecondary,
    navigationBarUnselectedLabelSchemeColor: SchemeColor.surface,
    navigationBarSelectedIconSchemeColor: SchemeColor.onSecondary,
    navigationBarUnselectedIconSchemeColor: SchemeColor.surface,
    navigationBarIndicatorOpacity: 0.25,
    navigationBarBackgroundSchemeColor: SchemeColor.secondary,
  );


  FlexSchemeData customFlexScheme = const FlexSchemeData(
    name: 'Midnight blue',
    description: 'Midnight blue theme, custom definition of all colors',
    light: FlexSchemeColor(
      primary: Color(0xFF00296B),
      primaryContainer: Color(0xFFA0C2ED),
      secondary: Color(0xFFD26900),
      secondaryContainer: Color(0xFFFFD270),
      tertiary: Color(0xFF5C5C95),
      tertiaryContainer: Color(0xFFC8DBF8),
    ),
    dark: FlexSchemeColor(
      primary: Color(0xFFB1CFF5),
      primaryContainer: Color(0xFF3873BA),
      secondary: Color(0xFFFFD270),
      secondaryContainer: Color(0xFFD26900),
      tertiary: Color(0xFFC9CBFC),
      tertiaryContainer: Color(0xFF535393),
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
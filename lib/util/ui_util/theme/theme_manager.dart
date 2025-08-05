import 'package:flutter/material.dart';
import '../color/color_manager.dart';

class ThemeManager {
  static ThemeManager sharedInstance = ThemeManager();

  ThemeData theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.blue),
    primaryColor: ColorManager.blue,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder()
    }),
    tabBarTheme: TabBarTheme(
      dividerColor: Colors.transparent,
    ),
    splashFactory: NoSplash.splashFactory
  );

  ThemeData darkTheme = ThemeData.dark().copyWith(
    tabBarTheme: ThemeData.dark().tabBarTheme.copyWith(
      dividerColor: Colors.transparent,
    ),
    splashFactory: NoSplash.splashFactory
  );

}
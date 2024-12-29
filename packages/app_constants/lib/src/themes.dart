import 'package:flutter/material.dart';

import 'colors.dart';
import 'typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorSchemeSeed: AppColors.primary,
      scaffoldBackgroundColor: AppColors.windowLightBackground,
      splashFactory: NoSplash.splashFactory,
      textTheme: _textTheme(),
      pageTransitionsTheme: _pageTransitionsTheme(),
      appBarTheme: const AppBarTheme(
        color: AppColors.windowLightBackground,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorSchemeSeed: AppColors.primary,
      scaffoldBackgroundColor: AppColors.windowDarkBackground,
      splashFactory: NoSplash.splashFactory,
      textTheme: _textTheme(),
      pageTransitionsTheme: _pageTransitionsTheme(),
      appBarTheme: const AppBarTheme(
        color: AppColors.windowDarkBackground,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    );
  }

  static TextTheme? _textTheme() {
    return TextTheme(
      displayLarge: AppTypography.title1,
      displayMedium: AppTypography.title2,
      displaySmall: AppTypography.title3,
      headlineLarge: AppTypography.title4,
      headlineMedium: AppTypography.heading,
      bodyLarge: AppTypography.body,
      bodyMedium: AppTypography.body,
      labelLarge: AppTypography.captionHeading,
      labelMedium: AppTypography.caption,
      labelSmall: AppTypography.caption.copyWith(fontSize: 12),
    ).apply(
      fontFamily: 'Inter',
    );
  }

  static PageTransitionsTheme _pageTransitionsTheme() {
    return const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      },
    );
  }
}

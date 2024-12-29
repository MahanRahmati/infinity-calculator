import 'package:flutter/cupertino.dart';
import 'package:screen_history/screen_history.dart';
import 'package:screen_home/screen_home.dart';
import 'package:screen_splash/screen_splash.dart';

import 'routes_name.dart';

/// Routes class defines the router for the application.
class Routes {
  Routes._();

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    RoutesName.splash: (final BuildContext context) => const SplashScreen(),
    RoutesName.home: (final BuildContext context) => const HomeScreen(),
    RoutesName.history: (final BuildContext context) => const HistoryScreen(),
  };

  static const String initialRoute = RoutesName.splash;

  static Route<dynamic>? onGenerateRoute(final RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return CupertinoPageRoute<dynamic>(
          builder: (final BuildContext context) => const SplashScreen(),
          settings: settings,
        );
      case RoutesName.home:
        return CupertinoPageRoute<dynamic>(
          builder: (final BuildContext context) => const HomeScreen(),
          settings: settings,
        );
      case RoutesName.history:
        return CupertinoPageRoute<dynamic>(
          builder: (final BuildContext context) => const HistoryScreen(),
          settings: settings,
        );
      default:
        return CupertinoPageRoute<dynamic>(
          builder: (final BuildContext context) => const SplashScreen(),
          settings: settings,
        );
    }
  }

  static void navigateToHome(
    final BuildContext context, {
    final Object? arguments,
  }) {
    Navigator.pushNamed(
      context,
      RoutesName.home,
      arguments: arguments,
    );
  }

  static void goToHome(
    final BuildContext context, {
    final Object? arguments,
  }) {
    Navigator.pushReplacementNamed(
      context,
      RoutesName.home,
      arguments: arguments,
    );
  }

  static void navigateToHistory(
    final BuildContext context, {
    final Object? arguments,
  }) {
    Navigator.pushNamed(
      context,
      RoutesName.history,
      arguments: arguments,
    );
  }

  static void goToHistory(
    final BuildContext context, {
    final Object? arguments,
  }) {
    Navigator.pushReplacementNamed(
      context,
      RoutesName.history,
      arguments: arguments,
    );
  }
}

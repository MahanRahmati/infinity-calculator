import 'package:flutter/services.dart';

/// Controls specific aspects of the operating system's graphical interface and
/// how it interacts with the application.
class SystemChromes {
  /// Specifies the style to use for the system overlays (e.g. the status bar
  /// on Android or iOS, the system navigation bar on Android) that are visible
  /// (if any).
  static void setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0x00000000),
        systemNavigationBarDividerColor: Color(0x00000000),
      ),
    );
  }

  /// Fullscreen display with status and navigation elements rendered over the
  /// application.
  static void setEnabledSystemUIMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  /// Sets the preferred device orientations for the app.
  static void setPreferredOrientations() {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

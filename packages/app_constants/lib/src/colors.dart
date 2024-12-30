import 'package:flutter/material.dart';

export 'package:flutter/material.dart' show Brightness, Theme;

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF3584E4);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);

  // Opacity constants
  static const double borderOpacity = 0.15;
  static const double dimOpacity = 0.55;
  static const double disabledOpacity = 0.5;

  // Color palettes
  static const List<Color> bluePalette = <Color>[
    Color(0xFF99C1F1), // blue1
    Color(0xFF62A0EA), // blue2
    Color(0xFF3584E4), // blue3
    Color(0xFF1C71D8), // blue4
    Color(0xFF1A5FB4), // blue5
  ];

  static const List<Color> greenPalette = <Color>[
    Color(0xFF8FF0A4), // green1
    Color(0xFF57E389), // green2
    Color(0xFF33D17A), // green3
    Color(0xFF2EC27E), // green4
    Color(0xFF26A269), // green5
  ];

  static const List<Color> yellowPalette = <Color>[
    Color(0xFFF9F06B), // yellow1
    Color(0xFFF8E45C), // yellow2
    Color(0xFFF6D32D), // yellow3
    Color(0xFFF5C211), // yellow4
    Color(0xFFE5A50A), // yellow5
  ];

  static const List<Color> orangePalette = <Color>[
    Color(0xFFFFBE6F), // orange1
    Color(0xFFFFA348), // orange2
    Color(0xFFFF7800), // orange3
    Color(0xFFE66100), // orange4
    Color(0xFFC64600), // orange5
  ];

  static const List<Color> redPalette = <Color>[
    Color(0xFFF66151), // red1
    Color(0xFFED333B), // red2
    Color(0xFFE01B24), // red3
    Color(0xFFC01C28), // red4
    Color(0xFFA51D2D), // red5
  ];

  static const List<Color> purplePalette = <Color>[
    Color(0xFFDC8ADD), // purple1
    Color(0xFFC061CB), // purple2
    Color(0xFF9141AC), // purple3
    Color(0xFF813D9C), // purple4
    Color(0xFF613583), // purple5
  ];

  static const List<Color> brownPalette = <Color>[
    Color(0xFFCDAB8F), // brown1
    Color(0xFFB5835A), // brown2
    Color(0xFF986A44), // brown3
    Color(0xFF865E3C), // brown4
    Color(0xFF63452C), // brown5
  ];

  static const List<Color> lightPalette = <Color>[
    white, // light1
    Color(0xFFF6F5F4), // light2
    Color(0xFFDEDDDA), // light3
    Color(0xFFC0BFBC), // light4
    Color(0xFF9A9996), // light5
  ];

  static const List<Color> darkPalette = <Color>[
    Color(0xFF77767B), // dark1
    Color(0xFF5E5C64), // dark2
    Color(0xFF3D3846), // dark3
    Color(0xFF241F31), // dark4
    Color(0xFF000000), // dark5
  ];

  // window colors
  static const Color windowLightBackground = Color(0xFFFAFAFA);
  static const Color windowDarkBackground = Color(0xFF242424);

  // Headerbar colors
  static const Color headerbarLightBackground = white;
  static const Color headerbarDarkBackground = Color(0xFF363636);

  // Sidebar colors
  //static const Color sidebarLightBackground = Color(0xFFEBEBEB);
  // static const Color sidebarLightBackground = Color(0xFFFAFAFA);
  static const Color sidebarLightBackground = Color(0xFFF5F5F5);
  static const Color sidebarDarkBackground = Color(0xFF2D2D2D);

  // Card colors
  static const Color cardLightBackground = white;
  static const Color cardDarkBackground = Color(0xFF363636);

  // Border colors
  static const Color borderLightBackground = Color(0xFFE9E9E9);
  static const Color borderDarkBackground = Color(0xFF171717);

  static const Color destructiveLight = Color(0xFFC30000);
  static const Color destructiveDark = Color(0xFFFF938C);

  static const Color successLight = Color(0xFF007c3d);
  static const Color successDark = Color(0xFF78e9ab);

  static const Color warningLight = Color(0xFF905400);
  static const Color warningDark = Color(0xFFffc252);

  static Color getHoverColor(final Color baseColor) {
    // For light colors, darken by 3%
    if (baseColor.computeLuminance() > 0.5) {
      return HSLColor.fromColor(baseColor)
          .withLightness(
            (HSLColor.fromColor(baseColor).lightness - 0.03).clamp(0.0, 1.0),
          )
          .toColor();
    }
    // For dark colors, lighten by 3%
    return HSLColor.fromColor(baseColor)
        .withLightness(
          (HSLColor.fromColor(baseColor).lightness + 0.03).clamp(0.0, 1.0),
        )
        .toColor();
  }

  static Color getPressedColor(final Color baseColor) {
    // For light colors, darken by 8%
    if (baseColor.computeLuminance() > 0.5) {
      return HSLColor.fromColor(baseColor)
          .withLightness(
            (HSLColor.fromColor(baseColor).lightness - 0.08).clamp(0.0, 1.0),
          )
          .toColor();
    }
    // For dark colors, lighten by 8%
    return HSLColor.fromColor(baseColor)
        .withLightness(
          (HSLColor.fromColor(baseColor).lightness + 0.08).clamp(0.0, 1.0),
        )
        .toColor();
  }

  static Color calculateLightElevation(final int level) {
    // windowLightBackground
    const int baseValue = 0xFA;
    const int step = 20;
    final int newValue = baseValue - (level * step);
    return Color(0xFF000000 | (newValue << 16) | (newValue << 8) | newValue);
  }

  static Color calculateDarkElevation(final int level) {
    // windowDarkBackground
    const int baseValue = 0x24;
    const int step = 20;
    final int newValue = baseValue + (level * step);
    return Color(0xFF000000 | (newValue << 16) | (newValue << 8) | newValue);
  }

  static Color getBackgroundColor(
    final BuildContext context,
    final BackgroundType type,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    switch (type) {
      case BackgroundType.window:
        return isDark ? windowDarkBackground : windowLightBackground;
      case BackgroundType.headerbar:
        return isDark ? headerbarDarkBackground : headerbarLightBackground;
      case BackgroundType.sidebar:
        return isDark ? sidebarDarkBackground : sidebarLightBackground;
      case BackgroundType.card:
        return isDark ? cardDarkBackground : cardLightBackground;
    }
  }

  static Color getForegroundColor(
    final BuildContext context, {
    final Brightness? brightness,
  }) {
    final bool isDark =
        (brightness ?? Theme.of(context).brightness) == Brightness.dark;
    return isDark ? white : getRgbColor(0, 0, 6, 0.8);
  }

  static Color getStatusColor(
    final BuildContext context,
    final StatusType type,
  ) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    switch (type) {
      case StatusType.success:
        return isDark ? successDark : successLight;
      case StatusType.warning:
        return isDark ? warningDark : warningLight;
      case StatusType.error:
        return isDark ? destructiveDark : destructiveLight;
    }
  }

  static Color getStatusForegroundColor(final StatusType type) {
    switch (type) {
      case StatusType.warning:
        return getRgbColor(0, 0, 0, 0.8);
      case StatusType.success:
      case StatusType.error:
        return white;
    }
  }

  static Color getButtonBackgroundColor(
    final BuildContext context, {
    final int? elavation,
    final Color? color,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    if (color != null) {
      return isDark
          ? color.withTransparency(0.36)
          : color.withTransparency(0.12);
    }
    if (elavation == null) {
      return isDark
          ? AppColors.getRgbColor(255, 255, 255, 0.12)
          : AppColors.getRgbColor(0, 0, 6, 0.12);
    }
    return isDark
        ? calculateDarkElevation(elavation)
        : calculateLightElevation(elavation);
  }

  static Color getBorderColor(
    final BuildContext context, {
    final Color? color,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    if (color != null) {
      return color.withTransparency(borderOpacity);
    }
    return isDark ? borderDarkBackground : borderLightBackground;
  }

  static Color getRgbColor(
    final int r,
    final int g,
    final int b,
    final double opacity,
  ) {
    final int alpha = (opacity * 255).round();
    return Color.fromARGB(alpha, r, g, b);
  }
}

enum BackgroundType {
  window,
  headerbar,
  sidebar,
  card,
}

enum StatusType {
  success,
  warning,
  error,
}

extension ColorExtensions on Color {
  Color disabled() {
    return withTransparency(AppColors.disabledOpacity);
  }

  Color dimmed() {
    return withTransparency(AppColors.dimOpacity);
  }

  Color withTransparency(final double opacity) {
    final int alpha = (opacity * 255).round();
    return withAlpha(alpha);
  }

  Brightness estimateBrightness() {
    final double relativeLuminance = computeLuminance();
    //const double kThreshold = 0.0525;
    const double kThreshold = 0.0777;
    if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold) {
      return Brightness.light;
    }
    return Brightness.dark;
  }
}

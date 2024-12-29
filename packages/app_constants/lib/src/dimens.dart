import 'package:flutter/widgets.dart';

class Dimens {
  Dimens._();

  static const double base = 8.0;
  static const double tinyPadding = base * 0.25;
  static const double smallPadding = base * 0.5;
  static const double padding = base;
  static const double smallBorderRadius = base;
  static const double mediumPadding = base * 1.5;
  static const double largePadding = base * 2;
  static const double borderRadius = base * 2;
  static const double hugePadding = base * 4;
  static const double headerbarHeight = base * 7;
  static const double dialogMinHeight = base * 10;
  static const double statusPageIconSize = base * 12;
  static const double appIconSize = base * 12;
  static const double popupWidth = base * 35;
  static const double dialogMinWidth = base * 35;
  static const double dialogMaxWidth = base * 60;

  static double sidebarWidth = iphone16ProMaxWidth;

  static const double iphone16ProMaxWidth = 440;
  static const double iphone16ProMaxLandscapeWidth = 956;
  static const double ipadPro13Width = 1032;
  static const double ipadPro13LandscapeWidth = 1376;
}

bool isExtended(final BuildContext context) {
  final double width = MediaQuery.of(context).size.width;
  return width >= Dimens.ipadPro13Width;
}

bool isFullExtended(final BuildContext context) {
  final double width = MediaQuery.of(context).size.width;
  return width >= Dimens.ipadPro13LandscapeWidth;
}

bool isWidthExtended(final double width) {
  return width >= Dimens.ipadPro13Width;
}

bool isWidthFullExtended(final double width) {
  return width >= Dimens.ipadPro13LandscapeWidth;
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static const int _baseSize = 18;

  static final TextStyle _default = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    color: Colors.black,
    decoration: TextDecoration.none,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle display1 = _default.copyWith(
    fontSize: _baseSize * 4,
    fontWeight: FontWeight.w800,
  );

  static TextStyle display2 = _default.copyWith(
    fontSize: _baseSize * 3,
    fontWeight: FontWeight.w800,
  );

  static TextStyle display3 = _default.copyWith(
    fontSize: _baseSize * 2,
    fontWeight: FontWeight.w800,
  );

  static TextStyle title1 = _default.copyWith(
    fontSize: _baseSize * 1.81,
    fontWeight: FontWeight.w800,
  );

  static TextStyle title2 = _default.copyWith(
    fontSize: _baseSize * 1.36,
    fontWeight: FontWeight.w800,
  );

  static TextStyle title3 = _default.copyWith(
    fontSize: _baseSize * 1.36,
    fontWeight: FontWeight.w700,
  );

  static TextStyle title4 = _default.copyWith(
    fontSize: _baseSize * 1.18,
    fontWeight: FontWeight.w700,
  );

  static TextStyle heading = _default.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: _baseSize * 1,
  );

  static TextStyle body = _default.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: _baseSize * 1,
  );

  static TextStyle captionHeading = _default.copyWith(
    fontSize: _baseSize * 0.82,
    fontWeight: FontWeight.w700,
  );

  static TextStyle caption = _default.copyWith(
    fontSize: _baseSize * 0.82,
    fontWeight: FontWeight.w400,
  );

  static TextStyle monospace = GoogleFonts.robotoMono(
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle numeric = _default.copyWith(
    fontFeatures: <FontFeature>[const FontFeature.tabularFigures()],
  );
}

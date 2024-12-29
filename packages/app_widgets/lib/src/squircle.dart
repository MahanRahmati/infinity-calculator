import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart' show InputBorder;
import 'package:flutter/widgets.dart';

enum CornerLocation { tl, tr, bl, br }

/// A rectangular border with variable smoothness transitions between
/// the straight sides and the rounded corners.
class SmoothRectangleBorder extends OutlinedBorder {
  const SmoothRectangleBorder({
    this.smoothness = 0.6,
    this.borderRadius = BorderRadius.zero,
    super.side,
  });

  /// The radius for each corner.
  ///
  /// Negative radius values are clamped to 0.0 by [getInnerPath] and
  /// [getOuterPath].
  ///
  /// If radiuses of X and Y from one corner are not equal, the smallest one
  /// will be used.
  final BorderRadiusGeometry borderRadius;

  /// The smoothness of corners.
  ///
  /// The concept comes from a feature called "corner smoothing" of Figma.
  ///
  /// 0.0 - 1.0
  final double smoothness;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(final Rect rect, {final TextDirection? textDirection}) {
    return getPath(
      borderRadius.resolve(textDirection).toRRect(rect).deflate(side.width),
    );
  }

  Path getPath(final RRect rrect) {
    final Path path = Path();
    if (smoothness == 0 || borderRadius == BorderRadius.zero) {
      path.addRRect(rrect);
    } else {
      final double width = rrect.width;
      final double height = rrect.height;
      final double top = rrect.top;
      final double left = rrect.left;
      final double bottom = rrect.bottom;
      final double right = rrect.right;

      final double centerX = width / 2 + left;

      final Corner tl = Corner(rrect, CornerLocation.tl, smoothness);
      final Corner tr = Corner(rrect, CornerLocation.tr, smoothness);
      final Corner br = Corner(rrect, CornerLocation.br, smoothness);
      final Corner bl = Corner(rrect, CornerLocation.bl, smoothness);

      path.moveTo(centerX, top);

      // top right
      path
        ..lineTo(left + max(width / 2, width - tr.p), top)
        ..cubicTo(
          right - (tr.p - tr.a),
          top,
          right - (tr.p - tr.a - tr.b),
          top,
          right - (tr.p - tr.a - tr.b - tr.c),
          top + tr.d,
        )
        ..arcTo(
          Rect.fromCircle(
            center: Offset(right - tr.radius, top + tr.radius),
            radius: tr.radius,
          ),
          (270 + tr.angleBezier).toRadian(),
          (90 - 2 * tr.angleBezier).toRadian(),
          false,
        )
        ..cubicTo(
          right,
          top + (tr.p - tr.a - tr.b),
          right,
          top + (tr.p - tr.a),
          right,
          top + min(height / 2, tr.p),
        );

      //bottom right
      path
        ..lineTo(
          right,
          top + max(height / 2, height - br.p),
        )
        ..cubicTo(
          right,
          bottom - (br.p - br.a),
          right,
          bottom - (br.p - br.a - br.b),
          right - br.d,
          bottom - (br.p - br.a - br.b - br.c),
        )
        ..arcTo(
          Rect.fromCircle(
            center: Offset(right - br.radius, bottom - br.radius),
            radius: br.radius,
          ),
          br.angleBezier.toRadian(),
          (90 - br.angleBezier * 2).toRadian(),
          false,
        )
        ..cubicTo(
          right - (br.p - br.a - br.b),
          bottom,
          right - (br.p - br.a),
          bottom,
          left + max(width / 2, width - br.p),
          bottom,
        );

      //bottom left
      path
        ..lineTo(left + min(width / 2, bl.p), bottom)
        ..cubicTo(
          left + (bl.p - bl.a),
          bottom,
          left + (bl.p - bl.a - bl.b),
          bottom,
          left + (bl.p - bl.a - bl.b - bl.c),
          bottom - bl.d,
        )
        ..arcTo(
          Rect.fromCircle(
            center: Offset(left + bl.radius, bottom - bl.radius),
            radius: bl.radius,
          ),
          (90 + bl.angleBezier).toRadian(),
          (90 - bl.angleBezier * 2).toRadian(),
          false,
        )
        ..cubicTo(
          left,
          bottom - (bl.p - bl.a - bl.b),
          left,
          bottom - (bl.p - bl.a),
          left,
          top + max(height / 2, height - bl.p),
        );

      //top left
      path
        ..lineTo(left, top + min(height / 2, tl.p))
        ..cubicTo(
          left,
          top + (tl.p - tl.a),
          left,
          top + (tl.p - tl.a - tl.b),
          left + tl.d,
          top + (tl.p - tl.a - tl.b - tl.c),
        )
        ..arcTo(
          Rect.fromCircle(
            center: Offset(left + tl.radius, top + tl.radius),
            radius: tl.radius,
          ),
          (180 + tl.angleBezier).toRadian(),
          (90 - tl.angleBezier * 2).toRadian(),
          false,
        )
        ..cubicTo(
          left + (tl.p - tl.a - tl.b),
          top,
          left + (tl.p - tl.a),
          top,
          left + min(width / 2, tl.p),
          top,
        );

      path.close();
    }
    return path;
  }

  @override
  Path getOuterPath(final Rect rect, {final TextDirection? textDirection}) {
    return getPath(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(
    final Canvas canvas,
    final Rect rect, {
    final TextDirection? textDirection,
  }) {
    if (rect.isEmpty) {
      return;
    }
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final Path path = getPath(
          borderRadius
              .resolve(textDirection)
              .toRRect(rect)
              .deflate(side.width / 2),
        );
        final Paint paint = side.toPaint()..isAntiAlias = true;
        canvas.drawPath(path, paint);
    }
  }

  @override
  ShapeBorder scale(final double t) {
    return SmoothRectangleBorder(
      borderRadius: borderRadius * t,
      side: side.scale(t),
    );
  }

  @override
  ShapeBorder? lerpFrom(final ShapeBorder? a, final double t) {
    if (a is SmoothRectangleBorder) {
      return SmoothRectangleBorder(
        side: BorderSide.lerp(a.side, side, t),
        borderRadius:
            BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t)!,
        smoothness: lerpDouble(a.smoothness, smoothness, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(final ShapeBorder? b, final double t) {
    if (b is SmoothRectangleBorder) {
      return SmoothRectangleBorder(
        side: BorderSide.lerp(side, b.side, t),
        borderRadius:
            BorderRadiusGeometry.lerp(borderRadius, b.borderRadius, t)!,
        smoothness: lerpDouble(smoothness, b.smoothness, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  SmoothRectangleBorder copyWith({
    final BorderSide? side,
    final BorderRadiusGeometry? borderRadius,
    final double? smoothness,
  }) {
    return SmoothRectangleBorder(
      borderRadius: borderRadius ?? this.borderRadius,
      side: side ?? this.side,
      smoothness: smoothness ?? this.smoothness,
    );
  }

  @override
  int get hashCode {
    return Object.hash(
      smoothness,
      borderRadius,
      side,
    );
  }

  @override
  bool operator ==(final Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SmoothRectangleBorder &&
        other.smoothness == smoothness &&
        other.borderRadius == borderRadius &&
        other.side == side;
  }
}

extension _Math on double {
  double toRadian() => this * pi / 180;
}

class Corner {
  Corner(final RRect rrect, final CornerLocation location, double smoothness) {
    if (smoothness > 1) {
      smoothness = 1;
    }
    shortestSide = rrect.shortestSide;

    radius = _getRadius(rrect, location);

    p = min(shortestSide / 2, (1 + smoothness) * radius);

    if (radius > shortestSide / 4) {
      final double changePercentage =
          (radius - shortestSide / 4) / (shortestSide / 4);
      angleCircle = 90 * (1 - smoothness * (1 - changePercentage));
      angleBezier = 45 * smoothness * (1 - changePercentage);
    } else {
      angleCircle = 90 * (1 - smoothness);
      angleBezier = 45 * smoothness;
    }

    final double dToC = tan(angleBezier.toRadian());
    final double longest = radius * tan(angleBezier.toRadian() / 2);
    final double l = sin(angleCircle.toRadian() / 2) * radius * pow(2, 0.5);
    c = longest * cos(angleBezier.toRadian());
    d = c * dToC;
    b = ((p - l) - (1 + dToC) * c) / 3;
    a = 2 * b;
  }

  late double angleBezier;
  late double angleCircle;
  late double a;
  late double b;
  late double c;
  late double d;
  late double p;
  late double radius;
  late double shortestSide;

  double _getRadius(final RRect rrect, final CornerLocation location) {
    double radiusX;
    double radiusY;
    switch (location) {
      case CornerLocation.tl:
        radiusX = rrect.tlRadiusX;
        radiusY = rrect.tlRadiusY;
      case CornerLocation.tr:
        radiusX = rrect.trRadiusX;
        radiusY = rrect.trRadiusY;
      case CornerLocation.bl:
        radiusX = rrect.blRadiusX;
        radiusY = rrect.blRadiusY;
      case CornerLocation.br:
        radiusX = rrect.brRadiusX;
        radiusY = rrect.brRadiusY;
    }
    final double radius = max(0.0, min(radiusX, radiusY));
    return min(radius, shortestSide / 2);
  }
}

class SmoothClipRRect extends StatelessWidget {
  const SmoothClipRRect({
    super.key,
    this.smoothness = 0.6,
    this.borderRadius = BorderRadius.zero,
    this.side = BorderSide.none,
    this.child,
  });

  /// The radius for each corner.
  ///
  /// Negative radius values are clamped to 0.0 by [getInnerPath] and
  /// [getOuterPath].
  ///
  /// If radiuses of X and Y from one corner are not equal, the smallest one
  /// will be used.
  final BorderRadius borderRadius;

  /// The smoothness of corners.
  ///
  /// The concept comes from a feature called "corner smoothing" of Figma.
  ///
  /// 0.0 - 1.0
  final double smoothness;

  /// The border outline's color and weight.
  ///
  /// If [side] is [BorderSide.none], which is the default, an outline is not
  /// drawn. Otherwise the outline is centered over the shape's boundary.
  final BorderSide side;

  final Widget? child;

  @override
  Widget build(final BuildContext context) {
    final SmoothRectangleBorder shaper = SmoothRectangleBorder(
      smoothness: smoothness,
      borderRadius: borderRadius - BorderRadius.circular(side.width),
    );
    return CustomPaint(
      foregroundPainter: _BorderPainter(side, borderRadius, shaper),
      child: Padding(
        padding: EdgeInsets.all(max(0.0, side.width - 1)),
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: shaper,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _BorderPainter extends CustomPainter {
  _BorderPainter(
    this.side,
    this.borderRadius,
    this.shaper,
  );

  final BorderSide side;
  final BorderRadius borderRadius;
  final SmoothRectangleBorder shaper;

  @override
  void paint(final Canvas canvas, final Size size) {
    if (side != BorderSide.none &&
        side.style == BorderStyle.solid &&
        side.width > 0) {
      final Path path = shaper.getPath(
        borderRadius.toRRect(Offset.zero & size).deflate(side.width / 2),
      );
      final Paint paint = side.toPaint()..isAntiAlias = true;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant final _BorderPainter old) {
    return old.side != side ||
        old.borderRadius != borderRadius ||
        old.shaper != shaper;
  }
}

class SmoothOutlineInputBorder extends InputBorder {
  const SmoothOutlineInputBorder({
    super.borderSide = const BorderSide(),
    this.smoothness = 0.6,
    this.borderRadius = BorderRadius.zero,
    this.gapPadding = 4.0,
  }) : assert(gapPadding >= 0.0);

  final double smoothness;
  final BorderRadius borderRadius;
  final double gapPadding;

  @override
  bool get isOutline => true;

  @override
  SmoothOutlineInputBorder copyWith({
    final BorderSide? borderSide,
    final BorderRadius? borderRadius,
    final double? smoothness,
    final double? gapPadding,
  }) {
    return SmoothOutlineInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
      gapPadding: gapPadding ?? this.gapPadding,
      smoothness: smoothness ?? this.smoothness,
    );
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  SmoothOutlineInputBorder scale(final double t) {
    return SmoothOutlineInputBorder(
      borderSide: borderSide.scale(t),
      borderRadius: borderRadius * t,
      gapPadding: gapPadding * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(final ShapeBorder? a, final double t) {
    if (a is SmoothOutlineInputBorder) {
      final SmoothOutlineInputBorder outline = a;
      return SmoothOutlineInputBorder(
        borderRadius: BorderRadius.lerp(outline.borderRadius, borderRadius, t)!,
        borderSide: BorderSide.lerp(outline.borderSide, borderSide, t),
        gapPadding: outline.gapPadding,
        smoothness: lerpDouble(outline.smoothness, smoothness, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(final ShapeBorder? b, final double t) {
    if (b is SmoothOutlineInputBorder) {
      final SmoothOutlineInputBorder outline = b;
      return SmoothOutlineInputBorder(
        borderRadius: BorderRadius.lerp(borderRadius, outline.borderRadius, t)!,
        borderSide: BorderSide.lerp(borderSide, outline.borderSide, t),
        gapPadding: outline.gapPadding,
        smoothness: lerpDouble(smoothness, outline.smoothness, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  Path getInnerPath(final Rect rect, {final TextDirection? textDirection}) {
    return getPath(
      borderRadius
          .resolve(textDirection)
          .toRRect(rect)
          .deflate(borderSide.width),
    );
  }

  Path getPath(final RRect rrect) {
    final Path path = Path();
    if (smoothness == 0 || borderRadius == BorderRadius.zero) {
      path.addRRect(rrect);
    } else {
      final double width = rrect.width;
      final double height = rrect.height;
      final double top = rrect.top;
      final double left = rrect.left;
      final double bottom = rrect.bottom;
      final double right = rrect.right;

      final double centerX = width / 2 + left;

      final Corner tl = Corner(rrect, CornerLocation.tl, smoothness);
      final Corner tr = Corner(rrect, CornerLocation.tr, smoothness);
      final Corner br = Corner(rrect, CornerLocation.br, smoothness);
      final Corner bl = Corner(rrect, CornerLocation.bl, smoothness);

      path.moveTo(centerX, top);

      // top right
      path
        ..lineTo(left + max(width / 2, width - tr.p), top)
        ..cubicTo(
          right - (tr.p - tr.a),
          top,
          right - (tr.p - tr.a - tr.b),
          top,
          right - (tr.p - tr.a - tr.b - tr.c),
          top + tr.d,
        )
        ..arcTo(
          Rect.fromCircle(
            center: Offset(right - tr.radius, top + tr.radius),
            radius: tr.radius,
          ),
          (270 + tr.angleBezier).toRadian(),
          (90 - 2 * tr.angleBezier).toRadian(),
          false,
        )
        ..cubicTo(
          right,
          top + (tr.p - tr.a - tr.b),
          right,
          top + (tr.p - tr.a),
          right,
          top + min(height / 2, tr.p),
        );

      //bottom right
      path
        ..lineTo(
          right,
          top + max(height / 2, height - br.p),
        )
        ..cubicTo(
          right,
          bottom - (br.p - br.a),
          right,
          bottom - (br.p - br.a - br.b),
          right - br.d,
          bottom - (br.p - br.a - br.b - br.c),
        )
        ..arcTo(
          Rect.fromCircle(
            center: Offset(right - br.radius, bottom - br.radius),
            radius: br.radius,
          ),
          br.angleBezier.toRadian(),
          (90 - br.angleBezier * 2).toRadian(),
          false,
        )
        ..cubicTo(
          right - (br.p - br.a - br.b),
          bottom,
          right - (br.p - br.a),
          bottom,
          left + max(width / 2, width - br.p),
          bottom,
        );

      //bottom left
      path
        ..lineTo(left + min(width / 2, bl.p), bottom)
        ..cubicTo(
          left + (bl.p - bl.a),
          bottom,
          left + (bl.p - bl.a - bl.b),
          bottom,
          left + (bl.p - bl.a - bl.b - bl.c),
          bottom - bl.d,
        )
        ..arcTo(
          Rect.fromCircle(
            center: Offset(left + bl.radius, bottom - bl.radius),
            radius: bl.radius,
          ),
          (90 + bl.angleBezier).toRadian(),
          (90 - bl.angleBezier * 2).toRadian(),
          false,
        )
        ..cubicTo(
          left,
          bottom - (bl.p - bl.a - bl.b),
          left,
          bottom - (bl.p - bl.a),
          left,
          top + max(height / 2, height - bl.p),
        );

      //top left
      path
        ..lineTo(left, top + min(height / 2, tl.p))
        ..cubicTo(
          left,
          top + (tl.p - tl.a),
          left,
          top + (tl.p - tl.a - tl.b),
          left + tl.d,
          top + (tl.p - tl.a - tl.b - tl.c),
        )
        ..arcTo(
          Rect.fromCircle(
            center: Offset(left + tl.radius, top + tl.radius),
            radius: tl.radius,
          ),
          (180 + tl.angleBezier).toRadian(),
          (90 - tl.angleBezier * 2).toRadian(),
          false,
        )
        ..cubicTo(
          left + (tl.p - tl.a - tl.b),
          top,
          left + (tl.p - tl.a),
          top,
          left + min(width / 2, tl.p),
          top,
        );

      path.close();
    }
    return path;
  }

  @override
  Path getOuterPath(final Rect rect, {final TextDirection? textDirection}) {
    return getPath(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paintInterior(
    final Canvas canvas,
    final Rect rect,
    final Paint paint, {
    final TextDirection? textDirection,
  }) {
    canvas.drawRRect(borderRadius.resolve(textDirection).toRRect(rect), paint);
  }

  @override
  bool get preferPaintInterior => true;

  @override
  void paint(
    final Canvas canvas,
    final Rect rect, {
    final double? gapStart,
    final double gapExtent = 0.0,
    final double gapPercentage = 0.0,
    final TextDirection? textDirection,
  }) {
    assert(gapPercentage >= 0.0 && gapPercentage <= 1.0);
    if (rect.isEmpty) {
      return;
    }
    switch (borderSide.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final Path path = getPath(
          borderRadius
              .resolve(textDirection)
              .toRRect(rect)
              .deflate(borderSide.width / 2),
        );
        final Paint paint = borderSide.toPaint()..isAntiAlias = true;
        canvas.drawPath(path, paint);
    }
  }

  @override
  bool operator ==(final Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is SmoothOutlineInputBorder &&
        other.borderSide == borderSide &&
        other.smoothness == smoothness &&
        other.borderRadius == borderRadius &&
        other.gapPadding == gapPadding;
  }

  @override
  int get hashCode {
    return Object.hash(
      borderSide,
      smoothness,
      borderRadius,
      gapPadding,
    );
  }
}

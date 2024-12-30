import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import 'squircle.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    this.child,
    this.color,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.shadows,
  });

  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final List<BoxShadow>? shadows;

  @override
  Widget build(final BuildContext context) {
    final Color backgroundColor = AppColors.getBackgroundColor(
      context,
      BackgroundType.card,
    );
    final Color borderColor = AppColors.getBorderColor(context);
    final BorderSide borderSide = BorderSide(color: borderColor, width: 2);
    return Padding(
      padding: padding,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: color ?? backgroundColor,
          shadows: shadows,
          shape: SmoothRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.borderRadius),
            side: borderSide,
          ),
        ),
        child: Padding(
          padding: margin,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SmoothClipRRect(
              borderRadius: BorderRadius.circular(Dimens.borderRadius - 2.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

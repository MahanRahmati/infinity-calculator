import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import 'interaction.dart';
import 'squircle.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.child,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.alignment = Alignment.center,
    this.backgroundColor,
    this.borderRadius,
    this.elavation,
    this.onPressed,
    this.onLongPress,
  });

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text] widget.
  final Widget? child;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses
  /// focus.
  final ValueChanged<bool>? onFocusChange;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// The alignment of the button's [child].
  ///
  /// Typically buttons are sized to be just big enough to contain the child
  /// and its
  /// [padding]. If the button's size is constrained to a fixed size, for
  /// example by enclosing it with a [SizedBox], this property defines how the
  /// child is aligned within the available space.
  ///
  /// Always defaults to [Alignment.center].
  final AlignmentGeometry alignment;

  /// The button's background fill color.
  final Color? backgroundColor;

  /// The button's border radius.
  final double? borderRadius;

  /// The button's elevation.
  final int? elavation;

  /// The callback that is called when the button is tapped or otherwise
  /// activated.
  ///
  /// If [onPressed] and [onLongPress] callbacks are null, then the button will
  /// be disabled.
  final VoidCallback? onPressed;

  /// If [onPressed] and [onLongPress] callbacks are null, then the button will
  /// be disabled.
  final VoidCallback? onLongPress;

  @override
  Widget build(final BuildContext context) {
    return Interaction(
      focusNode: focusNode,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
      onPressed: onPressed,
      onLongPress: onLongPress,
      builder: (
        final BuildContext context,
        final bool enabled,
        final bool isHovered,
        final bool isFocused,
        final bool isHeldDown,
      ) {
        final Color color = backgroundColor ??
            AppColors.getButtonBackgroundColor(
              context,
              elavation: elavation ?? 1,
            );
        final Color backgroundHoverColor = AppColors.getHoverColor(
          color,
        );
        final Color backgroundPressedColor = AppColors.getPressedColor(
          color,
        );
        final Color bg = !enabled
            ? color.disabled()
            : isHeldDown
                ? backgroundPressedColor
                : isHovered
                    ? backgroundHoverColor
                    : color;

        return Semantics(
          button: true,
          child: DecoratedBox(
            decoration: ShapeDecoration(
              shape: SmoothRectangleBorder(
                borderRadius: BorderRadius.circular(
                  borderRadius ?? Dimens.borderRadius,
                ),
                side: BorderSide(
                  color: enabled && isFocused ? bg : AppColors.transparent,
                  width: 2,
                ),
              ),
              color: bg,
            ),
            child: Align(
              alignment: alignment,
              widthFactor: 1.0,
              heightFactor: 1.0,
              child: DefaultTextStyle(
                style: AppTypography.body,
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          ),
        );
      },
    );
  }
}

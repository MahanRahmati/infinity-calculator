import 'dart:math' as math;

import 'package:app_constants/app_constants.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'interaction.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onPressed,
  });

  /// A widget to display before the title.
  final Widget? leading;

  /// The primary content of the list tile.
  final Widget title;

  /// Additional content displayed below the title.
  final Widget? subtitle;

  /// A widget to display after the title.
  final Widget? trailing;

  /// Called when the item is pressed.
  final VoidCallback? onPressed;

  @override
  Widget build(final BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);
    final Widget titleText = DefaultTextStyle(
      style: AppTypography.body.copyWith(
        color: AppColors.getForegroundColor(context),
      ),
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: title,
    );

    Widget? subtitleText;
    if (subtitle != null) {
      subtitleText = DefaultTextStyle(
        style: AppTypography.caption.copyWith(
          color: AppColors.getForegroundColor(context).dimmed(),
        ),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: subtitle!,
      );
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Interaction(
        onPressed: onPressed,
        useScale: false,
        builder: (
          final BuildContext context,
          final bool enabled,
          final bool isHovered,
          final bool isFocused,
          final bool isHeldDown,
        ) {
          final Color backgroundColor = AppColors.getBackgroundColor(
            context,
            BackgroundType.card,
          );
          final Color backgroundHoverColor = AppColors.getHoverColor(
            backgroundColor,
          );
          final Color backgroundPressedColor = AppColors.getPressedColor(
            backgroundColor,
          );
          final Color bg = !enabled
              ? backgroundColor.disabled()
              : isFocused || isHeldDown
                  ? backgroundPressedColor
                  : isHovered
                      ? backgroundHoverColor
                      : backgroundColor;
          return Semantics(
            button: onPressed != null,
            enabled: enabled,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: bg,
              ),
              child: _ListItem(
                leading: leading,
                title: titleText,
                subtitle: subtitleText,
                trailing: trailing,
                textDirection: textDirection,
              ),
            ),
          );
        },
      ),
    );
  }
}

enum _ListItemSlot {
  leading,
  title,
  subtitle,
  trailing,
}

class _ListItem
    extends SlottedMultiChildRenderObjectWidget<_ListItemSlot, RenderBox> {
  const _ListItem({
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.textDirection,
  });

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final TextDirection textDirection;

  @override
  Iterable<_ListItemSlot> get slots => _ListItemSlot.values;

  @override
  Widget? childForSlot(final _ListItemSlot slot) {
    return switch (slot) {
      _ListItemSlot.leading => leading,
      _ListItemSlot.title => title,
      _ListItemSlot.subtitle => subtitle,
      _ListItemSlot.trailing => trailing,
    };
  }

  @override
  _RenderListItem createRenderObject(final BuildContext context) {
    return _RenderListItem(
      textDirection: textDirection,
    );
  }

  @override
  void updateRenderObject(
    final BuildContext context,
    final _RenderListItem renderObject,
  ) {
    renderObject.textDirection = textDirection;
  }
}

class _RenderListItem extends RenderBox
    with SlottedContainerRenderObjectMixin<_ListItemSlot, RenderBox> {
  _RenderListItem({
    required final TextDirection textDirection,
  }) : _textDirection = textDirection;

  RenderBox? get leading => childForSlot(_ListItemSlot.leading);
  RenderBox get title => childForSlot(_ListItemSlot.title)!;
  RenderBox? get subtitle => childForSlot(_ListItemSlot.subtitle);
  RenderBox? get trailing => childForSlot(_ListItemSlot.trailing);

  // The returned list is ordered for hit testing.
  @override
  Iterable<RenderBox> get children {
    final RenderBox? title = childForSlot(_ListItemSlot.title);
    return <RenderBox>[
      if (leading != null) leading!,
      if (title != null) title,
      if (subtitle != null) subtitle!,
      if (trailing != null) trailing!,
    ];
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(final TextDirection value) {
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    markNeedsLayout();
  }

  @override
  bool get sizedByParent => false;

  @override
  double computeMinIntrinsicWidth(final double height) {
    final double leadingWidth = leading?.getMinIntrinsicWidth(height) ?? 0;
    final double titleWidth = title.getMinIntrinsicWidth(height);
    final double subtitleWidth = subtitle?.getMinIntrinsicWidth(height) ?? 0;
    final double trailingWidth = trailing?.getMinIntrinsicWidth(height) ?? 0;

    return leadingWidth +
        titleWidth +
        subtitleWidth +
        trailingWidth +
        32.0; // Adding padding
  }

  @override
  double computeMaxIntrinsicWidth(final double height) {
    final double leadingWidth = leading?.getMaxIntrinsicWidth(height) ?? 0;
    final double titleWidth = title.getMaxIntrinsicWidth(height);
    final double subtitleWidth = subtitle?.getMaxIntrinsicWidth(height) ?? 0;
    final double trailingWidth = trailing?.getMaxIntrinsicWidth(height) ?? 0;

    return leadingWidth + titleWidth + subtitleWidth + trailingWidth + 32.0;
  }

  @override
  double computeMinIntrinsicHeight(final double width) {
    final double titleHeight = title.getMinIntrinsicHeight(width);
    final double subtitleHeight = subtitle?.getMinIntrinsicHeight(width) ?? 0;
    return titleHeight + subtitleHeight + 16.0; // Adding vertical padding
  }

  @override
  double computeMaxIntrinsicHeight(final double width) {
    final double titleHeight = title.getMaxIntrinsicHeight(width);
    final double subtitleHeight = subtitle?.getMaxIntrinsicHeight(width) ?? 0;
    return titleHeight + subtitleHeight + 16.0;
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    double width =
        constraints.maxWidth - Dimens.largePadding - Dimens.largePadding;
    double height = 0;

    // Layout leading
    if (leading != null) {
      leading!.layout(
        BoxConstraints.loose(constraints.biggest),
        parentUsesSize: true,
      );
      width -= leading!.size.width + Dimens.padding;
    }

    // Layout trailing
    if (trailing != null) {
      trailing!.layout(
        BoxConstraints.loose(constraints.biggest),
        parentUsesSize: true,
      );
      width -= trailing!.size.width + Dimens.padding;
    }

    // Layout title
    final BoxConstraints titleConstraints = BoxConstraints(maxWidth: width);
    title.layout(titleConstraints, parentUsesSize: true);
    height = title.size.height;

    // Layout subtitle if present
    if (subtitle != null) {
      subtitle!.layout(titleConstraints, parentUsesSize: true);
      height += subtitle!.size.height + Dimens.mediumPadding;
    }

    // Set final size
    size = Size(
      constraints.maxWidth,
      math.max(height + 16.0, 56),
    );
  }

  @override
  void paint(final PaintingContext context, final Offset offset) {
    // Paint leading
    if (leading != null) {
      context.paintChild(
        leading!,
        offset.translate(
          Dimens.largePadding,
          (size.height - leading!.size.height) / 2,
        ),
      );
    }

    // Calculate x position after leading
    final double x = Dimens.largePadding +
        (leading != null ? leading!.size.width + Dimens.mediumPadding : 0);

    // Paint title with vertical centering when no subtitle
    final double titleY = subtitle != null
        ? Dimens.mediumPadding
        : (size.height - title.size.height) / 2;
    context.paintChild(title, offset.translate(x, titleY));

    // Paint subtitle
    if (subtitle != null) {
      context.paintChild(
        subtitle!,
        offset.translate(x, 8.0 + title.size.height + Dimens.padding),
      );
    }

    // Paint trailing
    if (trailing != null) {
      final double trailingX =
          size.width - trailing!.size.width - Dimens.largePadding;
      context.paintChild(
        trailing!,
        offset.translate(trailingX, (size.height - trailing!.size.height) / 2),
      );
    }
  }

  @override
  bool hitTestChildren(
    final BoxHitTestResult result, {
    required final Offset position,
  }) {
    for (final RenderBox child in children) {
      final BoxParentData parentData = child.parentData! as BoxParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (final BoxHitTestResult result, final Offset transformed) {
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
    }
    return false;
  }
}

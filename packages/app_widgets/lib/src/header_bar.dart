import 'package:app_constants/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'app_divider.dart';

const double _kMaxTitleTextScaleFactor = 1.34;

class _PreferredHeaderBarSize extends Size {
  _PreferredHeaderBarSize(this.bottomHeight)
      : super.fromHeight((Dimens.headerbarHeight) + (bottomHeight ?? 0));

  final double? bottomHeight;
}

class HeaderBar extends StatefulWidget implements PreferredSizeWidget {
  HeaderBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.bottom,
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.systemOverlayStyle,
  }) : preferredSize = _PreferredHeaderBarSize(bottom?.preferredSize.height);

  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool primary;
  final bool excludeHeaderSemantics;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  final Size preferredSize;

  @override
  State<HeaderBar> createState() => _HeaderBarState();
}

class _HeaderBarState extends State<HeaderBar> {
  SystemUiOverlayStyle _systemOverlayStyleForBrightness(
    final Brightness brightness, [
    final Color? backgroundColor,
  ]) {
    final SystemUiOverlayStyle style = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;
    // For backward compatibility, create an overlay style without system
    // navigation bar settings.
    return SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      statusBarBrightness: style.statusBarBrightness,
      statusBarIconBrightness: style.statusBarIconBrightness,
      systemStatusBarContrastEnforced: style.systemStatusBarContrastEnforced,
    );
  }

  @override
  Widget build(final BuildContext context) {
    assert(!widget.primary || debugCheckHasMediaQuery(context));

    final Color backgroundColor = AppColors.getBackgroundColor(
      context,
      BackgroundType.headerbar,
    );
    final Color borderColor = AppColors.getCardShadeColor(context);

    final Widget? leading = widget.leading;

    Widget? title = widget.title;
    if (title != null) {
      title = _HeaderBarTitleBox(child: title);
      if (!widget.excludeHeaderSemantics) {
        title = Semantics(
          namesRoute: switch (defaultTargetPlatform) {
            TargetPlatform.android ||
            TargetPlatform.fuchsia ||
            TargetPlatform.linux ||
            TargetPlatform.windows =>
              true,
            TargetPlatform.iOS || TargetPlatform.macOS => null,
          },
          header: true,
          child: title,
        );
      }

      title = DefaultTextStyle(
        style: AppTypography.heading.copyWith(
          color: AppColors.getForegroundColor(context),
        ),
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: title,
      );

      // Set maximum text scale factor to [_kMaxTitleTextScaleFactor] for the
      // title to keep the visual hierarchy the same even with larger font
      // sizes. To opt out, wrap the [title] widget in a [MediaQuery] widget
      // with a different `TextScaler`.
      title = MediaQuery.withClampedTextScaling(
        maxScaleFactor: _kMaxTitleTextScaleFactor,
        child: title,
      );
    }

    Widget? actions;
    if (widget.actions != null && widget.actions!.isNotEmpty) {
      actions = Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.actions!,
      );
    }

    final Widget toolbar = NavigationToolbar(
      leading: leading,
      middle: title,
      trailing: actions,
    );

    // If the toolbar is allocated less than toolbarHeight make it
    // appear to scroll upwards within its shrinking container.
    Widget headerBar = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: Dimens.headerbarHeight,
            ),
            child: toolbar,
          ),
        ),
        if (widget.bottom != null) widget.bottom!,
        AppDivider(
          height: 1,
          color: borderColor,
        ),
      ],
    );

    if (widget.primary) {
      headerBar = SafeArea(
        bottom: false,
        child: headerBar,
      );
    }

    headerBar = Align(
      alignment: Alignment.topCenter,
      child: headerBar,
    );

    final SystemUiOverlayStyle overlayStyle = widget.systemOverlayStyle ??
        _systemOverlayStyleForBrightness(
          backgroundColor.estimateBrightness(),
          const Color(0x00000000),
        );

    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Semantics(
            explicitChildNodes: true,
            child: headerBar,
          ),
        ),
      ),
    );
  }
}

class _HeaderBarTitleBox extends SingleChildRenderObjectWidget {
  const _HeaderBarTitleBox({required Widget super.child});

  @override
  _RenderHeaderBarTitleBox createRenderObject(final BuildContext context) {
    return _RenderHeaderBarTitleBox(
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
    final BuildContext context,
    final _RenderHeaderBarTitleBox renderObject,
  ) {
    renderObject.textDirection = Directionality.of(context);
  }
}

class _RenderHeaderBarTitleBox extends RenderAligningShiftedBox {
  _RenderHeaderBarTitleBox({
    super.textDirection,
  }) : super(alignment: Alignment.center);

  @override
  Size computeDryLayout(final BoxConstraints constraints) {
    final BoxConstraints innerConstraints = constraints.copyWith(
      maxHeight: double.infinity,
    );
    final Size childSize = child!.getDryLayout(innerConstraints);
    return constraints.constrain(childSize);
  }

  @override
  double? computeDryBaseline(
    covariant final BoxConstraints constraints,
    final TextBaseline baseline,
  ) {
    final BoxConstraints innerConstraints = constraints.copyWith(
      maxHeight: double.infinity,
    );
    final RenderBox? child = this.child;
    if (child == null) {
      return null;
    }
    final double? result = child.getDryBaseline(innerConstraints, baseline);
    if (result == null) {
      return null;
    }
    final Size childSize = child.getDryLayout(innerConstraints);
    return result +
        resolvedAlignment
            .alongOffset(getDryLayout(constraints) - childSize as Offset)
            .dy;
  }

  @override
  void performLayout() {
    final BoxConstraints innerConstraints = constraints.copyWith(
      maxHeight: double.infinity,
    );
    child!.layout(innerConstraints, parentUsesSize: true);
    size = constraints.constrain(child!.size);
    alignChild();
  }
}

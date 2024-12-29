import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import 'responsive_animations.dart';
import 'responsive_bottom_widget.dart';
import 'responsive_side_widget.dart';

typedef ResponsivePageBuilder = Widget? Function(
  BuildContext context,
  bool extended,
  bool fullExtended,
);

class ResponsivePage extends StatefulWidget {
  const ResponsivePage({
    super.key,
    this.startWidgetBuilder,
    required this.childWidgetBuilder,
    this.endWidgetBuilder,
    this.bottomWidget,
  });

  final ResponsivePageBuilder? startWidgetBuilder;
  final ResponsivePageBuilder childWidgetBuilder;
  final ResponsivePageBuilder? endWidgetBuilder;
  final Widget? bottomWidget;

  @override
  State<ResponsivePage> createState() => _ResponsivePageState();
}

class _ResponsivePageState extends State<ResponsivePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late SideAnimation _startWidgetAnimation;
  late SideAnimation _endWidgetAnimation;
  late BottomAnimation _bottomWidgetAnimation;

  bool controllerInitialized = false;
  bool extended = false;
  bool fullExtended = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 350),
      value: 0,
      vsync: this,
    );
    _startWidgetAnimation = SideAnimation(parent: _controller);
    _endWidgetAnimation = SideAnimation(parent: _controller);
    _bottomWidgetAnimation = BottomAnimation(parent: _controller);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    extended = isExtended(context);
    fullExtended = isFullExtended(context);
    final AnimationStatus status = _controller.status;

    if (extended) {
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = extended ? 1 : 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (final BuildContext context, final Widget? child) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    if (widget.startWidgetBuilder != null)
                      ResponsiveSideWidget(
                        animation: _startWidgetAnimation,
                        child: widget.startWidgetBuilder!(
                          context,
                          extended,
                          fullExtended,
                        ),
                      ),
                    Expanded(child: child ?? const SizedBox()),
                    if (widget.endWidgetBuilder != null)
                      ResponsiveSideWidget(
                        animation: _endWidgetAnimation,
                        position: ResponsiveSideWidgetPosition.end,
                        child: widget.endWidgetBuilder!(
                          context,
                          extended,
                          fullExtended,
                        ),
                      ),
                  ],
                ),
              ),
              if (widget.bottomWidget != null)
                ResponsiveBottomWidget(
                  animation: _bottomWidgetAnimation,
                  child: widget.bottomWidget,
                ),
            ],
          ),
        );
      },
      child: widget.childWidgetBuilder(context, extended, fullExtended),
    );
  }
}

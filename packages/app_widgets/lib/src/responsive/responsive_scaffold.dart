import 'package:app_constants/app_constants.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:flutter/widgets.dart';

typedef ResponsiveBuilder = Widget? Function(
  BuildContext context,
  bool extended,
  bool fullExtended,
);

typedef ResponsiveHeaderBarBuilder = PreferredSizeWidget? Function(
  BuildContext context,
  bool extended,
  bool fullExtended,
);

class ResponsiveScaffold extends StatefulWidget {
  const ResponsiveScaffold({
    super.key,
    this.headerBarBuilder,
    this.bodyBuilder,
    this.backgroundColor,
  });

  final ResponsiveHeaderBarBuilder? headerBarBuilder;
  final ResponsiveBuilder? bodyBuilder;
  final Color? backgroundColor;

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

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
        return Scaffold(
          backgroundColor: widget.backgroundColor,
          appBar: widget.headerBarBuilder?.call(
            context,
            extended,
            fullExtended,
          ),
          body: child,
        );
      },
      child: SafeArea(
        child: widget.bodyBuilder?.call(context, extended, fullExtended) ??
            const SizedBox.shrink(),
      ),
    );
  }
}

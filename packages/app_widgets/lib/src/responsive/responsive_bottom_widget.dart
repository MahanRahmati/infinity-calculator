import 'package:flutter/widgets.dart';

import 'responsive_animations.dart';

class ResponsiveBottomWidget extends StatefulWidget {
  const ResponsiveBottomWidget({
    super.key,
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget? child;

  @override
  State<ResponsiveBottomWidget> createState() => _ResponsiveBottomWidgetState();
}

class _ResponsiveBottomWidgetState extends State<ResponsiveBottomWidget> {
  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1),
    end: Offset.zero,
  ).animate(OffsetAnimation(parent: widget.animation));

  late final Animation<double> heightAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(SizeAnimation(parent: widget.animation));

  @override
  Widget build(final BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topLeft,
        heightFactor: heightAnimation.value,
        child: FractionalTranslation(
          translation: offsetAnimation.value,
          child: widget.child,
        ),
      ),
    );
  }
}

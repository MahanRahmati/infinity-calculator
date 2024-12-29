import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import '../app_card.dart';
import 'responsive_animations.dart';

enum ResponsiveSideWidgetPosition {
  start,
  end,
}

class ResponsiveSideWidget extends StatefulWidget {
  const ResponsiveSideWidget({
    super.key,
    required this.animation,
    this.child,
    this.position = ResponsiveSideWidgetPosition.start,
  });

  final Animation<double> animation;
  final Widget? child;
  final ResponsiveSideWidgetPosition position;

  @override
  State<ResponsiveSideWidget> createState() => _ResponsiveSideWidgetState();
}

class _ResponsiveSideWidgetState extends State<ResponsiveSideWidget> {
  // The animations are only rebuilt by this method when the text
  // direction changes because this widget only depends on Directionality.
  late final bool ltr = Directionality.of(context) == TextDirection.ltr;
  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: widget.position == ResponsiveSideWidgetPosition.start
        ? ltr
            ? const Offset(-1, 0)
            : const Offset(1, 0)
        : ltr
            ? const Offset(1, 0)
            : const Offset(-1, 0),
    end: Offset.zero,
  ).animate(OffsetAnimation(parent: widget.animation));

  late final Animation<double> widthAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(SizeAnimation(parent: widget.animation));

  @override
  Widget build(final BuildContext context) {
    if (widget.child == null) {
      return const SizedBox();
    }
    return ClipRect(
      child: AnimatedBuilder(
        animation: widthAnimation,
        builder: (final BuildContext context, final Widget? child) {
          return Align(
            alignment: Alignment.topLeft,
            widthFactor: widthAnimation.value,
            child: FractionalTranslation(
              translation: offsetAnimation.value,
              child: SizedBox(
                width: Dimens.sidebarWidth,
                child: AppCard(
                  color: AppColors.getBackgroundColor(
                    context,
                    BackgroundType.sidebar,
                  ),
                  padding: EdgeInsetsDirectional.only(
                    start: widget.position == ResponsiveSideWidgetPosition.end
                        ? 0
                        : Dimens.largePadding,
                    top: Dimens.largePadding,
                    end: widget.position == ResponsiveSideWidgetPosition.start
                        ? 0
                        : Dimens.largePadding,
                    bottom: Dimens.largePadding,
                  ),
                  child: widget.child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

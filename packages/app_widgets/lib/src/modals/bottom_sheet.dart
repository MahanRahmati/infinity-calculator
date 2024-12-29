import 'package:app_constants/app_constants.dart';
import 'package:flutter/material.dart' show MaterialLocalizations;
import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../squircle.dart';

class AppBottomSheetModalType extends WoltModalType {
  const AppBottomSheetModalType({
    super.shapeBorder = _defaultShapeBorder,
    super.showDragHandle = false,
    super.barrierDismissible = true,
  });

  static const ShapeBorder _defaultShapeBorder = SmoothRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(Dimens.borderRadius),
    ),
  );

  @override
  String routeLabel(final BuildContext context) {
    return MaterialLocalizations.of(context).bottomSheetLabel;
  }

  @override
  BoxConstraints layoutModal(final Size availableSize) {
    return BoxConstraints(
      maxWidth: availableSize.width,
      minHeight: Dimens.dialogMinHeight,
      maxHeight: availableSize.height * 0.9,
    );
  }

  @override
  Offset positionModal(
    final Size availableSize,
    final Size modalContentSize,
    final TextDirection textDirection,
  ) {
    return Offset(
      0,
      availableSize.height - modalContentSize.height,
    );
  }

  @override
  Widget buildTransitions(
    final BuildContext context,
    final Animation<double> animation,
    final Animation<double> secondaryAnimation,
    final Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ),
      ),
      child: child,
    );
  }
}

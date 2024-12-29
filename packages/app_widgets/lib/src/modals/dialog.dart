import 'package:app_constants/app_constants.dart';
import 'package:flutter/material.dart' show MaterialLocalizations;
import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../squircle.dart';

class AppDialogModalType extends WoltModalType {
  const AppDialogModalType({
    super.shapeBorder = _defaultShapeBorder,
    super.showDragHandle = false,
    super.barrierDismissible = true,
  });

  static const ShapeBorder _defaultShapeBorder = SmoothRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(Dimens.borderRadius),
    ),
  );

  @override
  String routeLabel(final BuildContext context) {
    return MaterialLocalizations.of(context).dialogLabel;
  }

  @override
  BoxConstraints layoutModal(final Size availableSize) {
    return BoxConstraints(
      minWidth: Dimens.dialogMinWidth,
      maxWidth: Dimens.dialogMaxWidth,
      minHeight: Dimens.dialogMinHeight,
      maxHeight: availableSize.height * 0.8,
    );
  }

  @override
  Offset positionModal(
    final Size availableSize,
    final Size modalContentSize,
    final TextDirection textDirection,
  ) {
    return Offset(
      (availableSize.width - modalContentSize.width) / 2,
      (availableSize.height - modalContentSize.height) / 2,
    );
  }

  @override
  Widget buildTransitions(
    final BuildContext context,
    final Animation<double> animation,
    final Animation<double> secondaryAnimation,
    final Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      ),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.9, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ),
        ),
        child: child,
      ),
    );
  }
}

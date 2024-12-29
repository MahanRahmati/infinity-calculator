import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';

class IconButton extends StatelessWidget {
  const IconButton({
    super.key,
    this.icon,
    this.onPressed,
    this.statusType,
    this.backgroundColor,
    this.backgroundType,
  });

  final IconData? icon;
  final VoidCallback? onPressed;
  final StatusType? statusType;
  final Color? backgroundColor;
  final BackgroundType? backgroundType;

  @override
  Widget build(final BuildContext context) {
    Color bg = AppColors.getBackgroundColor(
      context,
      backgroundType ?? BackgroundType.headerbar,
    );
    Color fg = AppColors.getForegroundColor(context);

    if (statusType != null) {
      fg = AppColors.getStatusColor(context, statusType!);
      bg = fg.withTransparency(0.15);
    }

    if (onPressed == null) {
      fg = fg.dimmed();
      bg = AppColors.getBackgroundColor(
        context,
        BackgroundType.headerbar,
      );
    }

    return Button(
      onPressed: onPressed,
      borderRadius: Dimens.smallBorderRadius,
      backgroundColor: backgroundColor ?? bg,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.padding),
        child: Icon(
          icon,
          color: fg,
        ),
      ),
    );
  }
}

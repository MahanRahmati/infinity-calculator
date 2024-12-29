import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import '../button.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    this.onPressed,
    this.statusType,
    this.child,
  });

  final VoidCallback? onPressed;
  final StatusType? statusType;
  final Widget? child;

  @override
  Widget build(final BuildContext context) {
    Color bg = AppColors.getButtonBackgroundColor(context);
    Color fg = AppColors.getForegroundColor(context);
    if (statusType != null) {
      fg = AppColors.getStatusColor(context, statusType!);
      bg = fg.withTransparency(0.15);
    }
    return Button(
      backgroundColor: bg,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimens.largePadding + Dimens.smallPadding,
              horizontal: Dimens.padding,
            ),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: fg),
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:app_constants/app_constants.dart';
import 'package:app_providers/app_providers.dart';
import 'package:flutter/widgets.dart';

import 'icon_button.dart';

class BackButton extends ConsumerWidget {
  const BackButton({
    super.key,
    this.onPressed,
    this.backgroundColor,
  });

  final VoidCallback? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.only(start: Dimens.padding),
          child: IconButton(
            onPressed: onPressed ?? () => Navigator.maybePop(context),
            icon: isRTL
                ? MingCuteIcons.mgc_right_line
                : MingCuteIcons.mgc_left_line,
            backgroundColor: backgroundColor,
          ),
        ),
      ],
    );
  }
}

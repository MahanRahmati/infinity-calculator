import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import 'icon_button.dart';

class CloseButton extends StatelessWidget {
  const CloseButton({super.key});

  @override
  Widget build(final BuildContext context) {
    return IconButton(
      backgroundColor: AppColors.getButtonBackgroundColor(context),
      icon: MingCuteIcons.mgc_close_line,
      onPressed: () => Navigator.maybePop(context),
    );
  }
}

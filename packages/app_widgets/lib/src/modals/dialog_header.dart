import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../back_button.dart';
import '../close_button.dart';

class DialogHeader extends StatelessWidget {
  const DialogHeader({
    super.key,
    this.showBackButton = false,
    this.title,
  });

  final bool showBackButton;
  final String? title;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: Dimens.padding,
        top: Dimens.largePadding,
        end: Dimens.largePadding,
      ),
      child: Row(
        children: <Widget>[
          if (showBackButton) ...<Widget>[
            BackButton(
              backgroundColor: AppColors.getButtonBackgroundColor(context),
              onPressed: () {
                WoltModalSheet.of(context).showAtIndex(0);
              },
            ),
            const SizedBox(width: Dimens.mediumPadding),
          ] else
            const SizedBox(width: Dimens.padding),
          if (title != null)
            Expanded(
              child: Text(
                title!,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.heading.copyWith(
                  color: AppColors.getForegroundColor(context),
                ),
              ),
            )
          else
            const Spacer(),
          const SizedBox(width: Dimens.mediumPadding),
          const CloseButton(),
        ],
      ),
    );
  }
}

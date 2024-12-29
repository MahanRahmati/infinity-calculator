import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import 'dialog_button.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({
    super.key,
    this.title,
    this.description,
    this.action,
  });

  final String? title;
  final String? description;
  final Widget? action;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.largePadding,
        vertical: Dimens.largePadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (title != null) ...<Widget>[
            Text(
              title!,
              style: AppTypography.title4.copyWith(
                color: AppColors.getForegroundColor(context),
              ),
            ),
            const SizedBox(height: Dimens.largePadding),
          ],
          if (description != null) ...<Widget>[
            Text(
              description!,
              style: AppTypography.body.copyWith(
                color: AppColors.getForegroundColor(context),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Dimens.largePadding),
          ],
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (action != null) ...<Widget>[
                action!,
                const SizedBox(height: Dimens.largePadding),
              ],
              DialogButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

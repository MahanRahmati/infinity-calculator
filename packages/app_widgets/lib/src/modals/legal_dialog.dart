import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import 'dialog_header.dart';

class LegalDialog extends StatelessWidget {
  const LegalDialog({
    super.key,
    this.license,
  });

  final String? license;

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const DialogHeader(showBackButton: true, title: 'Legal'),
          const SizedBox(height: Dimens.padding),
          if (license != null) ...<Widget>[
            Padding(
              padding: const EdgeInsets.all(Dimens.largePadding),
              child: Text(
                license!,
                style: AppTypography.body.copyWith(
                  color: AppColors.getForegroundColor(context),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

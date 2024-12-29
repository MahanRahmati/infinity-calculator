import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import 'dialog_header.dart';

class LegalDialog extends StatelessWidget {
  const LegalDialog({
    super.key,
    this.copyright,
    this.license,
  });

  final String? copyright;
  final String? license;

  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const DialogHeader(showBackButton: true, title: 'Legal'),
        const SizedBox(height: Dimens.padding),
        if (copyright != null)
          Padding(
            padding: const EdgeInsets.all(Dimens.largePadding),
            child: Text(
              copyright!,
              style: AppTypography.body.copyWith(
                color: AppColors.getForegroundColor(context),
              ),
            ),
          ),
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
    );
  }
}

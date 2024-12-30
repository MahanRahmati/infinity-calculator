import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

class LegalDialog extends StatelessWidget {
  const LegalDialog({
    super.key,
    required this.license,
  });

  final String license;

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.largePadding),
        child: Text(
          license,
          style: AppTypography.body.copyWith(
            color: AppColors.getForegroundColor(context),
          ),
        ),
      ),
    );
  }
}

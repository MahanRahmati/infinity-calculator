import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({
    super.key,
    this.icon,
    this.title,
  });

  final IconData? icon;
  final String? title;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null)
            Icon(
              icon,
              size: Dimens.statusPageIconSize,
              color: AppColors.getForegroundColor(context).dimmed(),
            ),
          if (icon != null && title != null)
            const SizedBox(height: Dimens.largePadding),
          if (title != null)
            Text(
              title!,
              style: AppTypography.title2.copyWith(
                color: AppColors.getForegroundColor(context),
              ),
            ),
        ],
      ),
    );
  }
}

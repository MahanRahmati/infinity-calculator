import 'package:app_constants/app_constants.dart';
import 'package:app_widgets/app_widgets.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryItem extends ConsumerWidget {
  const HistoryItem({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return ListItem(
      title: Text(
        title,
        style: AppTypography.body.copyWith(
          color: AppColors.getForegroundColor(context),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.title4.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }
}

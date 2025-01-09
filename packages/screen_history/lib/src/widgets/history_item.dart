import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

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
    return IListItem(
      title: Text(
        title,
        style: InfinityTypography.body.copyWith(
          color: InfinityColors.getForegroundColor(context),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: InfinityTypography.title3.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }
}

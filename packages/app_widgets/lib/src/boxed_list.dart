import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import 'app_card.dart';
import 'app_divider.dart';

class BoxedList extends StatelessWidget {
  const BoxedList({
    super.key,
    this.title,
    this.subtitle,
    this.suffix,
    this.children,
  });

  final String? title;
  final String? subtitle;
  final Widget? suffix;
  final List<Widget>? children;

  @override
  Widget build(final BuildContext context) {
    if (children == null) {
      return const SizedBox.shrink();
    }

    final Color borderColor = AppColors.getCardShadeColor(context);
    final List<Widget> items = <Widget>[];
    for (int i = 0; i < children!.length; i++) {
      items.add(children![i]);
      if (i < children!.length - 1) {
        items.add(AppDivider(height: 0, color: borderColor));
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (title != null || subtitle != null || suffix != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimens.padding,
              horizontal: Dimens.largePadding,
            ),
            child: Row(
              children: <Widget>[
                if (title != null || subtitle != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (title != null)
                          Text(
                            title!,
                            style: AppTypography.heading.copyWith(
                              color: AppColors.getForegroundColor(context),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: AppTypography.captionHeading.copyWith(
                              color: AppColors.getForegroundColor(context),
                            ),
                            textAlign: TextAlign.start,
                          ),
                      ],
                    ),
                  ),
                if (suffix != null) suffix!,
              ],
            ),
          ),
        FocusTraversalGroup(
          child: AppCard(
            padding: const EdgeInsets.symmetric(
              vertical: Dimens.padding,
              horizontal: Dimens.largePadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
            ),
          ),
        ),
      ],
    );
  }
}

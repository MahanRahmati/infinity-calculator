import 'package:app_constants/app_constants.dart';
import 'package:app_providers/app_providers.dart';
import 'package:app_widgets/app_widgets.dart';
import 'package:flutter/widgets.dart';

class CalculatorDisplay extends ConsumerWidget {
  const CalculatorDisplay({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final String expression =
        ref.watch(expressionProvider).replaceAll('*', '×').replaceAll('/', '÷');
    final String oldExpression = ref
        .watch(oldExpressionProvider)
        .replaceAll('*', '×')
        .replaceAll('/', '÷');
    final String error = ref.watch(errorProvider);
    return AppCard(
      padding: const EdgeInsets.only(
        left: Dimens.largePadding,
        top: Dimens.largePadding,
        right: Dimens.largePadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 1, width: double.infinity),
          _TextItem(
            text: oldExpression,
            reverse: false,
            textAlign: TextAlign.start,
            style: AppTypography.display3.copyWith(
              color: AppColors.getForegroundColor(context),
            ),
          ),
          _TextItem(
            text: expression,
            reverse: true,
            textAlign: TextAlign.end,
            style: AppTypography.display2.copyWith(
              color: AppColors.getForegroundColor(context),
            ),
          ),
          _TextItem(
            text: error,
            reverse: true,
            textAlign: TextAlign.end,
            style: AppTypography.display3.copyWith(
              color: AppColors.getStatusColor(context, StatusType.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextItem extends StatelessWidget {
  const _TextItem({
    required this.text,
    required this.reverse,
    required this.textAlign,
    required this.style,
  });

  final String text;
  final bool reverse;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(final BuildContext context) {
    return Flexible(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.only(top: Dimens.largePadding),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: reverse,
            child: Row(
              children: <Widget>[
                const SizedBox(width: Dimens.largePadding),
                Text(
                  text,
                  textAlign: textAlign,
                  style: style,
                ),
                const SizedBox(width: Dimens.largePadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:app_providers/app_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

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
    final String tempResult = ref.watch(tempResultProvider);
    final String error = ref.watch(errorProvider);
    return ICard(
      padding: const EdgeInsets.only(
        left: InfinityDimens.largePadding,
        top: InfinityDimens.largePadding,
        right: InfinityDimens.largePadding,
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
            style: InfinityTypography.display3,
          ),
          _TextItem(
            text: expression,
            reverse: true,
            textAlign: TextAlign.end,
            style: InfinityTypography.display2,
          ),
          if (tempResult.trim().isNotEmpty)
            _TextItem(
              text: tempResult,
              reverse: false,
              textAlign: TextAlign.end,
              style: InfinityTypography.display3.copyWith(
                color: InfinityColors.getForegroundColor(context).dimmed(),
              ),
            )
          else
            _TextItem(
              text: error,
              reverse: true,
              textAlign: TextAlign.end,
              style: InfinityTypography.display3.copyWith(
                color: InfinityColors.getStatusColor(context, StatusType.error),
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
          padding: const EdgeInsets.only(top: InfinityDimens.largePadding),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: reverse,
            child: Row(
              children: <Widget>[
                const SizedBox(width: InfinityDimens.largePadding),
                Text(
                  text,
                  textAlign: textAlign,
                  style: style,
                ),
                const SizedBox(width: InfinityDimens.largePadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

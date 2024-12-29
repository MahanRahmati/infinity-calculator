import 'package:app_providers/app_providers.dart';
import 'package:flutter/widgets.dart';

import 'calculator_button.dart';

class OperationButton extends ConsumerWidget {
  const OperationButton({
    super.key,
    required this.symbol,
    required this.operation,
  });

  final String symbol;
  final String operation;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return Expanded(
      child: SizedBox.expand(
        child: CalculatorButton(
          text: symbol,
          onPressed: () {
            ref.read(expressionProvider.notifier).addOperation(operation);
          },
        ),
      ),
    );
  }
}

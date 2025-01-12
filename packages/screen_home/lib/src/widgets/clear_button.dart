import 'package:app_providers/app_providers.dart';
import 'package:app_utils/app_utils.dart';
import 'package:flutter/widgets.dart';

import 'calculator_button.dart';

class ClearButton extends ConsumerWidget {
  const ClearButton({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final bool isEmpty = ref.watch(expressionProvider).isEmpty;
    return Expanded(
      child: SizedBox.expand(
        child: CalculatorButton(
          text: isEmpty ? 'C' : '⌫',
          onPressed: () {
            if (isEmpty) {
              clearAll(ref);
            } else {
              ref.read(expressionProvider.notifier).removeLast();
            }
          },
          onLongPress: () {
            clearAll(ref);
          },
        ),
      ),
    );
  }
}

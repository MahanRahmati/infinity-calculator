import 'package:app_providers/app_providers.dart';
import 'package:flutter/widgets.dart';

import 'calculator_button.dart';

class BasicButton extends ConsumerWidget {
  const BasicButton({
    super.key,
    required this.text,
    this.flex = 1,
  });

  final String text;
  final int flex;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return Expanded(
      flex: flex,
      child: SizedBox.expand(
        child: CalculatorButton(
          text: text,
          onPressed: () => ref.read(expressionProvider.notifier).add(text),
        ),
      ),
    );
  }
}

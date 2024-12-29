import 'package:app_constants/app_constants.dart';
import 'package:app_providers/app_providers.dart';
import 'package:app_utils/app_utils.dart';
import 'package:flutter/widgets.dart';

import 'basic_button.dart';
import 'calculator_button.dart';
import 'keypad_row.dart';
import 'operation_button.dart';

class CalculatorKeypad extends ConsumerWidget {
  const CalculatorKeypad({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.largePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: Dimens.largePadding,
        children: <Widget>[
          KeypadRow(
            children: <Widget>[
              Expanded(
                child: SizedBox.expand(
                  child: CalculatorButton(
                    text: 'C',
                    onPressed: () => clearAll(ref),
                  ),
                ),
              ),
              const BasicButton(text: '('),
              const BasicButton(text: ')'),
              const OperationButton(symbol: '÷', operation: '/'),
            ],
          ),
          const KeypadRow(
            children: <Widget>[
              BasicButton(text: '7'),
              BasicButton(text: '8'),
              BasicButton(text: '9'),
              OperationButton(symbol: '×', operation: '*'),
            ],
          ),
          const KeypadRow(
            children: <Widget>[
              BasicButton(text: '4'),
              BasicButton(text: '5'),
              BasicButton(text: '6'),
              OperationButton(symbol: '-', operation: '-'),
            ],
          ),
          const KeypadRow(
            children: <Widget>[
              BasicButton(text: '1'),
              BasicButton(text: '2'),
              BasicButton(text: '3'),
              OperationButton(symbol: '+', operation: '+'),
            ],
          ),
          KeypadRow(
            children: <Widget>[
              const BasicButton(text: '0'),
              Expanded(
                child: SizedBox.expand(
                  child: CalculatorButton(
                    text: '.',
                    onPressed: () {
                      ref.read(expressionProvider.notifier).addDecimal();
                    },
                  ),
                ),
              ),
              Expanded(
                child: SizedBox.expand(
                  child: CalculatorButton(
                    text: '⌫',
                    onPressed: () {
                      ref.read(expressionProvider.notifier).removeLast();
                    },
                  ),
                ),
              ),
              Expanded(
                child: SizedBox.expand(
                  child: CalculatorButton(
                    text: '=',
                    onPressed: () => calculateResult(ref),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

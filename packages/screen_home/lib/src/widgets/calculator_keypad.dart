import 'package:app_providers/app_providers.dart';
import 'package:app_utils/app_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

import 'basic_button.dart';
import 'calculator_button.dart';
import 'clear_button.dart';
import 'keypad_row.dart';
import 'operation_button.dart';

class CalculatorKeypad extends ConsumerWidget {
  const CalculatorKeypad({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(InfinityDimens.largePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: InfinityDimens.largePadding,
        children: <Widget>[
          const KeypadRow(
            children: <Widget>[
              ClearButton(),
              BasicButton(text: '('),
              BasicButton(text: ')'),
              OperationButton(symbol: '÷', operation: '/'),
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
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const BasicButton(
                  text: '0',
                  flex: 2,
                ),
                const SizedBox(width: InfinityDimens.largePadding),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: InfinityDimens.padding,
                    ),
                    child: SizedBox.expand(
                      child: CalculatorButton(
                        text: '.',
                        onPressed: () {
                          ref.read(expressionProvider.notifier).addDecimal();
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: InfinityDimens.padding,
                    ),
                    child: SizedBox.expand(
                      child: CalculatorButton(
                        text: '=',
                        onPressed: () => calculateResult(ref),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

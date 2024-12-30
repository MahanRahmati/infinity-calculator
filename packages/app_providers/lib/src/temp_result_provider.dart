import 'package:app_utils/app_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'expression_provider.dart';

part 'temp_result_provider.g.dart';

@riverpod
class TempResult extends _$TempResult {
  @override
  String build() {
    final String expression = ref.watch(expressionProvider);
    if (expression.isEmpty || expression == '0' || expression == '-') {
      return '';
    }

    if (expression.endsWith('+') ||
        expression.endsWith('-') ||
        expression.endsWith('*') ||
        expression.endsWith('/')) {
      return '';
    }

    try {
      final String result = calculateExpression(expression);
      if (result.contains('Error:')) {
        return '';
      }
      return result;
    } catch (e) {
      return '';
    }
  }

  void clear() {
    state = '';
  }
}

import 'package:app_localizations/app_localizations.dart';
import 'package:app_providers/app_providers.dart';
import 'package:libcalculator/libcalculator.dart';

void calculateResult(final WidgetRef ref) {
  final TranslationsEn t = ref.watch(translationProvider);
  final String expression = ref.read(expressionProvider);
  try {
    // Add validation for empty expression
    if (expression.isEmpty || expression == '0' || expression == '-') {
      ref.read(expressionProvider.notifier).clear();
      ref.read(expressionProvider.notifier).add('0');
      return;
    }

    // Add validation for incomplete expressions
    if (expression.endsWith('+') ||
        expression.endsWith('-') ||
        expression.endsWith('*') ||
        expression.endsWith('/')) {
      ref.read(errorProvider.notifier).set(t.malformedExpression);
      return;
    }

    // Check for mismatched parentheses
    if (expression.split('(').length != expression.split(')').length) {
      ref.read(errorProvider.notifier).set(t.malformedExpression);
      return;
    }

    final String result = Calculator().calculate(expression);
    if (result.contains('Error:')) {
      // ignore: only_throw_errors
      throw result;
    }
    ref.read(historyProvider.notifier).addCalculation(expression, result);
    ref.read(oldExpressionProvider.notifier).set(expression);
    ref.read(expressionProvider.notifier).clear();
    ref.read(expressionProvider.notifier).add(result);
    ref.read(errorProvider.notifier).clear();
  } catch (e) {
    if (e.toString().contains('Division by zero')) {
      ref.read(errorProvider.notifier).set(t.undefined);
    } else {
      ref.read(errorProvider.notifier).set(t.malformedExpression);
    }
  }
}

void clearAll(final WidgetRef ref) {
  ref.read(expressionProvider.notifier).clear();
  ref.read(oldExpressionProvider.notifier).clear();
  ref.read(errorProvider.notifier).clear();
}

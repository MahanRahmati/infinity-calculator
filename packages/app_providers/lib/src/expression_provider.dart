import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expression_provider.g.dart';

@riverpod
class Expression extends _$Expression {
  @override
  String build() {
    return '';
  }

  void clear() {
    state = '';
  }

  void removeLast() {
    final String current = state;
    if (current.isEmpty) {
      return;
    }
    state = current.substring(0, current.length - 1);
  }

  void add(final String value) {
    final String current = state;
    state = current + value;
  }

  void addOperation(final String operation) {
    final String current = state;
    if (current.isEmpty && operation == '-') {
      add(operation);
      return;
    }
    if (current.isEmpty) {
      return;
    }
    final String lastChar = current[current.length - 1];
    if (lastChar == '(' && (operation == '*' || operation == '/')) {
      return;
    }
    if ((lastChar == '+' && operation == '-') ||
        (lastChar == '-' && operation == '+')) {
      state = current.substring(0, current.length - 1);
      add('-');
      return;
    }
    if ((lastChar == '*' || lastChar == '/') && operation == '-') {
      add(operation);
      return;
    }

    if (!_isOperator(lastChar)) {
      add(operation);
    }
  }

  bool _isOperator(final String char) {
    return <String>['+', '-', '*', '/', '.'].contains(char);
  }

  void addDecimal() {
    final String current = state;
    if (canAddDecimal(current)) {
      add('.');
    }
  }

  bool canAddDecimal(final String expression) {
    if (expression.isEmpty) {
      return true;
    }

    // Split by operators but keep the operators in the result
    final List<String> parts = expression
        .split(RegExp(r'([+\-*/()])'))
        .where((final String s) => s.isNotEmpty)
        .toList();

    // If the last part already contains a decimal, don't allow another one
    final String lastPart = parts.last;
    return !lastPart.contains('.');
  }
}

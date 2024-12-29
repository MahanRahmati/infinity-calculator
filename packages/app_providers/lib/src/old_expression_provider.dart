import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'old_expression_provider.g.dart';

@riverpod
class OldExpression extends _$OldExpression {
  @override
  String build() {
    return '';
  }

  void clear() {
    state = '';
  }

  void set(final String? value) {
    if (value == null) {
      state = '';
      return;
    }
    state = value;
  }
}

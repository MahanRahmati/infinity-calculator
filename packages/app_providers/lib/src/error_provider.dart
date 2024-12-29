import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_provider.g.dart';

@riverpod
class Error extends _$Error {
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

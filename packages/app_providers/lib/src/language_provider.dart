import 'package:app_localizations/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_provider.g.dart';

/// AppLanguage manages the selected application language.
@riverpod
class AppLanguage extends _$AppLanguage {
  @override
  AppLocale build() {
    final AppLocale appLocale = AppLocaleUtils.findDeviceLocale();
    return appLocale;
  }
}

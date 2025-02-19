import 'package:app_localizations/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'language_provider.dart';

part 'translation_provider.g.dart';

/// translation returns the translated strings for the current app locale.
///
/// It gets the current [AppLocale] from [appLanguageProvider].
///
/// If no locale is set, it defaults to English.
///
/// It returns the localized [Translations] for the locale.
@riverpod
Translations translation(final Ref ref) {
  final AppLocale? appLocale = ref.watch(appLanguageProvider);
  if (appLocale == null) {
    return AppLocale.en.buildSync();
  }
  return appLocale.buildSync();
}

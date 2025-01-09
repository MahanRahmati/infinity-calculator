import 'package:app_localizations/app_localizations.dart';
import 'package:app_providers/app_providers.dart';
import 'package:app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

/// The App is the root widget of the application.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final TranslationsEn t = ref.watch(translationProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: t.appName,
      locale: ref.watch(appLanguageProvider).flutterLocale,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: AppLocaleUtils.supportedLocales,
      theme: InfinityTheme.light(),
      darkTheme: InfinityTheme.dark(),
      routes: Routes.routes,
      initialRoute: Routes.initialRoute,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}

import 'package:app_localizations/app_localizations.dart';
import 'package:app_providers/app_providers.dart';
import 'package:app_router/app_router.dart';
import 'package:app_widgets/app_widgets.dart';
import 'package:flutter/widgets.dart';

import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';
import '../widgets/keyboard_handler.dart';
import '../widgets/more_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final TranslationsEn t = ref.watch(translationProvider);
    ref.watch(historyProvider);
    return KeyboardHandler(
      child: ResponsiveScaffold(
        headerBarBuilder: (
          final BuildContext context,
          final bool extended,
          final bool fullExtended,
        ) {
          return HeaderBar(
            title: Text(t.appName),
            actions: <Widget>[
              MoreButton(fullExtended: fullExtended),
            ],
          );
        },
        bodyBuilder: (
          final BuildContext context,
          final bool extended,
          final bool fullExtended,
        ) {
          return ResponsivePage(
            startWidgetBuilder: (
              final BuildContext context,
              final bool extended,
              final bool fullExtended,
            ) {
              if (fullExtended) {
                return const HistoryScreen(isInside: true);
              }
              return null;
            },
            childWidgetBuilder: (
              final BuildContext context,
              final bool extended,
              final bool fullExtended,
            ) {
              if (fullExtended) {
                return const Column(
                  children: <Widget>[
                    Expanded(flex: 35, child: CalculatorDisplay()),
                    Expanded(flex: 55, child: CalculatorKeypad()),
                  ],
                );
              }
              return const ConstrainedItem(
                child: Column(
                  children: <Widget>[
                    Expanded(flex: 35, child: CalculatorDisplay()),
                    Expanded(flex: 55, child: CalculatorKeypad()),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

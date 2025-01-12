import 'package:app_localizations/app_localizations.dart';
import 'package:app_providers/app_providers.dart';
import 'package:app_router/app_router.dart';
import 'package:flutter/widgets.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

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
      child: IResponsiveScaffold(
        useSafeArea: true,
        headerBarBuilder: (
          final BuildContext context,
          final ResponsiveStates state,
        ) {
          return IHeaderBar(
            middle: Text(t.appName),
            trailing: <Widget>[
              MoreButton(fullExtended: state == ResponsiveStates.fullExtended),
            ],
          );
        },
        startWidgetBuilder: (
          final BuildContext context,
          final ResponsiveStates state,
        ) {
          return switch (state) {
            ResponsiveStates.collapsed => null,
            ResponsiveStates.extended => null,
            ResponsiveStates.fullExtended => const HistoryScreen(
                isInside: true,
              ),
          };
        },
        childWidgetBuilder: (
          final BuildContext context,
          final ResponsiveStates state,
        ) {
          const Column child = Column(
            children: <Widget>[
              Expanded(flex: 35, child: CalculatorDisplay()),
              Expanded(flex: 55, child: CalculatorKeypad()),
            ],
          );
          return switch (state) {
            ResponsiveStates.collapsed => const IBoundedBox(child: child),
            ResponsiveStates.extended => const IBoundedBox(child: child),
            ResponsiveStates.fullExtended => child,
          };
        },
      ),
    );
  }
}

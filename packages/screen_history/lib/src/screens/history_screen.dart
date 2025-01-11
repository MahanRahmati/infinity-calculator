import 'package:app_localizations/app_localizations.dart';
import 'package:app_providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

import '../widgets/calculator_history.dart';
import '../widgets/clear_history_button.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({
    super.key,
    this.isInside = false,
  });

  final bool isInside;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final TranslationsEn t = ref.watch(translationProvider);
    return Scaffold(
      appBar: IHeaderBar(
        middle: Text(t.history),
        trailing: const <Widget>[
          ClearHistoryButton(),
        ],
        primary: !isInside,
      ),
      backgroundColor: isInside ? InfinityColors.transparent : null,
      body: const CalculatorHistory(),
    );
  }
}

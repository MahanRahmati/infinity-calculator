import 'package:app_constants/app_constants.dart';
import 'package:app_localizations/app_localizations.dart';
import 'package:app_providers/app_providers.dart';
import 'package:app_widgets/app_widgets.dart';
import 'package:flutter/material.dart' hide BackButton, IconButton;

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
      appBar: HeaderBar(
        leading: isInside ? null : const BackButton(),
        title: Text(t.history),
        actions: const <Widget>[
          ClearHistoryButton(),
        ],
      ),
      backgroundColor: isInside ? AppColors.transparent : null,
      body: const CalculatorHistory(),
    );
  }
}

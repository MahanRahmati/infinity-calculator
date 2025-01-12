import 'package:app_localizations/app_localizations.dart';
import 'package:app_providers/app_providers.dart';
import 'package:flutter/material.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

import 'history_item.dart';

class CalculatorHistory extends ConsumerWidget {
  const CalculatorHistory({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final TranslationsEn t = ref.watch(translationProvider);
    return ref.watch(historyProvider).when(
          data: (final List<HistoryData> history) {
            if (history.isEmpty) {
              return IStatusPage(
                icon: MingCuteIcons.mgc_history_line,
                title: t.emptyHistory,
              );
            }

            // Group history items by date
            final Map<String, List<HistoryData>> groupedHistory =
                groupHistoryByDate(history);

            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: InfinityDimens.padding,
              ),
              itemCount: groupedHistory.length,
              itemBuilder: (final BuildContext context, final int index) {
                final String date = groupedHistory.keys.elementAt(index);
                final List<HistoryData> dateItems = groupedHistory[date]!;

                return IBoxedList(
                  title: Text(date),
                  children: dateItems
                      .map(
                        (final HistoryData row) => HistoryItem(
                          title: row.expression,
                          subtitle: '= ${row.result}',
                        ),
                      )
                      .toList(),
                );
              },
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (final Object error, final StackTrace stackTrace) => Center(
            child: Text(
              'Error loading history: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
  }

  Map<String, List<HistoryData>> groupHistoryByDate(
    final List<HistoryData> history,
  ) {
    final Map<String, List<HistoryData>> grouped =
        <String, List<HistoryData>>{};

    for (final HistoryData item in history) {
      final DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(
        item.timestamp,
      );
      final String date =
          '${timestamp.day}/${timestamp.month}/${timestamp.year}';

      if (!grouped.containsKey(date)) {
        grouped[date] = <HistoryData>[];
      }
      grouped[date]!.add(item);
    }

    return grouped;
  }
}

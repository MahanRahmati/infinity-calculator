import 'package:app_constants/app_constants.dart';
import 'package:app_localizations/app_localizations.dart';
import 'package:app_providers/app_providers.dart';
import 'package:app_widgets/app_widgets.dart';
import 'package:flutter/material.dart' hide IconButton;

import 'history_item.dart';

class CalculatorHistory extends ConsumerWidget {
  const CalculatorHistory({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final TranslationsEn t = ref.watch(translationProvider);
    return ref.watch(historyProvider).when(
          data: (final List<HistoryData> history) {
            if (history.isEmpty) {
              return StatusPage(
                icon: MingCuteIcons.mgc_history_line,
                title: t.emptyHistory,
              );
            }

            // Group history items by date
            final Map<String, List<HistoryData>> groupedHistory =
                groupHistoryByDate(history);

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: Dimens.padding),
              itemCount: groupedHistory.length,
              itemBuilder: (final BuildContext context, final int index) {
                final String date = groupedHistory.keys.elementAt(index);
                final List<HistoryData> dateItems = groupedHistory[date]!;

                return ConstrainedItem(
                  child: BoxedList(
                    title: date,
                    children: dateItems
                        .map(
                          (final HistoryData row) => HistoryItem(
                            title: row.expression,
                            subtitle: '= ${row.result}',
                            // title: '${row['history']?['expression']}',
                            // subtitle: '= ${row['history']?['result']}',
                          ),
                        )
                        .toList(),
                  ),
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

  // Map<String, List<HistoryData>> groupHistoryByDate(
  //   final List<HistoryData> history,
  // ) {
  //   final Map<String, List<HistoryData>> grouped =
  //       <String, List<HistoryData>>{};

  //   for (final HistoryData item in history) {
  //     print('-------');
  //     print(item);
  //     print('-------');
  //     final DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(
  //       item['history']?['timestamp'] as int,
  //     );
  //     final String date =
  //         '${timestamp.day}/${timestamp.month}/${timestamp.year}';

  //     if (!grouped.containsKey(date)) {
  //       grouped[date] = <HistoryData>[];
  //     }
  //     grouped[date]!.add(item);
  //   }

  //   return grouped;
  // }
}

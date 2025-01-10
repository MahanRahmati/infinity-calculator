import 'package:app_localizations/app_localizations.dart';
import 'package:app_providers/app_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

class ClearHistoryButton extends ConsumerWidget {
  const ClearHistoryButton({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final TranslationsEn t = ref.watch(translationProvider);
    final AsyncValue<List<HistoryData>> history = ref.watch(historyProvider);
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: InfinityDimens.padding),
      child: IButton.icon(
        isTransparent: true,
        onPressed: history.when(
          data: (final List<HistoryData> data) {
            if (data.isEmpty) {
              return null;
            }
            return () {
              showDialogModal(
                context: context,
                pageListBuilder: (final BuildContext context) {
                  return <SliverWoltModalSheetPage>[
                    WoltModalSheetPage(
                      hasTopBarLayer: false,
                      child: IMessageDialog(
                        title: t.clearHistory,
                        description: t.clearHistoryDescription,
                        actions: <Widget>[
                          IButton.filled(
                            onPressed: () {
                              ref.read(historyProvider.notifier).clearHistory();
                              Navigator.pop(context);
                            },
                            statusType: StatusType.error,
                            child: Text(t.clearHistory),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
              );
            };
          },
          error: (final Object error, final StackTrace stackTrace) {
            return null;
          },
          loading: () => null,
        ),
        icon: MingCuteIcons.mgc_delete_line,
        statusType: StatusType.error,
      ),
    );
  }
}

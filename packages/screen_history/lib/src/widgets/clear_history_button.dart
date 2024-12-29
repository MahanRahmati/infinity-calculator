import 'package:app_constants/app_constants.dart';
import 'package:app_localizations/app_localizations.dart';
import 'package:app_providers/app_providers.dart';
import 'package:app_widgets/app_widgets.dart';
import 'package:flutter/widgets.dart';

class ClearHistoryButton extends ConsumerWidget {
  const ClearHistoryButton({super.key});

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    final TranslationsEn t = ref.watch(translationProvider);
    final AsyncValue<List<HistoryData>> history = ref.watch(historyProvider);
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: Dimens.padding),
      child: IconButton(
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
                      navBarHeight: 1,
                      backgroundColor: AppColors.getBackgroundColor(
                        context,
                        BackgroundType.card,
                      ),
                      surfaceTintColor: AppColors.transparent,
                      child: MessageDialog(
                        title: t.clearHistory,
                        description: t.clearHistoryDescription,
                        action: DialogButton(
                          onPressed: () {
                            ref.read(historyProvider.notifier).clearHistory();
                            Navigator.pop(context);
                          },
                          statusType: StatusType.error,
                          child: Text(t.clearHistory),
                        ),
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

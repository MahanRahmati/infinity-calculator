import 'package:app_constants/app_constants.dart';
import 'package:app_localizations/app_localizations.dart';
import 'package:app_providers/app_providers.dart';
import 'package:app_router/app_router.dart';
import 'package:flutter/widgets.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

class MoreButton extends ConsumerWidget {
  const MoreButton({
    super.key,
    required this.fullExtended,
    this.onPressed,
  });

  final bool fullExtended;
  final VoidCallback? onPressed;

  void _showMoreOptions(final BuildContext context, final WidgetRef ref) {
    final TranslationsEn t = ref.watch(translationProvider);
    final Color backgroundColor = InfinityColors.getBackgroundColor(
      context,
      BackgroundType.window,
    );

    final WoltModalSheetPage pageContent = WoltModalSheetPage(
      hasTopBarLayer: false,
      backgroundColor: backgroundColor,
      surfaceTintColor: InfinityColors.transparent,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: InfinityDimens.padding),
          child: IBoxedList(
            children: <Widget>[
              if (!fullExtended)
                IListItem(
                  leading: const Icon(MingCuteIcons.mgc_history_line),
                  title: Text(t.history),
                  onPressed: () {
                    Navigator.pop(context);
                    Routes.navigateToHistory(context);
                  },
                ),
              IListItem(
                leading: const Icon(MingCuteIcons.mgc_information_line),
                title: Text(t.about),
                onPressed: () async {
                  final String license = await Environments.getLicense();
                  final String version = await Environments.getVersion();
                  if (!context.mounted) {
                    return;
                  }
                  Navigator.pop(context);
                  showAboutDialogModal(
                    context: context,
                    applicationName: t.appName,
                    version: version,
                    applicationIcon: IApplicationIcon.asset(
                      Assets.appIcon,
                      size: InfinityDimens.appIconSize,
                    ),
                    developers: Environments.developers,
                    website: Environments.website,
                    issueUrl: Environments.issueUrl,
                    license: license,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );

    showDialogModal(
      context: context,
      pageListBuilder: (final BuildContext context) {
        return <SliverWoltModalSheetPage>[pageContent];
      },
    );
  }

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: InfinityDimens.padding),
      child: IButton.icon(
        onPressed: () => _showMoreOptions(context, ref),
        icon: MingCuteIcons.mgc_more_1_line,
      ),
    );
  }
}

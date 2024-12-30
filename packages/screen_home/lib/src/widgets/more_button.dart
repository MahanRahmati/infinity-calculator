import 'package:app_constants/app_constants.dart';
import 'package:app_localizations/app_localizations.dart';
import 'package:app_providers/app_providers.dart';
import 'package:app_router/app_router.dart';
import 'package:app_widgets/app_widgets.dart';
import 'package:flutter/widgets.dart';

class MoreButton extends ConsumerWidget {
  const MoreButton({
    super.key,
    required this.fullExtended,
    this.onPressed,
  });

  final bool fullExtended;
  final VoidCallback? onPressed;
  static final GlobalKey<State<StatefulWidget>> _buttonKey = GlobalKey();

  void _showMoreOptions(final BuildContext context, final WidgetRef ref) {
    final RenderBox? button =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (button == null) {
      return;
    }

    final Offset offset = button.localToGlobal(Offset.zero);
    final Size size = button.size;

    final TranslationsEn t = ref.watch(translationProvider);
    final Color backgroundColor = AppColors.getBackgroundColor(
      context,
      BackgroundType.window,
    );

    final WoltModalSheetPage pageContent = WoltModalSheetPage(
      navBarHeight: 1,
      backgroundColor: backgroundColor,
      surfaceTintColor: AppColors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.padding),
        child: BoxedList(
          children: <Widget>[
            if (!fullExtended)
              ListItem(
                leading: const Icon(MingCuteIcons.mgc_history_line),
                title: Text(t.history),
                onPressed: () {
                  Navigator.pop(context);
                  Routes.navigateToHistory(context);
                },
              ),
            ListItem(
              leading: const Icon(MingCuteIcons.mgc_information_line),
              title: Text(t.about),
              onPressed: () async {
                final String license = await Environments.getLicense();
                if (!context.mounted) {
                  return;
                }
                Navigator.pop(context);
                showAboutDialog(
                  context: context,
                  applicationName: t.appName,
                  version: Strings.version,
                  applicationIcon: ApplicationIcon(
                    name: Theme.of(context).brightness == Brightness.dark
                        ? Assets.appIconDark
                        : Assets.appIconLight,
                    size: Dimens.appIconSize,
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
    );

    showModal(
      context: context,
      pageListBuilder: (final BuildContext context) {
        return <SliverWoltModalSheetPage>[pageContent];
      },
      anchorPosition: Offset(
        offset.dx - Dimens.popupWidth + size.width,
        offset.dy + size.height + 4,
      ),
    );
  }

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: Dimens.padding),
      child: IconButton(
        key: _buttonKey,
        onPressed: () => _showMoreOptions(context, ref),
        icon: MingCuteIcons.mgc_more_1_line,
      ),
    );
  }
}

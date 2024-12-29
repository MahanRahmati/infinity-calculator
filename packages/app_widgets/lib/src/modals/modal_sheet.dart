import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'about_dialog.dart';
import 'bottom_dialog.dart';
import 'bottom_sheet.dart';
import 'credits_dialog.dart';
import 'dialog.dart';
import 'legal_dialog.dart';
import 'popup.dart';

export 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

void showModal({
  required final BuildContext context,
  required final WoltModalSheetPageListBuilder pageListBuilder,
  required final Offset anchorPosition,
}) {
  WoltModalSheet.show<void>(
    context: context,
    pageListBuilder: pageListBuilder,
    modalTypeBuilder: (final BuildContext context) {
      if (isExtended(context)) {
        return AppPopupModalType(
          anchorPosition: anchorPosition,
        );
      } else {
        return const AppBottomSheetModalType();
      }
    },
    onModalDismissedWithBarrierTap: () => Navigator.pop(context),
  );
}

void showDialogModal({
  required final BuildContext context,
  required final WoltModalSheetPageListBuilder pageListBuilder,
}) {
  WoltModalSheet.show<void>(
    context: context,
    pageListBuilder: pageListBuilder,
    modalTypeBuilder: (final BuildContext context) {
      if (isExtended(context)) {
        return const AppDialogModalType();
      } else {
        return const AppBottomDialogModalType();
      }
    },
    onModalDismissedWithBarrierTap: () => Navigator.pop(context),
  );
}

void showAboutDialog({
  required final BuildContext context,
  required final String applicationName,
  required final String version,
  final Widget? applicationIcon,
  final List<String> developers = const <String>[],
  final String? website,
  final String? issueUrl,
  final String? copyright,
  final String? license,
}) {
  final Color backgroundColor = AppColors.getBackgroundColor(
    context,
    BackgroundType.window,
  );

  showDialogModal(
    context: context,
    pageListBuilder: (final BuildContext context) => <SliverWoltModalSheetPage>[
      WoltModalSheetPage(
        navBarHeight: 1,
        backgroundColor: backgroundColor,
        surfaceTintColor: AppColors.transparent,
        child: AboutDialog(
          applicationName: applicationName,
          version: version,
          applicationIcon: applicationIcon,
          developers: developers,
          website: website,
          issueUrl: issueUrl,
          copyright: copyright,
          license: license,
        ),
      ),
      if (developers.isNotEmpty)
        WoltModalSheetPage(
          navBarHeight: 1,
          backgroundColor: backgroundColor,
          surfaceTintColor: AppColors.transparent,
          child: CreditsDialog(developers: developers),
        ),
      if (copyright != null || license != null)
        WoltModalSheetPage(
          navBarHeight: 1,
          backgroundColor: backgroundColor,
          surfaceTintColor: AppColors.transparent,
          child: LegalDialog(copyright: copyright, license: license),
        ),
    ],
  );
}

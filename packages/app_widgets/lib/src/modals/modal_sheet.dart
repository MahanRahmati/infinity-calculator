import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'about_dialog.dart';
import 'bottom_dialog.dart';
import 'bottom_sheet.dart';
import 'credits_dialog.dart';
import 'dialog.dart';
import 'dialog_header.dart';
import 'legal_dialog.dart';
import 'popup.dart';

export 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

void showModal({
  required final BuildContext context,
  required final WoltModalSheetPageListBuilder pageListBuilder,
  required final Offset anchorPosition,
  final bool useSafeArea = true,
}) {
  WoltModalSheet.show<void>(
    context: context,
    pageListBuilder: pageListBuilder,
    useSafeArea: useSafeArea,
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
  final bool useSafeArea = true,
}) {
  WoltModalSheet.show<void>(
    context: context,
    pageListBuilder: pageListBuilder,
    useSafeArea: useSafeArea,
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
        backgroundColor: backgroundColor,
        surfaceTintColor: AppColors.transparent,
        isTopBarLayerAlwaysVisible: true,
        topBar: const DialogHeader(),
        child: AboutDialog(
          applicationName: applicationName,
          version: version,
          applicationIcon: applicationIcon,
          developers: developers,
          website: website,
          issueUrl: issueUrl,
          license: license,
        ),
      ),
      if (developers.isNotEmpty)
        WoltModalSheetPage(
          backgroundColor: backgroundColor,
          surfaceTintColor: AppColors.transparent,
          isTopBarLayerAlwaysVisible: true,
          topBar: const DialogHeader(showBackButton: true, title: 'Credits'),
          child: CreditsDialog(developers: developers),
        ),
      if (license != null && license.trim().isNotEmpty)
        WoltModalSheetPage(
          backgroundColor: backgroundColor,
          surfaceTintColor: AppColors.transparent,
          isTopBarLayerAlwaysVisible: true,
          topBar: const DialogHeader(showBackButton: true, title: 'Legal'),
          child: LegalDialog(license: license),
        ),
    ],
  );
}

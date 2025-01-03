import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../boxed_list.dart';
import '../list_item.dart';

class AboutDialog extends StatelessWidget {
  const AboutDialog({
    super.key,
    this.applicationIcon,
    required this.applicationName,
    required this.version,
    this.website,
    this.issueUrl,
    this.developers = const <String>[],
    this.license,
  });

  final Widget? applicationIcon;
  final String applicationName;
  final String version;
  final String? website;
  final String? issueUrl;
  final List<String> developers;
  final String? license;

  @override
  Widget build(final BuildContext context) {
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (applicationIcon != null) ...<Widget>[
            applicationIcon!,
            const SizedBox(height: Dimens.mediumPadding),
          ],
          Text(
            applicationName,
            style: AppTypography.title2.copyWith(
              color: AppColors.getForegroundColor(context),
            ),
          ),
          const SizedBox(height: Dimens.padding),
          DecoratedBox(
            decoration: ShapeDecoration(
              shape: const StadiumBorder(),
              color: AppColors.primary.withTransparency(0.15),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.largePadding,
                vertical: Dimens.smallPadding,
              ),
              child: Text(
                version,
                style: AppTypography.body.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: Dimens.padding),
          if (issueUrl != null || website != null)
            BoxedList(
              children: <Widget>[
                if (website != null)
                  ListItem(
                    title: const Text('Website'),
                    trailing: const Icon(MingCuteIcons.mgc_external_link_line),
                    onPressed: () async {
                      final Uri uri = Uri.parse(website!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                      if (!context.mounted) {
                        return;
                      }
                      Navigator.pop(context);
                    },
                  ),
                if (issueUrl != null)
                  ListItem(
                    title: const Text('Report an issue'),
                    trailing: const Icon(MingCuteIcons.mgc_external_link_line),
                    onPressed: () async {
                      final Uri uri = Uri.parse(issueUrl!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                      if (!context.mounted) {
                        return;
                      }
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          if (developers.isNotEmpty ||
              (license != null && license!.trim().isNotEmpty))
            BoxedList(
              children: <Widget>[
                if (developers.isNotEmpty)
                  ListItem(
                    title: const Text('Credits'),
                    trailing: Icon(
                      isRTL
                          ? MingCuteIcons.mgc_left_line
                          : MingCuteIcons.mgc_right_line,
                    ),
                    onPressed: () {
                      WoltModalSheet.of(context).showAtIndex(1);
                    },
                  ),
                if (license != null && license!.trim().isNotEmpty)
                  ListItem(
                    title: const Text('Legal'),
                    trailing: Icon(
                      isRTL
                          ? MingCuteIcons.mgc_left_line
                          : MingCuteIcons.mgc_right_line,
                    ),
                    onPressed: () {
                      WoltModalSheet.of(context)
                          .showAtIndex(developers.isNotEmpty ? 2 : 1);
                    },
                  ),
              ],
            ),
          SizedBox(
            height: (issueUrl != null ||
                    website != null ||
                    developers.isNotEmpty ||
                    (license != null && license!.trim().isNotEmpty))
                ? Dimens.padding
                : Dimens.largePadding,
          ),
        ],
      ),
    );
  }
}

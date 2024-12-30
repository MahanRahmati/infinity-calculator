import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import '../boxed_list.dart';
import '../list_item.dart';

class CreditsDialog extends StatelessWidget {
  const CreditsDialog({
    super.key,
    required this.developers,
  });

  final List<String> developers;

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BoxedList(
            children: developers
                .map(
                  (final String developer) => ListItem(title: Text(developer)),
                )
                .toList(),
          ),
          const SizedBox(height: Dimens.padding),
        ],
      ),
    );
  }
}

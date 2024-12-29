import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

class KeypadRow extends StatelessWidget {
  const KeypadRow({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(final BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: Dimens.largePadding,
        children: children,
      ),
    );
  }
}

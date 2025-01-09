import 'package:flutter/widgets.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

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
        spacing: InfinityDimens.largePadding,
        children: children,
      ),
    );
  }
}

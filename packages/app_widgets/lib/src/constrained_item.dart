import 'package:app_constants/app_constants.dart';
import 'package:flutter/material.dart';

class ConstrainedItem extends StatelessWidget {
  const ConstrainedItem({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: Dimens.iphone16ProMaxLandscapeWidth,
        ),
        child: child,
      ),
    );
  }
}

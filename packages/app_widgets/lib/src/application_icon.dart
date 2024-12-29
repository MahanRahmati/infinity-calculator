import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';

import 'squircle.dart';

class ApplicationIcon extends StatelessWidget {
  const ApplicationIcon({
    super.key,
    required this.name,
    this.size,
  });

  final String name;
  final double? size;

  @override
  Widget build(final BuildContext context) {
    return SmoothClipRRect(
      borderRadius: BorderRadius.circular(Dimens.borderRadius),
      child: Image.asset(
        name,
        width: size,
        height: size,
      ),
    );
  }
}

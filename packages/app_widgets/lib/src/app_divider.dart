import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.height,
    this.color,
  });

  final double? height;
  final Color? color;

  @override
  Widget build(final BuildContext context) {
    return Divider(
      height: height,
      thickness: 2,
      color: color,
    );
  }
}

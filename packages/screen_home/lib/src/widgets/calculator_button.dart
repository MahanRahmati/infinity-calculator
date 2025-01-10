import 'package:app_constants/app_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:infinity_widgets/infinity_widgets.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  int _getElavation() {
    if (RegExp(r'[0-9.]').hasMatch(text)) {
      return 2;
    }
    return 1;
  }

  @override
  Widget build(final BuildContext context) {
    final bool isClear = text == 'C';
    final bool isEquals = text == '=';

    final Color? backgroundColor = isClear
        ? InfinityColors.getStatusColor(context, StatusType.error)
            .withTransparency(0.15)
        : isEquals
            ? AppColors.primary
            : null;

    final Color foregroundColor = isClear
        ? InfinityColors.getStatusColor(context, StatusType.error)
        : InfinityColors.getForegroundColor(
            context,
            color: isEquals ? AppColors.primary : null,
          );

    return IButton(
      backgroundColor: backgroundColor,
      elavation: _getElavation(),
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      borderRadius: InfinityDimens.borderRadius,
      child: Text(
        text,
        style: InfinityTypography.title1.copyWith(
          color: foregroundColor,
        ),
      ),
    );
  }
}

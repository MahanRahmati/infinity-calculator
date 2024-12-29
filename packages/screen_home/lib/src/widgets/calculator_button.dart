import 'package:app_constants/app_constants.dart';
import 'package:app_widgets/app_widgets.dart';
import 'package:flutter/widgets.dart';

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
        ? AppColors.getStatusColor(context, StatusType.error)
            .withTransparency(0.15)
        : isEquals
            ? AppColors.primary
            : null;

    final Color foregroundColor = isClear
        ? AppColors.getStatusColor(context, StatusType.error)
        : AppColors.getForegroundColor(
            context,
            brightness:
                isEquals ? AppColors.primary.estimateBrightness() : null,
          );

    return Button(
      backgroundColor: backgroundColor,
      elavation: _getElavation(),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppTypography.title1.copyWith(
          color: foregroundColor,
        ),
      ),
    );
  }
}

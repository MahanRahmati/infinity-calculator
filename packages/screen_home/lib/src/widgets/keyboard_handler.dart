import 'package:app_providers/app_providers.dart';
import 'package:app_utils/app_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class KeyboardHandler extends ConsumerWidget {
  const KeyboardHandler({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(final BuildContext context, final WidgetRef ref) {
    return Focus(
      autofocus: true,
      onKeyEvent: (final FocusNode node, final KeyEvent event) {
        if (event is! KeyDownEvent) {
          return KeyEventResult.skipRemainingHandlers;
        }

        if (event.logicalKey == LogicalKeyboardKey.tab) {
          if (HardwareKeyboard.instance.isShiftPressed) {
            FocusScope.of(context).previousFocus();
          } else {
            FocusScope.of(context).nextFocus();
          }
          return KeyEventResult.handled;
        }

        // Handle only specific calculator keys
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          clearAll(ref);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.numpadEnter) {
          calculateResult(ref);
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.backspace) {
          ref.read(expressionProvider.notifier).removeLast();
          return KeyEventResult.handled;
        }

        final String? character = event.character;
        if (character != null) {
          if (RegExp(r'[0-9]').hasMatch(character)) {
            ref.read(expressionProvider.notifier).add(character);
            return KeyEventResult.handled;
          } else if (<String>['+', '-', '*', '/'].contains(character)) {
            ref.read(expressionProvider.notifier).addOperation(character);
            return KeyEventResult.handled;
          } else if (character == '.') {
            ref.read(expressionProvider.notifier).addDecimal();
            return KeyEventResult.handled;
          }
        }

        // Let other keys pass through to the system
        return KeyEventResult.skipRemainingHandlers;
      },
      child: child,
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

typedef InteractionBuilder = Widget? Function(
  BuildContext context,
  bool enabled,
  bool isHovered,
  bool isFocused,
  bool isHeldDown,
);

class Interaction extends StatefulWidget {
  const Interaction({
    super.key,
    this.focusNode,
    this.onFocusChange,
    this.autofocus = false,
    this.useScale = true,
    this.onPressed,
    this.onLongPress,
    this.builder,
  });

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// Handler called when the focus changes.
  ///
  /// Called with true if this widget's node gains focus, and false if it loses
  /// focus.
  final ValueChanged<bool>? onFocusChange;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// Whether to use scale animation when the widget is pressed.
  final bool useScale;

  /// The callback that is called when the widget is tapped or otherwise
  /// activated.
  ///
  /// If [onPressed] and [onLongPress] callbacks are null, then the widget will
  /// be disabled.
  final VoidCallback? onPressed;

  /// If [onPressed] and [onLongPress] callbacks are null, then the widget will
  /// be disabled.
  final VoidCallback? onLongPress;

  /// The builder that is called to build the widget.
  final InteractionBuilder? builder;

  /// Whether the widget is enabled or disabled. Widgets are disabled by
  /// default. To enable a widget, set [onPressed] or [onLongPress] to a
  /// non-null value.
  bool get enabled => onPressed != null || onLongPress != null;

  @override
  State<Interaction> createState() => _InteractionState();

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      FlagProperty('enabled', value: enabled, ifFalse: 'disabled'),
    );
  }
}

class _InteractionState extends State<Interaction> {
  late bool isFocused;
  late bool isHovered;

  @override
  void initState() {
    super.initState();
    isFocused = false;
    isHovered = false;
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(final TapDownDetails event) {
    if (!_buttonHeldDown) {
      setState(() => _buttonHeldDown = true);
    }
  }

  void _handleTapUp(final TapUpDetails event) {
    if (_buttonHeldDown) {
      setState(() => _buttonHeldDown = false);
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      setState(() => _buttonHeldDown = false);
    }
  }

  void _handleTap([final Intent? _]) {
    if (widget.onPressed != null) {
      widget.onPressed!();
      context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
    }
  }

  void _onShowFocusHighlight(final bool showHighlight) {
    setState(() {
      isFocused = showHighlight;
    });
  }

  void _onShowHoverHighlight(final bool showHighlight) {
    setState(() {
      isHovered = showHighlight;
    });
  }

  late final Map<Type, Action<Intent>> _actionMap = <Type, Action<Intent>>{
    ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: _handleTap),
  };

  @override
  Widget build(final BuildContext context) {
    return MouseRegion(
      cursor: widget.enabled && kIsWeb
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: FocusableActionDetector(
        actions: _actionMap,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        onFocusChange: widget.onFocusChange,
        onShowFocusHighlight: _onShowFocusHighlight,
        onShowHoverHighlight: _onShowHoverHighlight,
        enabled: widget.enabled,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: widget.enabled ? _handleTapDown : null,
          onTapUp: widget.enabled ? _handleTapUp : null,
          onTapCancel: widget.enabled ? _handleTapCancel : null,
          onTap: widget.onPressed,
          onLongPress: widget.onLongPress,
          child: AnimatedScale(
            scale: widget.useScale
                ? _buttonHeldDown
                    ? 0.95
                    : 1.0
                : 1.0,
            duration: const Duration(milliseconds: 100),
            child: widget.builder?.call(
              context,
              widget.enabled,
              isHovered,
              isFocused,
              _buttonHeldDown,
            ),
          ),
        ),
      ),
    );
  }
}

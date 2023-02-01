import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// DefaultScrollbarSymbol
class DefaultScrollbarSymbol extends StatelessWidget {
  /// Constructor of DefaultScrollbarSymbol
  const DefaultScrollbarSymbol({
    super.key,
    required this.symbol,
    required this.state,
    this.styleActive,
    this.styleInactive,
    this.styleDeactivated,
  });

  /// symbol
  final String symbol;

  /// state of item
  final AlphabetScrollbarItemState state;

  /// style if symbol is active
  final TextStyle? styleActive;

  /// style if symbol is inactive
  final TextStyle? styleInactive;

  /// style if symbol is deactivated
  final TextStyle? styleDeactivated;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle;

    switch (state) {
      case AlphabetScrollbarItemState.active:
        textStyle = styleActive ??
            TextStyle(color: Theme.of(context).colorScheme.secondary);
        break;
      case AlphabetScrollbarItemState.inactive:
        textStyle = styleInactive ?? const TextStyle(color: Colors.black);
        break;
      case AlphabetScrollbarItemState.deactivated:
        textStyle = styleDeactivated ?? const TextStyle(color: Colors.grey);
        break;
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        symbol,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('symbol', symbol))
      ..add(EnumProperty<AlphabetScrollbarItemState>('state', state))
      ..add(DiagnosticsProperty<TextStyle?>('styleActive', styleActive))
      ..add(DiagnosticsProperty<TextStyle?>('styleInactive', styleInactive))
      ..add(
        DiagnosticsProperty<TextStyle?>(
          'styleDeactivated',
          styleDeactivated,
        ),
      );
  }
}

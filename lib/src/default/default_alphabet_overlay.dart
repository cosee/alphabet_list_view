import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// DefaultAlphabetOverlay
class DefaultAlphabetOverlay extends StatelessWidget {
  /// Constructor of DefaultAlphabetOverlay
  const DefaultAlphabetOverlay({
    super.key,
    required this.symbol,
    this.style,
    this.decoration,
  });

  /// symbol in scrollbar
  final String symbol;

  /// style of symbol
  final TextStyle? style;

  /// decoration for symbol of scrollbar
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration ??
          BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
          ),
      height: 100,
      width: 100,
      child: FittedBox(
        child: Center(
          child: Text(
            symbol,
            textScaleFactor: 1,
            style: style,
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('symbol', symbol))
      ..add(DiagnosticsProperty<TextStyle?>('style', style))
      ..add(DiagnosticsProperty<BoxDecoration?>('decoration', decoration));
  }
}

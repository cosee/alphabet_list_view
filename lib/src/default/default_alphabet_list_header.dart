import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// DefaultAlphabetListHeader
class DefaultAlphabetListHeader extends StatelessWidget {
  /// Constructor of DefaultAlphabetListHeader
  const DefaultAlphabetListHeader({
    required this.symbol,
    super.key,
    this.backgroundColor,
    this.style,
  });

  /// symbol
  final String symbol;

  /// background color
  final Color? backgroundColor;

  /// text style
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: backgroundColor ?? Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: Text(
            symbol,
            style: style ??
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty<TextStyle?>('style', style));
  }
}

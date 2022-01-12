import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';

class DefaultScrollbarSymbol extends StatelessWidget {
  const DefaultScrollbarSymbol({
    Key? key,
    required this.symbol,
    required this.state,
    this.styleActive,
    this.styleInactive,
    this.styleDeactivated,
  }) : super(key: key);

  final String symbol;
  final AlphabetScrollbarItemState state;
  final TextStyle? styleActive;
  final TextStyle? styleInactive;
  final TextStyle? styleDeactivated;

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle;

    switch (state) {
      case (AlphabetScrollbarItemState.active):
        textStyle = styleActive ??
            TextStyle(color: Theme.of(context).colorScheme.secondary);
        break;
      case (AlphabetScrollbarItemState.inactive):
        textStyle = styleInactive ?? const TextStyle(color: Colors.black);
        break;
      case (AlphabetScrollbarItemState.deactivated):
        textStyle = styleDeactivated ?? const TextStyle(color: Colors.grey);
        break;
      default:
        textStyle = styleActive ?? const TextStyle(color: Colors.black);
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
}

class DefaultAlphabetListHeader extends StatelessWidget {
  const DefaultAlphabetListHeader({
    Key? key,
    required this.symbol,
    this.backgroundColor,
    this.style,
  }) : super(key: key);

  final String symbol;
  final Color? backgroundColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      color: backgroundColor ?? Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
}

class DefaultAlphabetOverlay extends StatelessWidget {
  const DefaultAlphabetOverlay({
    Key? key,
    required this.symbol,
    this.style,
    this.decoration,
  }) : super(key: key);

  final String symbol;
  final TextStyle? style;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.secondary.withOpacity(.8),
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
}

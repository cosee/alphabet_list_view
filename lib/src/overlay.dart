import 'dart:async';

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// ScrollBar Overlay
class AlphabetSymbolOverlay extends StatefulWidget {
  /// Constructor of AlphabetSymbolOverlay
  const AlphabetSymbolOverlay({
    super.key,
    required this.symbolChangeNotifierScrollbar,
    this.alphabetOverlayOptions = const OverlayOptions(),
  });

  /// Overlay options
  final OverlayOptions alphabetOverlayOptions;

  /// ChangeNotifier for ScrollBar
  final SymbolChangeNotifier symbolChangeNotifierScrollbar;

  @override
  State<AlphabetSymbolOverlay> createState() => _AlphabetSymbolOverlayState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<OverlayOptions>(
          'alphabetOverlayOptions',
          alphabetOverlayOptions,
        ),
      )
      ..add(
        DiagnosticsProperty<SymbolChangeNotifier>(
          'symbolChangeNotifierScrollbar',
          symbolChangeNotifierScrollbar,
        ),
      );
  }
}

class _AlphabetSymbolOverlayState extends State<AlphabetSymbolOverlay> {
  String? symbol;
  double opacity = 1;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    widget.symbolChangeNotifierScrollbar.addListener(
      _symbolChangeNotifierScrollbarListener,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Align(
        alignment: widget.alphabetOverlayOptions.alignment,
        child: IgnorePointer(
          child: AnimatedOpacity(
            opacity: symbol == null ? 0 : opacity,
            duration: const Duration(milliseconds: 100),
            child: widget.alphabetOverlayOptions.overlayBuilder
                    ?.call(context, symbol ?? '?') ??
                DefaultAlphabetOverlay(
                  symbol: symbol ?? '?',
                ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    widget.symbolChangeNotifierScrollbar
        .removeListener(_symbolChangeNotifierScrollbarListener);
    super.dispose();
  }

  void _symbolChangeNotifierScrollbarListener() {
    if (widget.alphabetOverlayOptions.showOverlay) {
      final String? tag = widget.symbolChangeNotifierScrollbar.value;
      setState(() {
        symbol = tag;
      });
      _resetOpacityCountdown(
        const Duration(milliseconds: 500),
      );
    }
  }

  void _resetOpacityCountdown(Duration duration) {
    timer?.cancel();
    setState(() {
      opacity = 1.0;
    });
    timer = Timer(duration, () {
      setState(() {
        opacity = 0.0;
      });
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('symbol', symbol))
      ..add(DoubleProperty('opacity', opacity))
      ..add(DiagnosticsProperty<Timer?>('timer', timer));
  }
}

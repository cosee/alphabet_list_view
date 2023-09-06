import 'dart:async';

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// ScrollBar Overlay
class AlphabetSymbolOverlay extends StatefulWidget {
  /// Constructor of AlphabetSymbolOverlay
  const AlphabetSymbolOverlay({
    required this.symbolChangeNotifierScrollbar,
    super.key,
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
  String? _symbol;
  double _opacity = 1;
  Timer? _timer;

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
            opacity: _symbol == null ? 0 : _opacity,
            duration: const Duration(milliseconds: 100),
            child: widget.alphabetOverlayOptions.overlayBuilder
                    ?.call(context, _symbol ?? '?') ??
                DefaultAlphabetOverlay(
                  symbol: _symbol ?? '?',
                ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.symbolChangeNotifierScrollbar
        .removeListener(_symbolChangeNotifierScrollbarListener);
    super.dispose();
  }

  void _symbolChangeNotifierScrollbarListener() {
    if (widget.alphabetOverlayOptions.showOverlay) {
      final String? tag = widget.symbolChangeNotifierScrollbar.value;
      setState(() => _symbol = tag);
      _resetOpacityCountdown(const Duration(milliseconds: 500));
    }
  }

  void _resetOpacityCountdown(Duration duration) {
    _timer?.cancel();
    setState(() => _opacity = 1.0);
    _timer = Timer(duration, () => setState(() => _opacity = 0.0));
  }
}

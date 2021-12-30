import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:alphabet_list_view/src/options.dart';

import 'package:alphabet_list_view/alphabet_list_view.dart';
class AlphabetScrollbar extends StatefulWidget {
  const AlphabetScrollbar({
    Key? key,
    required this.items,
    this.options = const AlphabetListViewOptions(),
    this.indexBarDragNotifier,
    this.controller,
  }) : super(key: key);

  final List<AlphabetListViewItemGroup> items;
  final AlphabetListViewOptions options;
  final AlphabetScrollbarDragNotifier? indexBarDragNotifier;
  final AlphabetScrollbarController? controller;

  @override
  _AlphabetScrollbarState createState() => _AlphabetScrollbarState();
}

class _AlphabetScrollbarState extends State<AlphabetScrollbar> {
  late Map<String, GlobalKey> symbolKeys;

  @override
  void initState() {
    super.initState();
    symbolKeys = {for (var k in widget.options.data) k: GlobalKey()};

    widget.controller?._indexBarState = this;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.options.width,
      child: Listener(
        onPointerMove: (event) {
          String? symbol = _identifyTouchedSymbol(event, symbolKeys);
          if (symbol != null) {
            _onSymbolTriggered(symbol);
          }
        },
        onPointerDown: (event) {
          String? symbol = _identifyTouchedSymbol(event, symbolKeys);
          if (symbol != null) {
            _onSymbolTriggered(symbol);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: widget.options.data
              .map((e) => _IndexBarItem(
                    key: symbolKeys[e],
                    symbol: e,
                    selected: false,
                  ))
              .toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller?._detach();
    super.dispose();
  }

  String? _identifyTouchedSymbol(
    PointerEvent details,
    Map<String, GlobalKey> symbolKeys,
  ) {
    String? touchedSymbol;

    final result = BoxHitTestResult();
    symbolKeys.forEach((symbol, key) {
      try {
        RenderBox renderBox =
            key.currentContext?.findRenderObject() as RenderBox;
        Offset localLocation = renderBox.globalToLocal(details.position);
        if (renderBox.hitTest(result, position: localLocation)) {
          touchedSymbol = symbol;
        }
      } catch (_) {}
    });
    return touchedSymbol;
  }

  void _onSymbolTriggered(String symbol) {
    widget.indexBarDragNotifier?.dragDetails.value = IndexBarDragDetails(
      action: 2,
      index: 2,
      tag: symbol,
      localPositionY: 0,
      globalPositionY: 0,
    );
  }
}

class _IndexBarItem extends StatelessWidget {
  const _IndexBarItem({
    Key? key,
    required this.symbol,
    required this.selected,
  }) : super(key: key);

  final String symbol;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Text(symbol);
  }
}


abstract class IndexBarDragListener {
  /// Creates an [IndexBarDragListener] that can be used by a
  /// [AlphabetScrollbar] to return the drag listener.
  factory IndexBarDragListener.create() => AlphabetScrollbarDragNotifier();

  /// drag details.
  ValueListenable<IndexBarDragDetails> get dragDetails;
}

/// Internal implementation of [ItemPositionsListener].
class AlphabetScrollbarDragNotifier implements IndexBarDragListener {
  @override
  final ValueNotifier<IndexBarDragDetails> dragDetails =
      ValueNotifier(IndexBarDragDetails());
}

class IndexBarDragDetails {
  static const int actionDown = 0;
  static const int actionUp = 1;
  static const int actionUpdate = 2;
  static const int actionEnd = 3;
  static const int actionCancel = 4;

  int? action;
  int? index;
  String? tag;

  double? localPositionY;
  double? globalPositionY;

  IndexBarDragDetails({
    this.action,
    this.index,
    this.tag,
    this.localPositionY,
    this.globalPositionY,
  });
}

class AlphabetScrollbarController {
  _AlphabetScrollbarState? _indexBarState;

  bool get isAttached => _indexBarState != null;

  void _detach() {
    _indexBarState = null;
  }
}

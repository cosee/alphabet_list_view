import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AlphabetScrollbar extends StatefulWidget {
  const AlphabetScrollbar({
    Key? key,
    required this.items,
    required this.symbolChangeNotifierScrollbar,
    required this.symbolChangeNotifierList,
    this.alphabetScrollbarOptions = const AlphabetScrollbarOptions(),
  }) : super(key: key);

  final List<AlphabetListViewItemGroup> items;
  final AlphabetScrollbarOptions alphabetScrollbarOptions;
  final SymbolChangeNotifier symbolChangeNotifierScrollbar;
  final SymbolChangeNotifier symbolChangeNotifierList;

  @override
  _AlphabetScrollbarState createState() => _AlphabetScrollbarState();
}

class _AlphabetScrollbarState extends State<AlphabetScrollbar> {
  late String selectedSymbol;
  late Map<String, GlobalKey> symbolKeys;

  @override
  void initState() {
    super.initState();
    selectedSymbol = widget.items.first.tag;
    symbolKeys = {
      for (var symbol in widget.alphabetScrollbarOptions.symbols)
        symbol: GlobalKey(),
    };
    widget.symbolChangeNotifierList
        .addListener(_symbolChangeNotifierListListener);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      child: Listener(
        onPointerMove: _pointerMoveEventHandler,
        onPointerDown: _pointerMoveEventHandler,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: widget.alphabetScrollbarOptions.symbols
              .map((symbol) => SizedBox(
                    width: double.infinity,
                    key: symbolKeys[symbol],
                    child: _IndexBarItem(
                      symbol: symbol,
                      selected: selectedSymbol == symbol,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.symbolChangeNotifierList
        .removeListener(_symbolChangeNotifierListListener);
    super.dispose();
  }

  void _symbolChangeNotifierListListener() {
    widget.symbolChangeNotifierScrollbar.value = null;
    setState(() {
      selectedSymbol = widget.symbolChangeNotifierList.value ?? selectedSymbol;
    });
  }

  void _pointerMoveEventHandler(PointerEvent event) {
    String? symbol = _identifyTouchedSymbol(event, symbolKeys);
    if (symbol != null) {
      _onSymbolTriggered(symbol);
    }
  }

  String? _identifyTouchedSymbol(
    PointerEvent details,
    Map<String, GlobalKey> symbolKeys,
  ) {
    String? touchedSymbol;

    final result = BoxHitTestResult();
    for (var entry in symbolKeys.entries) {
      try {
        RenderBox renderBox =
            entry.value.currentContext?.findRenderObject() as RenderBox;
        Offset localLocation = renderBox.globalToLocal(details.position);
        if (renderBox.hitTest(result, position: localLocation)) {
          touchedSymbol = entry.key;
          break;
        }
      } catch (_) {}
    }
    return touchedSymbol;
  }

  void _onSymbolTriggered(String symbol) {
    widget.symbolChangeNotifierScrollbar.value = symbol;
    setState(() {
      selectedSymbol = symbol;
    });
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
    return Text(
      symbol,
      style: TextStyle(color: selected ? Colors.red : Colors.black),
    );
  }
}

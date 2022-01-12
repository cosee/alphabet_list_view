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
    this.alphabetScrollbarOptions = const ScrollbarOptions(),
  }) : super(key: key);

  final List<AlphabetListViewItemGroup> items;
  final ScrollbarOptions alphabetScrollbarOptions;
  final SymbolChangeNotifier symbolChangeNotifierScrollbar;
  final SymbolChangeNotifier symbolChangeNotifierList;

  @override
  _AlphabetScrollbarState createState() => _AlphabetScrollbarState();
}

class _AlphabetScrollbarState extends State<AlphabetScrollbar> {
  late String selectedSymbol;
  late Map<String, GlobalKey> symbolKeys;
  late List<String> uniqueItems;

  @override
  void initState() {
    super.initState();
    uniqueItems = widget.alphabetScrollbarOptions.symbols.toSet().toList();
    selectedSymbol = widget.items.isEmpty ? '#' : widget.items.first.tag;
    symbolKeys = {
      for (var symbol in uniqueItems) symbol: GlobalKey(),
    };
    widget.symbolChangeNotifierList
        .addListener(_symbolChangeNotifierListListener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.alphabetScrollbarOptions.backgroundColor,
      width: widget.alphabetScrollbarOptions.width,
      child: Semantics(
        explicitChildNodes: true,
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerMove: _pointerMoveEventHandler,
          onPointerDown: _pointerMoveEventHandler,
          child: Column(
            mainAxisAlignment:
                widget.alphabetScrollbarOptions.mainAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: uniqueItems.map((symbol) {
              return Flexible(
                child: Semantics(
                  button: true,
                  child: Container(
                    color: Colors.transparent,
                    width: widget.alphabetScrollbarOptions.width,
                    key: symbolKeys[symbol],
                    child: widget.alphabetScrollbarOptions.symbolBuilder
                            ?.call(context, symbol, _getSymbolState(symbol)) ??
                        DefaultScrollbarSymbol(
                          symbol: symbol,
                          state: _getSymbolState(symbol),
                        ),
                  ),
                ),
              );
            }).toList(),
          ),
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

  AlphabetScrollbarItemState _getSymbolState(String symbol) {
    final Iterable<AlphabetListViewItemGroup> result =
        widget.items.where((item) => item.tag == symbol);
    if (result.isNotEmpty) {
      if ((result.first.childrenDelegate.estimatedChildCount ?? 0) == 0 &&
          !widget.alphabetScrollbarOptions.jumpToSymbolsWithNoEntries) {
        return AlphabetScrollbarItemState.deactivated;
      } else if (result.first.tag == selectedSymbol) {
        return AlphabetScrollbarItemState.active;
      } else {
        return AlphabetScrollbarItemState.inactive;
      }
    } else {
      return AlphabetScrollbarItemState.deactivated;
    }
  }

  void _symbolChangeNotifierListListener() {
    setState(() {
      selectedSymbol = widget.symbolChangeNotifierList.value ?? selectedSymbol;
    });
  }

  void _pointerMoveEventHandler(PointerEvent event) {
    final String? symbol = _identifyTouchedSymbol(event, symbolKeys);
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
        RenderBox? renderBox =
            entry.value.currentContext?.findRenderObject() as RenderBox?;
        Offset? localLocation = renderBox?.globalToLocal(details.position);

        if (localLocation != null &&
            renderBox != null &&
            renderBox.hitTest(result, position: localLocation)) {
          touchedSymbol = entry.key;
          break;
        }
      } catch (_) {}
    }
    return touchedSymbol;
  }

  void _onSymbolTriggered(String symbol) {
    Iterable<AlphabetListViewItemGroup> result =
        widget.items.where((item) => item.tag == symbol);

    if (!widget.alphabetScrollbarOptions.jumpToSymbolsWithNoEntries) {
      result = result.where(
        (item) => (item.childrenDelegate.estimatedChildCount ?? 0) > 0,
      );
    }

    if (result.isNotEmpty) {
      widget.symbolChangeNotifierScrollbar.value = symbol;
      setState(() {
        selectedSymbol = symbol;
      });
    }
  }
}

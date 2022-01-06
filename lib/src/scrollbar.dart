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
  late List<String> uniqueItems;

  @override
  void initState() {
    super.initState();
    uniqueItems = widget.alphabetScrollbarOptions.symbols.toSet().toList();
    selectedSymbol = widget.items.isEmpty ? '' : widget.items.first.tag;
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
      alignment: Alignment.center,
      child: FittedBox(
        child: SizedBox(
          width: widget.alphabetScrollbarOptions.width,
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerMove: _pointerMoveEventHandler,
            onPointerDown: _pointerMoveEventHandler,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: uniqueItems.map((symbol) {
                return SizedBox(
                  key: symbolKeys[symbol],
                  child: widget.alphabetScrollbarOptions
                          .alphabetScrollbarSymbolBuilder
                          ?.call(context, symbol, _getSymbolState(symbol)) ??
                      _DefaultScrollbarSymbol(
                        symbol: symbol,
                        state: _getSymbolState(symbol),
                      ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  ScrollbarItemState _getSymbolState(String symbol) {
    Iterable<AlphabetListViewItemGroup> result =
        widget.items.where((item) => item.tag == symbol);
    if (result.isNotEmpty) {
      if ((result.first.childrenDelegate.estimatedChildCount ?? 0) == 0 &&
          !widget.alphabetScrollbarOptions.jumpToSymbolsWithNoEntries) {
        return ScrollbarItemState.deactivated;
      } else if (result.first.tag == selectedSymbol) {
        return ScrollbarItemState.active;
      } else {
        return ScrollbarItemState.inactive;
      }
    } else {
      return ScrollbarItemState.deactivated;
    }
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

class _DefaultScrollbarSymbol extends StatelessWidget {
  const _DefaultScrollbarSymbol({
    Key? key,
    required this.symbol,
    required this.state,
  }) : super(key: key);

  final String symbol;
  final ScrollbarItemState state;

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (state) {
      case (ScrollbarItemState.active):
        color = Theme.of(context).colorScheme.secondary;
        break;
      case (ScrollbarItemState.inactive):
        color = Colors.black;
        break;
      case (ScrollbarItemState.deactivated):
        color = Colors.grey;
        break;
      default:
        color = Colors.black;
    }

    return Container(
      color: Colors.transparent,
      width: double.infinity,
      child: Center(
        child: Text(
          symbol,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}

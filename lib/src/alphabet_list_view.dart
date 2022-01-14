import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/controller.dart';
import 'package:alphabet_list_view/src/list.dart';
import 'package:alphabet_list_view/src/overlay.dart';
import 'package:alphabet_list_view/src/scrollbar.dart';
import 'package:flutter/widgets.dart';

/// A ListView with sticky headers and an iOS-like clickable sidebar.
///
/// Add [AlphabetListViewOptions] to make adjustments.
class AlphabetListView extends StatefulWidget {
  const AlphabetListView({
    Key? key,
    required this.items,
    this.options = const AlphabetListViewOptions(),
    this.scrollController,
  }) : super(key: key);

  final Iterable<AlphabetListViewItemGroup> items;
  final AlphabetListViewOptions options;
  final ScrollController? scrollController;

  @override
  _AlphabetListViewState createState() => _AlphabetListViewState();
}

class _AlphabetListViewState extends State<AlphabetListView> {
  late List<AlphabetListViewItemGroup> sortedItems;
  late ScrollController scrollController;

  late SymbolChangeNotifier symbolChangeNotifierScrollbar;
  late SymbolChangeNotifier symbolChangeNotifierList;

  @override
  void initState() {
    super.initState();
    sortedItems = _generateAfterSymbolsSortedList(
      widget.items,
      widget.options.scrollbarOptions.symbols.toSet().toList(),
    );
    scrollController = widget.scrollController ?? ScrollController();
    symbolChangeNotifierScrollbar = SymbolChangeNotifier();
    symbolChangeNotifierList = SymbolChangeNotifier();
  }

  @override
  Widget build(BuildContext context) {
    TextDirection? rowTextDirection;
    if (widget.options.scrollbarOptions.forcePosition ==
        AlphabetScrollbarPosition.left) {
      rowTextDirection = TextDirection.rtl;
    } else if (widget.options.scrollbarOptions.forcePosition ==
        AlphabetScrollbarPosition.right) {
      rowTextDirection = TextDirection.ltr;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      textDirection: rowTextDirection,
      children: [
        Expanded(
          child: Stack(
            children: [
              AlphabetList(
                items: sortedItems,
                scrollController: scrollController,
                alphabetListOptions: widget.options.listOptions,
                symbolChangeNotifierList: symbolChangeNotifierList,
                symbolChangeNotifierScrollbar: symbolChangeNotifierScrollbar,
              ),
              AlphabetSymbolOverlay(
                alphabetOverlayOptions: widget.options.overlayOptions,
                symbolChangeNotifierScrollbar: symbolChangeNotifierScrollbar,
              ),
            ],
          ),
        ),
        AlphabetScrollbar(
          items: sortedItems,
          alphabetScrollbarOptions: widget.options.scrollbarOptions,
          symbolChangeNotifierScrollbar: symbolChangeNotifierScrollbar,
          symbolChangeNotifierList: symbolChangeNotifierList,
        ),
      ],
    );
  }

  @override
  void dispose() {
    symbolChangeNotifierList.dispose();
    symbolChangeNotifierScrollbar.dispose();
    if (widget.scrollController == null) {
      scrollController.dispose();
    }
    super.dispose();
  }

  List<AlphabetListViewItemGroup> _generateAfterSymbolsSortedList(
    Iterable<AlphabetListViewItemGroup> items,
    List<String> symbols,
  ) {
    return [
      for (String symbol in symbols)
        items.firstWhere(
          (item) {
            return item.tag == symbol;
          },
          orElse: () => AlphabetListViewItemGroup(tag: symbol, children: []),
        ),
    ];
  }
}

/// Item groups shown in the list.
class AlphabetListViewItemGroup {
  AlphabetListViewItemGroup({
    required this.tag,
    required Iterable<Widget> children,
  })  : key = GlobalKey(),
        childrenDelegate = SliverChildListDelegate(
          children.toList(),
        );

  AlphabetListViewItemGroup.builder({
    required this.tag,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
  })  : assert(itemCount >= 0),
        key = GlobalKey(),
        childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
        );

  final GlobalKey key;

  /// String to identify this group.
  ///
  /// Must be unique and included in the symbols of the sidebar.
  /// Typically only 1 character e.g. 'A'.
  final String tag;
  final SliverChildDelegate childrenDelegate;
}

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/controller.dart';
import 'package:alphabet_list_view/src/list.dart';
import 'package:alphabet_list_view/src/overlay.dart';
import 'package:alphabet_list_view/src/scrollbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A ListView with sticky headers and an iOS-like clickable sidebar.
///
/// Add [AlphabetListViewOptions] to make adjustments.
class AlphabetListView extends StatefulWidget {
  /// Constructor of AlphabetListView
  const AlphabetListView({
    required this.items,
    super.key,
    this.options = const AlphabetListViewOptions(),
    this.scrollController,
  });

  /// List items
  final Iterable<AlphabetListViewItemGroup> items;

  /// List options
  final AlphabetListViewOptions options;

  /// Optional ScrollController
  final ScrollController? scrollController;

  @override
  State<AlphabetListView> createState() => _AlphabetListViewState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<AlphabetListViewItemGroup>('items', items))
      ..add(DiagnosticsProperty<AlphabetListViewOptions>('options', options))
      ..add(
        DiagnosticsProperty<ScrollController?>(
          'scrollController',
          scrollController,
        ),
      );
  }
}

class _AlphabetListViewState extends State<AlphabetListView> {
  late final ScrollController _scrollController;
  late final SymbolChangeNotifier _symbolChangeNotifierScrollbar;
  late final SymbolChangeNotifier _symbolChangeNotifierList;
  late List<AlphabetListViewItemGroup> _sortedItems;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _symbolChangeNotifierScrollbar = SymbolChangeNotifier();
    _symbolChangeNotifierList = SymbolChangeNotifier();
    _sortedItems = _generateAfterSymbolsSortedList(
      widget.items,
      widget.options.scrollbarOptions.symbols.toSet().toList(),
    );
  }

  @override
  void didUpdateWidget(covariant AlphabetListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sortedItems = _generateAfterSymbolsSortedList(
      widget.items,
      widget.options.scrollbarOptions.symbols.toSet().toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rowTextDirection =
        switch (widget.options.scrollbarOptions.forcePosition) {
      AlphabetScrollbarPosition.left => TextDirection.rtl,
      AlphabetScrollbarPosition.right => TextDirection.ltr,
      _ => null,
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      textDirection: rowTextDirection,
      children: [
        Expanded(
          child: Stack(
            children: [
              AlphabetList(
                items: _sortedItems,
                scrollController: _scrollController,
                alphabetListOptions: widget.options.listOptions,
                symbolChangeNotifierList: _symbolChangeNotifierList,
                symbolChangeNotifierScrollbar: _symbolChangeNotifierScrollbar,
              ),
              AlphabetSymbolOverlay(
                alphabetOverlayOptions: widget.options.overlayOptions,
                symbolChangeNotifierScrollbar: _symbolChangeNotifierScrollbar,
              ),
            ],
          ),
        ),
        AlphabetScrollbar(
          items: _sortedItems,
          alphabetScrollbarOptions: widget.options.scrollbarOptions,
          symbolChangeNotifierScrollbar: _symbolChangeNotifierScrollbar,
          symbolChangeNotifierList: _symbolChangeNotifierList,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _symbolChangeNotifierList.dispose();
    _symbolChangeNotifierScrollbar.dispose();
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  List<AlphabetListViewItemGroup> _generateAfterSymbolsSortedList(
    Iterable<AlphabetListViewItemGroup> items,
    List<String> symbols,
  ) =>
      symbols
          .map(
            (symbol) => items.firstWhere(
              (item) => item.tag == symbol,
              orElse: () => AlphabetListViewItemGroup(tag: symbol),
            ),
          )
          .toList();
}

/// Item groups shown in the list.
class AlphabetListViewItemGroup {
  /// Constructor of AlphabetListViewItemGroup.
  AlphabetListViewItemGroup({
    required this.tag,
    Iterable<Widget> children = const [],
  })  : key = GlobalKey(),
        childrenDelegate = SliverChildListDelegate(
          children.toList(),
        );

  /// Builder constructor of AlphabetListViewItemGroup.
  AlphabetListViewItemGroup.builder({
    required this.tag,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
  })  : assert(itemCount >= 0, 'itemCount must not be smaller than zero!'),
        key = GlobalKey(),
        childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
        );

  /// The key used to indicate the scroll destination.
  final GlobalKey key;

  /// String to identify this group.
  ///
  /// Must be unique and included in the symbols of the sidebar.
  /// Typically only 1 character e.g. 'A'.
  final String tag;

  /// Delegate class for children.
  final SliverChildDelegate childrenDelegate;
}

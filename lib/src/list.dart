import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class AlphabetList extends StatefulWidget {
  const AlphabetList({
    Key? key,
    required this.items,
    required this.scrollController,
    required this.symbolChangeNotifierList,
    required this.symbolChangeNotifierScrollbar,
    this.alphabetListOptions = const ListOptions(),
  }) : super(key: key);
  final List<AlphabetListViewItemGroup> items;
  final ScrollController scrollController;
  final SymbolChangeNotifier symbolChangeNotifierList;
  final SymbolChangeNotifier symbolChangeNotifierScrollbar;
  final ListOptions alphabetListOptions;

  @override
  State<AlphabetList> createState() => _AlphabetListState();
}

class _AlphabetListState extends State<AlphabetList> {
  late GlobalKey customScrollKey;

  @override
  void initState() {
    super.initState();
    customScrollKey = GlobalKey();
    widget.scrollController.addListener(_scrollControllerListener);
    widget.symbolChangeNotifierScrollbar
        .addListener(_symbolChangeNotifierScrollbarListener);
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _scrollControllerListener());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.alphabetListOptions.backgroundColor,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomScrollView(
          key: customScrollKey,
          controller: widget.scrollController,
          physics: widget.alphabetListOptions.physics,
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 0,
              ),
            ),
            ...widget.items.map(
              (item) {
                return SliverStickyHeader(
                  sticky: widget.alphabetListOptions.stickySectionHeader,
                  header: KeyedSubtree(
                    key: item.key,
                    child: Semantics(
                      header: true,
                      child: widget.alphabetListOptions.showSectionHeader &&
                              !(!widget.alphabetListOptions
                                      .showSectionHeaderForEmptySections &&
                                  ((item.childrenDelegate.estimatedChildCount ??
                                          0) ==
                                      0))
                          ? widget.alphabetListOptions.listHeaderBuilder
                                  ?.call(context, item.tag) ??
                              DefaultAlphabetListHeader(
                                symbol: item.tag,
                              )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  sliver: SliverList(
                    delegate: item.childrenDelegate,
                  ),
                );
              },
            ),
            const SliverAppBar(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.symbolChangeNotifierScrollbar
        .removeListener(_symbolChangeNotifierScrollbarListener);
    widget.scrollController.removeListener(_scrollControllerListener);
    super.dispose();
  }

  void _scrollControllerListener() {
    RenderBox? customScrollViewRenderBox;
    try {
      customScrollViewRenderBox =
          customScrollKey.currentContext?.findRenderObject() as RenderBox?;
      if (customScrollViewRenderBox != null) {
        widget.symbolChangeNotifierList.value = _getFirstVisibleItemGroupSymbol(
          customScrollViewRenderBox,
          widget.items,
        );
      }
    } catch (_) {}
  }

  void _symbolChangeNotifierScrollbarListener() {
    final String? tag = widget.symbolChangeNotifierScrollbar.value;
    if (tag != null) {
      _showGroup(tag);
    }
  }

  void _showGroup(String symbol) {
    final RenderObject? renderObject = widget.items
        .firstWhere((element) => element.tag == symbol)
        .key
        .currentContext
        ?.findRenderObject();
    if (renderObject != null) {
      widget.scrollController.position.ensureVisible(renderObject);
    }
  }

  String? _getFirstVisibleItemGroupSymbol(
    RenderBox renderBoxScrollView,
    List<AlphabetListViewItemGroup> items,
  ) {
    String? hit;

    final result = BoxHitTestResult();
    for (final item in items) {
      final RenderBox? renderBoxItem =
          item.key.currentContext?.findRenderObject() as RenderBox?;
      final Offset? localLocationItem = renderBoxItem
          ?.globalToLocal(renderBoxScrollView.localToGlobal(Offset.zero));
      if (localLocationItem != null &&
          renderBoxScrollView.hitTest(result, position: localLocationItem)) {
        hit = item.tag;
      }
    }

    return hit;
  }
}

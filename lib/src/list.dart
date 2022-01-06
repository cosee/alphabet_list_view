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
    this.alphabetListOptions = const AlphabetListOptions(),
  }) : super(key: key);
  final List<AlphabetListViewItemGroup> items;
  final ScrollController scrollController;
  final SymbolChangeNotifier symbolChangeNotifierList;
  final SymbolChangeNotifier symbolChangeNotifierScrollbar;
  final AlphabetListOptions alphabetListOptions;

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
      child: CustomScrollView(
        key: customScrollKey,
        controller: widget.scrollController,
        physics: widget.alphabetListOptions.physics,
        slivers: widget.items
            .where(
              (element) {
                if (widget
                    .alphabetListOptions.showSectionHeaderForEmptySections) {
                  return true;
                } else {
                  return (element.childrenDelegate.estimatedChildCount ?? 0) >
                      0;
                }
              },
            )
            .map(
              (item) {
                return [
                  SliverToBoxAdapter(
                    child: Container(
                      key: item.key,
                    ),
                  ),
                  SliverStickyHeader(
                    sticky: widget.alphabetListOptions.stickySectionHeader,
                    header: widget.alphabetListOptions.showSectionHeader
                        ? widget.alphabetListOptions.alphabetListHeaderBuilder
                                ?.call(context, item.tag) ??
                            _DefaultAlphabetListHeader(
                              symbol: item.tag,
                            )
                        : const SizedBox.shrink(),
                    sliver: SliverList(
                      delegate: item.childrenDelegate,
                    ),
                  ),
                ];
              },
            )
            .expand((slivers) => slivers)
            .toList(),
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
          customScrollKey.currentContext?.findRenderObject() as RenderBox;
      widget.symbolChangeNotifierList.value = _getFirstVisibleItemGroupSymbol(
        customScrollViewRenderBox,
        widget.items,
      );
    } catch (_) {}
  }

  void _symbolChangeNotifierScrollbarListener() {
    final String? tag = widget.symbolChangeNotifierScrollbar.value;
    if (tag != null) {
      _showGroup(tag);
    }
  }

  void _showGroup(String symbol) {
    if (widget.items.where((element) => element.tag == symbol).isNotEmpty) {
      try {
        widget.scrollController.position.ensureVisible(
          (widget.items.firstWhere((element) => element.tag == symbol).key)
              .currentContext!
              .findRenderObject()!,
        );
      } catch (_) {}
    }
  }

  String? _getFirstVisibleItemGroupSymbol(
    RenderBox renderBoxScrollView,
    List<AlphabetListViewItemGroup> items,
  ) {
    String? hit;

    final result = BoxHitTestResult();
    for (var item in items) {
      try {
        RenderBox renderBox =
            item.key.currentContext?.findRenderObject() as RenderBox;

        Offset localLocation = renderBox
            .globalToLocal(renderBoxScrollView.localToGlobal(Offset.zero));

        if (renderBoxScrollView.hitTest(result, position: localLocation)) {
          hit = item.tag;
        }
      } catch (_) {}
    }
    return hit;
  }
}

class _DefaultAlphabetListHeader extends StatelessWidget {
  const _DefaultAlphabetListHeader({Key? key, required this.symbol})
      : super(key: key);

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: Colors.lightBlue,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.centerLeft,
      child: Text(
        symbol,
      ),
    );
  }
}

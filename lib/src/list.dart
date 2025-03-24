import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

/// AlphabetList
class AlphabetList extends StatefulWidget {
  /// Constructor of AlphabetList
  const AlphabetList({
    required this.items,
    required this.scrollController,
    required this.symbolChangeNotifierList,
    required this.symbolChangeNotifierScrollbar,
    super.key,
    this.alphabetListOptions = const ListOptions(),
  });

  /// List of item groups
  final List<AlphabetListViewItemGroup> items;

  /// ScrollController
  final ScrollController scrollController;

  /// ChangeNotifier for symbols
  final SymbolChangeNotifier symbolChangeNotifierList;

  /// ChangeNotifier for scrollbar
  final SymbolChangeNotifier symbolChangeNotifierScrollbar;

  /// options
  final ListOptions alphabetListOptions;

  @override
  State<AlphabetList> createState() => _AlphabetListState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<AlphabetListViewItemGroup>('items', items))
      ..add(
        DiagnosticsProperty<ScrollController>(
          'scrollController',
          scrollController,
        ),
      )
      ..add(
        DiagnosticsProperty<SymbolChangeNotifier>(
          'symbolChangeNotifierList',
          symbolChangeNotifierList,
        ),
      )
      ..add(
        DiagnosticsProperty<SymbolChangeNotifier>(
          'symbolChangeNotifierScrollbar',
          symbolChangeNotifierScrollbar,
        ),
      )
      ..add(
        DiagnosticsProperty<ListOptions>(
          'alphabetListOptions',
          alphabetListOptions,
        ),
      );
  }
}

class _AlphabetListState extends State<AlphabetList> {
  late GlobalKey _customScrollKey;

  @override
  void initState() {
    super.initState();
    _customScrollKey = GlobalKey();
    widget.scrollController.addListener(_scrollControllerListener);
    widget.symbolChangeNotifierScrollbar
        .addListener(_symbolChangeNotifierScrollbarListener);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollControllerListener());
  }

  @override
  void didUpdateWidget(covariant AlphabetList oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollControllerListener(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.alphabetListOptions.padding ?? EdgeInsets.zero,
      color: widget.alphabetListOptions.backgroundColor,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomScrollView(
          key: _customScrollKey,
          controller: widget.scrollController,
          physics: widget.alphabetListOptions.physics,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: widget.alphabetListOptions.topOffset,
              ),
            ),
            SliverToBoxAdapter(
              child: widget.alphabetListOptions.beforeList,
            ),
            ...widget.items.map(
              (item) {
                final bool useHeaderForEmptySection = widget.alphabetListOptions
                        .showSectionHeaderForEmptySections ||
                    !((item.childrenDelegate.estimatedChildCount ?? 0) == 0);
                final Widget header =
                    widget.alphabetListOptions.showSectionHeader &&
                            useHeaderForEmptySection
                        ? Semantics(
                            header: true,
                            child: widget.alphabetListOptions.listHeaderBuilder
                                    ?.call(context, item.tag) ??
                                DefaultAlphabetListHeader(
                                  symbol: item.tag,
                                ),
                          )
                        : const SizedBox.shrink();

                return SliverStickyHeader(
                  header: Container(key: item.key),
                  sliver: SliverStickyHeader(
                    header: Container(child: header),
                    sliver: SliverList(delegate: item.childrenDelegate),
                    sticky: widget.alphabetListOptions.stickySectionHeader,
                  ),
                );
              },
            ),
            SliverToBoxAdapter(child: widget.alphabetListOptions.afterList),
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
    try {
      final customScrollViewRenderBox =
          _customScrollKey.currentContext?.findRenderObject() as RenderBox?;
      if (customScrollViewRenderBox != null &&
          customScrollViewRenderBox.hasSize) {
        widget.symbolChangeNotifierList.value = _getFirstVisibleItemGroupSymbol(
          customScrollViewRenderBox,
          widget.items,
        );
      }
    } on Exception catch (_) {}
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
      _jumpTo(renderObject);
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
      final Offset? localLocationItem = renderBoxItem?.globalToLocal(
        renderBoxScrollView.localToGlobal(
          Offset(0, widget.alphabetListOptions.topOffset ?? 0),
        ),
      );
      if (localLocationItem != null &&
          renderBoxScrollView.hitTest(result, position: localLocationItem)) {
        hit = item.tag;
      }
    }

    return hit;
  }

  void _jumpTo(RenderObject object) {
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(object);

    final target = viewport.getOffsetToReveal(object, 0).offset.clamp(
          widget.alphabetListOptions.topOffset ?? 0,
          widget.scrollController.position.maxScrollExtent +
              (widget.alphabetListOptions.topOffset ?? 0),
        );
    widget.scrollController.jumpTo(
      target - (widget.alphabetListOptions.topOffset ?? 0),
    );
  }
}

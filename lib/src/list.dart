import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/options.dart';
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
  final ValueNotifier<String?> symbolChangeNotifierList;
  final ValueNotifier<String?> symbolChangeNotifierScrollbar;
  final AlphabetListOptions alphabetListOptions;

  @override
  State<AlphabetList> createState() => _AlphabetListState();
}

class _AlphabetListState extends State<AlphabetList> {
  GlobalKey customScrollKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      RenderBox? customScrollViewRenderBox;
      try {
        customScrollViewRenderBox =
            customScrollKey.currentContext?.findRenderObject() as RenderBox;
        widget.symbolChangeNotifierList.value = _getFirstVisibleItemGroupSymbol(
            customScrollViewRenderBox, widget.items,);
      } catch (_) {}
    });
    widget.symbolChangeNotifierScrollbar.addListener(
      () {
        final String? tag = widget.symbolChangeNotifierScrollbar.value;
        if (tag != null) {
          _showGroup(tag);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: customScrollKey,
      controller: widget.scrollController,
      slivers: widget.items
          .map(
            (item) {
              return [
                SliverToBoxAdapter(
                  child: Container(
                    key: item.key,
                  ),
                ),
                SliverStickyHeader(
                  sticky: false,
                  header: Container(
                    height: 60.0,
                    color: Colors.lightBlue,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.tag,
                    ),
                  ),
                  sliver: SliverList(
                    delegate: item.childrenDelegate,
                  ),
                ),
              ];
            },
          )
          .expand((slivers) => slivers)
          .toList(),
    );
  }

  void _showGroup(String symbol) {
    if (widget.items.where((element) => element.tag == symbol).isNotEmpty) {
      widget.scrollController.position.ensureVisible(
        (widget.items.firstWhere((element) => element.tag == symbol).key)
            .currentContext!
            .findRenderObject()!,
      );
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

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  SectionHeaderDelegate(this.title, [this.height = 50]);

  final String title;
  final double height;

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      alignment: Alignment.center,
      child: Text(title),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

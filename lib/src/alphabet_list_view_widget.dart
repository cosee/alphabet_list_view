import 'package:alphabet_list_view/src/options.dart';
import 'package:alphabet_list_view/src/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AlphabetListView extends StatefulWidget {
  const AlphabetListView({
    Key? key,
    required this.items,
    this.alphabetListViewOptions = const AlphabetListViewOptions(),
    this.itemScrollController,
    this.itemPositionsListener,
  }) : super(key: key);

  final List<AlphabetListViewItemGroup> items;
  final ScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;
  final AlphabetListViewOptions alphabetListViewOptions;

  @override
  _AlphabetListViewState createState() => _AlphabetListViewState();
}

class _AlphabetListViewState extends State<AlphabetListView> {
  late AlphabetListViewOptions alphabetListViewOptions;
  late ScrollController itemScrollController;
  late ItemPositionsListener itemPositionsListener;
  String? lastTriggeredSymbol;

  IndexBarDragListener dragListener = IndexBarDragListener.create();
  final AlphabetScrollbarController indexBarController =
      AlphabetScrollbarController();

  String selectTag = '';

  @override
  void initState() {
    super.initState();
    alphabetListViewOptions = widget.alphabetListViewOptions;
    itemScrollController = widget.itemScrollController ?? ScrollController();
    itemPositionsListener =
        widget.itemPositionsListener ?? ItemPositionsListener.create();
    dragListener.dragDetails.addListener(_valueChanged);
    itemPositionsListener.itemPositions.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blue,
      child: Row(
        children: [
          Expanded(
            child: widget.items.isEmpty
                ? Container()
                : ColoredBox(
                    color: Colors.green,
                    child: CustomScrollView(
                      controller: itemScrollController,
                      slivers: [
                        // SliverPersistentHeader(
                        //   pinned: true,
                        //   delegate: SectionHeaderDelegate("A"),
                        // ),
                        ...widget.items
                            .map(
                              (e) {
                                return [
                                  SliverPersistentHeader(
                                    key: e.key,
                                    delegate: SectionHeaderDelegate(e.tag),
                                  ),
                                  SliverList(
                                    delegate: SliverChildListDelegate(e.items),
                                  ),
                                ];
                              },
                            )
                            .expand((element) => element)
                            .toList(),
                        // SliverPersistentHeader(
                        //   pinned: true, delegate: SectionHeaderDelegate("B"),
                        // ),
                        // SliverToBoxAdapter(
                        //   child: Container(
                        //     height: 500,
                        //   ),
                        // ),
                        // const SliverAppBar(
                        //   title: Text("HI"),
                        //   pinned: true,
                        // ),
                        // SliverToBoxAdapter(
                        //   child: Container(
                        //     height: 500,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
          ),
          AlphabetScrollbar(
            items: widget.items,
            options: widget.alphabetListViewOptions,
            indexBarDragNotifier: dragListener as AlphabetScrollbarDragNotifier,
            controller: indexBarController,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    dragListener.dragDetails.removeListener(_valueChanged);
    super.dispose();
  }

  void _valueChanged() {
    final IndexBarDragDetails details = dragListener.dragDetails.value;
    final String tag = details.tag!;
    if (details.action == IndexBarDragDetails.actionDown ||
        details.action == IndexBarDragDetails.actionUpdate) {
      selectTag = tag;

      if (widget.items.where((element) => element.tag == tag).isNotEmpty) {
        lastTriggeredSymbol = tag;
        itemScrollController.position.ensureVisible(
          (widget.items.firstWhere((element) => element.tag == tag).key
                  as GlobalKey)
              .currentContext!
              .findRenderObject()!,
        );
      }
    }

    void _positionsChanged() {
      final Iterable<ItemPosition> positions =
          itemPositionsListener.itemPositions.value;
      if (positions.isNotEmpty) {
        final ItemPosition itemPosition = positions
            .where((ItemPosition position) => position.itemTrailingEdge > 0)
            .reduce(
              (ItemPosition min, ItemPosition position) =>
                  position.itemTrailingEdge < min.itemTrailingEdge
                      ? position
                      : min,
            );
        final int index = itemPosition.index;
        final String tag = widget.items[index].getSuspensionTag();
        if (selectTag != tag) {
          selectTag = tag;
          setState(() {});
        }
      }
    }
  }
}

class AlphabetListViewItemGroup extends StatelessWidget {
  const AlphabetListViewItemGroup({
    required Key key,
    required this.tag,
    required this.items,
  }) : super(key: key);

  final String tag;

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(tag), ...items],
    );
  }

  String getSuspensionTag() => tag;
}

class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final double height;

  SectionHeaderDelegate(this.title, [this.height = 50]);

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).primaryColor,
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

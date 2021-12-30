import 'package:alphabet_list_view/src/options.dart';
import 'package:alphabet_list_view/src/scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AlphabetListView extends StatefulWidget {
  const AlphabetListView({
    Key? key,
    required this.items,
    this.itemScrollController,
    this.itemPositionsListener,
    this.alphabetListViewOptions = const AlphabetListViewOptions(),
  }) : super(key: key);

  final List<AlphabetListViewItemGroup> items;
  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;
  final AlphabetListViewOptions alphabetListViewOptions;

  @override
  _AlphabetListViewState createState() => _AlphabetListViewState();
}

class _AlphabetListViewState extends State<AlphabetListView> {
  late AlphabetListViewOptions alphabetListViewOptions;
  late ItemScrollController itemScrollController;
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
    itemScrollController =
        widget.itemScrollController ?? ItemScrollController();
    itemPositionsListener =
        widget.itemPositionsListener ?? ItemPositionsListener.create();
    dragListener.dragDetails.addListener(_valueChanged);
    itemPositionsListener.itemPositions.addListener(_positionsChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: widget.items.isEmpty
              ? Container()
              : ScrollablePositionedList.builder(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(widget.items[index].tag),
                        ...widget.items[index].items,
                      ],
                    );
                  },
                  addRepaintBoundaries: false,
                ),
        ),
        AlphabetScrollbar(
          items: widget.items,
          options: widget.alphabetListViewOptions,
          indexBarDragNotifier: dragListener as AlphabetScrollbarDragNotifier,
          controller: indexBarController,
        ),
      ],
    );
  }

  @override
  void dispose() {
    dragListener.dragDetails.removeListener(_valueChanged);
    itemPositionsListener.itemPositions.removeListener(_positionsChanged);
    super.dispose();
  }


  void _valueChanged() {
    final IndexBarDragDetails details = dragListener.dragDetails.value;
    final String tag = details.tag!;
    if (details.action == IndexBarDragDetails.actionDown ||
        details.action == IndexBarDragDetails.actionUpdate) {
      selectTag = tag;

      if (widget.items.where((element) => element.tag == tag).isNotEmpty) {
        if (tag != lastTriggeredSymbol) {
          lastTriggeredSymbol = tag;
          itemScrollController.jumpTo(index: widget.alphabetListViewOptions.data.indexOf(tag));

        }
      }
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

class AlphabetListViewItemGroup {
  const AlphabetListViewItemGroup({required this.tag, required this.items});

  final String tag;

  final List<Widget> items;

  String getSuspensionTag() => tag;
}

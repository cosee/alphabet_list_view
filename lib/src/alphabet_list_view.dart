import 'package:alphabet_list_view/src/list.dart';
import 'package:alphabet_list_view/src/options.dart';
import 'package:alphabet_list_view/src/scrollbar.dart';
import 'package:flutter/material.dart';

class AlphabetListView extends StatefulWidget {
  const AlphabetListView({
    Key? key,
    required this.items,
    this.alphabetListViewOptions = const AlphabetListViewOptions(),
    this.itemScrollController,
  }) : super(key: key);

  final List<AlphabetListViewItemGroup> items;
  final AlphabetListViewOptions alphabetListViewOptions;
  final ScrollController? itemScrollController;

  @override
  _AlphabetListViewState createState() => _AlphabetListViewState();
}

class _AlphabetListViewState extends State<AlphabetListView> {
  late ScrollController itemScrollController;
  IndexBarDragListener dragListener = IndexBarDragListener.create();
  final AlphabetScrollbarController indexBarController =
      AlphabetScrollbarController();

  @override
  void initState() {
    super.initState();
    itemScrollController = widget.itemScrollController ?? ScrollController();
    dragListener.dragDetails.addListener(_valueChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AlphabetList(
            items: widget.items,
            itemScrollController: itemScrollController,
          ),
        ),
        AlphabetScrollbar(
          items: widget.items,
          alphabetScrollbarOptions:
              widget.alphabetListViewOptions.alphabetScrollbarOptions,
          indexBarDragNotifier: dragListener as AlphabetScrollbarDragNotifier,
          controller: indexBarController,
        ),
      ],
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
      if (widget.items.where((element) => element.tag == tag).isNotEmpty) {
        itemScrollController.position.ensureVisible(
          (widget.items.firstWhere((element) => element.tag == tag).key)
              .currentContext!
              .findRenderObject()!,
        );
      }
    }
  }
}

class AlphabetListViewItemGroup {
  AlphabetListViewItemGroup({
    required this.key,
    required this.tag,
    required List<Widget> children,
  }) : childrenDelegate = SliverChildListDelegate(
          children,
        );

  AlphabetListViewItemGroup.builder({
    required this.key,
    required this.tag,
    required int itemCount,
    required IndexedWidgetBuilder itemBuilder,
  })  : assert(itemCount >= 0),
        childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
        );

  final GlobalKey key;
  final String tag;
  final SliverChildDelegate childrenDelegate;
}

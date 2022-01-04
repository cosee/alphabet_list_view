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
  final ScrollController? itemScrollController;
  final AlphabetListViewOptions alphabetListViewOptions;

  @override
  _AlphabetListViewState createState() => _AlphabetListViewState();
}

class _AlphabetListViewState extends State<AlphabetListView> {
  late AlphabetListViewOptions alphabetListViewOptions;
  late ScrollController itemScrollController;
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
    dragListener.dragDetails.addListener(_valueChanged);
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blue,
      child: Row(
        children: [
          Expanded(
            child: ColoredBox(
              color: Colors.green,
              child: CustomScrollView(
                controller: itemScrollController,
                slivers: widget.items
                    .map(
                      (e) {
                        return [
                          SliverToBoxAdapter(
                            child: Container(
                              key: e.key,
                            ),
                          ),
                          SliverPersistentHeader(
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
              ),
            ),
          ),
          AlphabetScrollbar(
            items: widget.items,
            alphabetScrollbarOptions: widget.alphabetListViewOptions.alphabetScrollbarOptions,
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



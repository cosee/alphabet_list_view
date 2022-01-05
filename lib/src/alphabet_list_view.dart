import 'package:alphabet_list_view/src/list.dart';
import 'package:alphabet_list_view/src/options.dart';
import 'package:alphabet_list_view/src/scrollbar.dart';
import 'package:flutter/material.dart';

import 'controller.dart';

class AlphabetListView extends StatefulWidget {
  const AlphabetListView({
    Key? key,
    required this.items,
    this.alphabetListViewOptions = const AlphabetListViewOptions(),
    this.scrollController,
  }) : super(key: key);

  final List<AlphabetListViewItemGroup> items;
  final AlphabetListViewOptions alphabetListViewOptions;
  final ScrollController? scrollController;

  @override
  _AlphabetListViewState createState() => _AlphabetListViewState();
}

class _AlphabetListViewState extends State<AlphabetListView> {
  late ScrollController scrollController;
  SymbolChangeNotifier symbolChangeNotifierScrollbar = SymbolChangeNotifier(null);
  SymbolChangeNotifier symbolChangeNotifierList = SymbolChangeNotifier(null);

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AlphabetList(
            items: widget.items,
            scrollController: scrollController,
            symbolChangeNotifierList: symbolChangeNotifierList,
            symbolChangeNotifierScrollbar: symbolChangeNotifierScrollbar,
          ),
        ),
        AlphabetScrollbar(
          items: widget.items,
          alphabetScrollbarOptions:
              widget.alphabetListViewOptions.alphabetScrollbarOptions,
          symbolChangeNotifierScrollbar: symbolChangeNotifierScrollbar,
          symbolChangeNotifierList: symbolChangeNotifierList,
        ),
      ],
    );
  }
}

class AlphabetListViewItemGroup {
  AlphabetListViewItemGroup({
    required this.tag,
    required List<Widget> children,
  })  : key = GlobalKey(),
        childrenDelegate = SliverChildListDelegate(
          children,
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
  final String tag;
  final SliverChildDelegate childrenDelegate;
}

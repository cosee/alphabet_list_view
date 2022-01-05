import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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
      RenderBox? box;

      box = customScrollKey.currentContext?.findRenderObject() as RenderBox;

      widget.symbolChangeNotifierList.value =
          _getFirstSymbol(box, widget.items);
    });
    widget.symbolChangeNotifierScrollbar.addListener(
      () {
        final String? tag = widget.symbolChangeNotifierScrollbar.value;
        if (tag != null) {
          _showValue(tag);
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
          .expand((element) => element)
          .toList(),
    );
  }

  void _showValue(String tag) {
    if (widget.items.where((element) => element.tag == tag).isNotEmpty) {
      widget.scrollController.position.ensureVisible(
        (widget.items.firstWhere((element) => element.tag == tag).key)
            .currentContext!
            .findRenderObject()!,
      );
    }
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

String? _getFirstSymbol(
  RenderBox r,
  List<AlphabetListViewItemGroup> items,
) {
  String? touchedSymbol;

  final result = BoxHitTestResult();
  for (var item in items) {
    RenderBox renderBox =
        item.key.currentContext?.findRenderObject() as RenderBox;

    Offset localLocation =
        renderBox.globalToLocal(r.localToGlobal(Offset.zero));

    if (r.hitTest(result, position: localLocation)) {
      touchedSymbol = item.tag;
    }
  }
  return touchedSymbol;
}

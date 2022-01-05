import 'package:flutter/cupertino.dart';

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/options.dart';

class AlphabetList extends StatelessWidget {
  const AlphabetList(
      {Key? key,
        required this.items,
        required this.itemScrollController,
        this.alphabetListOptions = const AlphabetListOptions(),
      })
      : super(key: key);
  final List<AlphabetListViewItemGroup> items;
  final ScrollController itemScrollController;
  final AlphabetListOptions alphabetListOptions;

  @override
  Widget build(BuildContext context) {
    ListView;
    return CustomScrollView(
      controller: itemScrollController,
      slivers: items
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
              delegate: e.childrenDelegate,
            ),
          ];
        },
      )
          .expand((element) => element)
          .toList(),
    );
  }
}


class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final double height;

  SectionHeaderDelegate(this.title, [this.height = 50]);

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

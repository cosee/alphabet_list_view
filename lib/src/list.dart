import 'package:flutter/cupertino.dart';

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/options.dart';

class AlphabetList extends StatelessWidget {
  const AlphabetList(
      {Key? key,
        required this.items,
        this.itemScrollController,
        this.alphabetListOptions = const AlphabetListOptions(),
      })
      : super(key: key);
  final List<AlphabetListViewItemGroup> items;
  final ScrollController? itemScrollController;
  final AlphabetListOptions alphabetListOptions;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
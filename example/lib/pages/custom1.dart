import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/items.dart' as items;
import 'package:flutter/material.dart';

class ExampleCustom1 extends StatelessWidget {
  const ExampleCustom1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlphabetListView(
      items: items.apples,
      alphabetListViewOptions: const AlphabetListViewOptions(
        alphabetOverlayOptions: AlphabetOverlayOptions(
          alignment: Alignment.centerLeft,
        ),
      ),
    );
  }
}

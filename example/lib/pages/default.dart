import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/items.dart' as items;
import 'package:flutter/material.dart';

class ExampleDefault extends StatelessWidget {
  const ExampleDefault({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlphabetListView(
      items: items.apples,
    );
  }
}

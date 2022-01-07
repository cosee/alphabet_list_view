import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/items.dart' as items;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExampleRTL extends StatelessWidget {
  const ExampleRTL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
      child: AlphabetListView(
        items: items.apples,
      ),
    );
  }
}

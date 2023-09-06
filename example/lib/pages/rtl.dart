import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExampleRTL extends StatelessWidget {
  const ExampleRTL({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlphabetListView(
        items: _animals,
      ),
    );
  }

  List<AlphabetListViewItemGroup> get _animals => Repository.animals.entries
      .map(
        (animalLetter) => AlphabetListViewItemGroup(
          tag: animalLetter.key,
          children: animalLetter.value.map(Text.new),
        ),
      )
      .toList();
}

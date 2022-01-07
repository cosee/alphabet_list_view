import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart' as repo;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExampleRTL extends StatelessWidget {
  ExampleRTL({Key? key}) : super(key: key);
  final List<AlphabetListViewItemGroup> apples = [
    for (var animalLetter in repo.animals.entries)
      AlphabetListViewItemGroup(
        tag: animalLetter.key,
        children: animalLetter.value.map((animal) => Text(animal)).toList(),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlphabetListView(
        items: apples,
      ),
    );
  }
}

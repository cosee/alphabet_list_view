import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExampleRTL extends StatelessWidget {
  ExampleRTL({super.key});
  final List<AlphabetListViewItemGroup> animals = [
    for (var animalLetter in Repository.animals.entries)
      AlphabetListViewItemGroup(
        tag: animalLetter.key,
        children: animalLetter.value.map(Text.new).toList(),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlphabetListView(
        items: animals,
      ),
    );
  }
}

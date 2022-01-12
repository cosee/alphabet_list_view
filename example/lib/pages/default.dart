import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart' as repo;
import 'package:flutter/material.dart';

class ExampleDefault extends StatelessWidget {
  ExampleDefault({Key? key}) : super(key: key);

  final List<AlphabetListViewItemGroup> animals = [
    for (var animalLetter in repo.animals.entries)
      AlphabetListViewItemGroup(
        tag: animalLetter.key,
        children: animalLetter.value.map((animal) => Text(animal)).toList(),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return AlphabetListView(
      items: animals,
      alphabetListViewOptions: AlphabetListViewOptions(
        overlayOptions: OverlayOptions(
          overlayBuilder: (context, symbol) => DefaultAlphabetOverlay(
            symbol: symbol,
            decoration: const BoxDecoration(color: Colors.black),
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        listOptions: ListOptions(
          listHeaderBuilder: (context, symbol) => DefaultAlphabetListHeader(
            symbol: symbol,
            backgroundColor: Colors.red,
            style: const TextStyle(
              color: Colors.yellow,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart' as repo;
import 'package:flutter/material.dart';

class ExampleCustom3 extends StatelessWidget {
  ExampleCustom3({Key? key}) : super(key: key);

  final List<AlphabetListViewItemGroup> animals = [
    for (var animalLetter in repo.animals.entries)
      AlphabetListViewItemGroup(
        tag: animalLetter.key,
        children: animalLetter.value.map((animal) => Text(animal)).toList(),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(200, 255, 200, 0.5),
      ),
      body: AlphabetListView(
        items: animals,
        alphabetListViewOptions: AlphabetListViewOptions(
          listOptions: ListOptions(
            stickySectionHeader: false,
            //topOffset: a.preferredSize.height,
            beforeList: Container(
              color: Colors.blue,
              height: 200,
              width: 200,
            ),
            afterList: Container(
              color: Colors.yellow,
              height: 200,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}

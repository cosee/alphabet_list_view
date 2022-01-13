import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart' as repo;
import 'package:flutter/material.dart';

class TestText extends StatefulWidget {
  const TestText(this.text, {Key? key}) : super(key: key);
  final String text;

  @override
  _TestTextState createState() => _TestTextState();
}

class _TestTextState extends State<TestText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text);
  }

  @override
  void initState() {
    super.initState();
    print("INIT");
  }

  @override
  void dispose() {
    print("DISPOSE");
    super.dispose();
  }
}

class ExampleCustom3 extends StatelessWidget {
  ExampleCustom3({Key? key}) : super(key: key);

  final List<AlphabetListViewItemGroup> animals = [
    for (var animalLetter in repo.animals.entries)
      AlphabetListViewItemGroup(
        tag: animalLetter.key,
        children: animalLetter.value.map((animal) => TestText(animal)).toList(),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(
          200,
          255,
          200,
          0.5,
        ),
        toolbarHeight: 100,
      ),
      body: AlphabetListView(
        items: animals,
        alphabetListViewOptions: const AlphabetListViewOptions(
          listOptions: ListOptions(
            stickySectionHeader: false,
            topOffset: 100,
          ),
        ),
      ),
    );
  }
}

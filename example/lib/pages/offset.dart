import 'dart:ui';

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart' as repo;
import 'package:flutter/material.dart';

class ExampleOffset extends StatelessWidget {
  ExampleOffset({Key? key}) : super(key: key);

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: const Blur(),
        backgroundColor: Colors.transparent,
        elevation: .0,
      ),
      body: Builder(builder: (context) {
        return AlphabetListView(
          items: animals,
          options: AlphabetListViewOptions(
            listOptions: ListOptions(
              stickySectionHeader: false,
              topOffset: MediaQuery.of(context).padding.top,
              listHeaderBuilder: (context, symbol) => DefaultAlphabetListHeader(
                symbol: symbol,
                backgroundColor: Colors.transparent,
              ),
            ),
            scrollbarOptions: ScrollbarOptions(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class Blur extends StatelessWidget {
  const Blur({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ClipRect(
            child: Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(.3),
              height: double.infinity,
              width: double.infinity,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  tileMode: TileMode.clamp,
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: const Center(
                  child: Text(
                    'Offset',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 1.0,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}

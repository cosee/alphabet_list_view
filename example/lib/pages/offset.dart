import 'dart:ui';

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart';
import 'package:flutter/material.dart';

class ExampleOffset extends StatelessWidget {
  ExampleOffset({super.key});

  final List<AlphabetListViewItemGroup> animals = [
    for (var animalLetter in Repository.animals.entries)
      AlphabetListViewItemGroup(
        tag: animalLetter.key,
        children: animalLetter.value.map(Text.new).toList(),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: const _Blur(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Builder(
        builder: (context) {
          return AlphabetListView(
            items: animals,
            options: AlphabetListViewOptions(
              listOptions: ListOptions(
                stickySectionHeader: false,
                topOffset: MediaQuery.of(context).padding.top,
                listHeaderBuilder: (context, symbol) =>
                    DefaultAlphabetListHeader(
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
        },
      ),
    );
  }
}

class _Blur extends StatelessWidget {
  const _Blur();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ClipRect(
            child: Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              height: double.infinity,
              width: double.infinity,
              child: BackdropFilter(
                filter: ImageFilter.blur(
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
          height: 1,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}

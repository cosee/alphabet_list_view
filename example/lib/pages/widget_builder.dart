import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart';
import 'package:flutter/material.dart';

class ExampleWidgetBuilder extends StatelessWidget {
  const ExampleWidgetBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return AlphabetListView(
      items: _animals,
      options: AlphabetListViewOptions(
        overlayOptions: OverlayOptions(
          alignment: Alignment.centerRight,
          overlayBuilder: (context, symbol) {
            return Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(100),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: FittedBox(
                  child: Text(
                    symbol,
                    textScaler: TextScaler.noScaling,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        scrollbarOptions: ScrollbarOptions(
          jumpToSymbolsWithNoEntries: true,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          symbolBuilder: (context, symbol, state) {
            final color = switch (state) {
              AlphabetScrollbarItemState.active => Colors.black,
              AlphabetScrollbarItemState.deactivated => Colors.lightGreen,
              _ => Theme.of(context).colorScheme.primary,
            };

            return Container(
              padding: const EdgeInsets.only(left: 4, top: 2, bottom: 2),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(100),
                ),
                color: state == AlphabetScrollbarItemState.active
                    ? Colors.lightGreen
                    : null,
              ),
              child: Center(
                child: FittedBox(
                  child: Text(
                    symbol,
                    style: TextStyle(color: color, fontSize: 20),
                  ),
                ),
              ),
            );
          },
        ),
        listOptions: ListOptions(
          backgroundColor: const Color.fromRGBO(210, 255, 210, 1),
          stickySectionHeader: false,
          showSectionHeaderForEmptySections: true,
          listHeaderBuilder: (context, symbol) => Padding(
            padding: const EdgeInsets.only(right: 18, top: 4, bottom: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(100),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 8,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Text(
                    symbol,
                    textScaler: TextScaler.noScaling,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<AlphabetListViewItemGroup> get _animals => Repository.animals.entries
      .map(
        (animalLetter) => AlphabetListViewItemGroup(
          tag: animalLetter.key,
          children: animalLetter.value.map(
            (animal) => Padding(
              padding: const EdgeInsets.all(8),
              child: Text(animal),
            ),
          ),
        ),
      )
      .toList();
}

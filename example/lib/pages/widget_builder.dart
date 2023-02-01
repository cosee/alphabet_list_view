import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart';
import 'package:flutter/material.dart';

class ExampleWidgetBuilder extends StatelessWidget {
  ExampleWidgetBuilder({super.key});

  final List<AlphabetListViewItemGroup> animals = [
    for (var animalLetter in Repository.animals.entries)
      AlphabetListViewItemGroup(
        tag: animalLetter.key,
        children: animalLetter.value
            .map(
              (animal) => Padding(
                padding: const EdgeInsets.all(8),
                child: Text(animal),
              ),
            )
            .toList(),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return AlphabetListView(
      items: animals,
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
                    textScaleFactor: 1,
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
            Color color;
            if (state == AlphabetScrollbarItemState.active) {
              color = Colors.black;
            } else if (state == AlphabetScrollbarItemState.deactivated) {
              color = Colors.lightGreen;
            } else {
              color = Theme.of(context).colorScheme.primary;
            }
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
          listHeaderBuilder: (context, symbol) {
            return Padding(
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
                      textScaleFactor: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

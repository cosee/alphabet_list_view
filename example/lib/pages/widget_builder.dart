import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart' as repo;
import 'package:flutter/material.dart';

class ExampleWidgetBuilder extends StatelessWidget {
  ExampleWidgetBuilder({Key? key}) : super(key: key);
  final List<AlphabetListViewItemGroup> animals = [
    for (var animalLetter in repo.animals.entries)
      AlphabetListViewItemGroup(
        tag: animalLetter.key,
        children: animalLetter.value
            .map((animal) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(animal),
                ))
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
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(100.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: FittedBox(
                  child: Text(
                    symbol,
                    textScaleFactor: 1.0,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        scrollbarOptions: ScrollbarOptions(
          jumpToSymbolsWithNoEntries: true,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          symbolBuilder: (context, symbol, state) {
            Color color;
            if (state == AlphabetScrollbarItemState.active) {
              color = Colors.black;
            } else if (state == AlphabetScrollbarItemState.deactivated) {
              color = Colors.lightGreen;
            } else {
              color = Colors.white;
            }
            return Padding(
              padding: const EdgeInsets.only(left: 4.0, top: 2.0, bottom: 2.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(100.0),
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
              ),
            );
          },
        ),
        listOptions: ListOptions(
          backgroundColor: const Color.fromRGBO(210, 255, 210, 1.0),
          stickySectionHeader: false,
          showSectionHeaderForEmptySections: true,
          listHeaderBuilder: (context, symbol) {
            return Padding(
              padding:
                  const EdgeInsets.only(right: 18.0, top: 4.0, bottom: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(100.0),
                    ),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 8.0,
                      right: 16.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      symbol,
                      textScaleFactor: 1.0,
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

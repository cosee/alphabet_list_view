import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart' as repo;
import 'package:flutter/material.dart';

class ExampleCustom1 extends StatelessWidget {
  ExampleCustom1({Key? key}) : super(key: key);
  final List<AlphabetListViewItemGroup> apples = [
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
      items: apples,
      alphabetListViewOptions: AlphabetListViewOptions(
        alphabetOverlayOptions: AlphabetOverlayOptions(
          alignment: Alignment.centerRight,
          alphabetOverlayBuilder: (context, symbol) {
            return Container(
              width: 100,
              height: 100,
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
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryVariant,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(100.0),
                ),
              ),
            );
          },
        ),
        alphabetScrollbarOptions: AlphabetScrollbarOptions(
          jumpToSymbolsWithNoEntries: true,
          backgroundColor: Theme.of(context).colorScheme.secondaryVariant,
          alphabetScrollbarSymbolBuilder: (context, symbol, state) {
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
        alphabetListOptions: AlphabetListOptions(
          backgroundColor: const Color.fromRGBO(210, 255, 210, 1.0),
          stickySectionHeader: false,
          showSectionHeaderForEmptySections: true,
          alphabetListHeaderBuilder: (context, symbol) {
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
                    color: Theme.of(context).colorScheme.secondaryVariant,
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
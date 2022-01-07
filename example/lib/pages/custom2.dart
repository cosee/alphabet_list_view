import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart' as repo;
import 'package:flutter/material.dart';

class ExampleCustom2 extends StatelessWidget {
  ExampleCustom2({Key? key}) : super(key: key);

  final List<AlphabetListViewItemGroup> apples = [
    for (var emojiType in repo.emojis.entries)
      AlphabetListViewItemGroup(
        tag: emojiType.key,
        children: emojiType.value
            .map((emoji) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '$emoji\n${emoji.runes.toList()}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ))
            .toList(),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return AlphabetListView(
      items: apples,
      alphabetListViewOptions: AlphabetListViewOptions(
        alphabetScrollbarOptions: AlphabetScrollbarOptions(
          symbols: repo.emojiHeaders,
          width: 60,
          mainAxisAlignment: MainAxisAlignment.start,
          alphabetScrollbarSymbolBuilder: (context, symbol, state) {
            return FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: state == ScrollbarItemState.active
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      symbol,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        alphabetListOptions: AlphabetListOptions(
          alphabetListHeaderBuilder: (context, symbol) {
            return DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: const [.0, .6],
                  colors: [
                    Colors.green,
                    Colors.green.withOpacity(.0),
                  ],
                ),
              ),
              child: Text(
                symbol,
                style: const TextStyle(fontSize: 40),
              ),
            );
          },
          physics: const ClampingScrollPhysics(),
        ),
        alphabetOverlayOptions: const AlphabetOverlayOptions(
          showOverlay: false,
        ),
      ),
    );
  }
}

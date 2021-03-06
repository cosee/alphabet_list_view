import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart' as repo;
import 'package:flutter/material.dart';

class ExampleUnicode extends StatelessWidget {
  ExampleUnicode({Key? key}) : super(key: key);

  final List<AlphabetListViewItemGroup> animals = [
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
      items: animals,
      options: AlphabetListViewOptions(
        scrollbarOptions: ScrollbarOptions(
          symbols: repo.emojiHeaders,
          width: 60,
          mainAxisAlignment: MainAxisAlignment.start,
          symbolBuilder: (context, symbol, state) {
            return FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: state == AlphabetScrollbarItemState.active
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
        listOptions: ListOptions(
          listHeaderBuilder: (context, symbol) {
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
        overlayOptions: const OverlayOptions(
          showOverlay: false,
        ),
      ),
    );
  }
}

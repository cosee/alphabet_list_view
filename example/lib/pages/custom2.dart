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
            .map((emoji) => Text(
                  emoji,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 70),
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
          alphabetScrollbarSymbolBuilder: (context, symbol, state) {
            return Text(
              symbol,
              style: const TextStyle(fontSize: 30),
            );
          },
        ),
        alphabetListOptions: AlphabetListOptions(
          alphabetListHeaderBuilder: (context, symbol) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
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

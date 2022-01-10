import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('OnlyUniqueSymbolsInSideBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        items: [
          AlphabetListViewItemGroup(
            tag: 'A',
            children: [],
          ),
          AlphabetListViewItemGroup(
            tag: 'A',
            children: [],
          ),
        ],
        options: const AlphabetListViewOptions(
          alphabetListOptions: AlphabetListOptions(
            showSectionHeader: false,
          ),
        ),
      ),
    );

    final symbolAFinder = find.text('A');
    expect(symbolAFinder, findsOneWidget);
  });

  testWidgets('DoNotShowItemsThatAreNotInSymbols', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        items: [
          AlphabetListViewItemGroup(
            tag: 'ɣ',
            children: [
              const Text('A'),
            ],
          ),
        ],
      ),
    );

    final symbolGammaFinder = find.text('ɣ');
    expect(symbolGammaFinder, findsNothing);
  });

  testWidgets('DisplayItems', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        items: [
          AlphabetListViewItemGroup(
            tag: 'A',
            children: [
              const Text('TARGET'),
            ],
          ),
        ],
      ),
    );

    final itemFinder = find.text('TARGET');
    expect(itemFinder, findsOneWidget);
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key, required this.items, this.options})
      : super(key: key);
  final List<AlphabetListViewItemGroup> items;
  final AlphabetListViewOptions? options;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AlphabetListView(
          items: items,
          alphabetListViewOptions: options ?? const AlphabetListViewOptions(),
        ),
      ),
    );
  }
}

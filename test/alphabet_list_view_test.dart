import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view/src/scrollbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('OnlyUniqueSymbolsInSideBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        items: [
          AlphabetListViewItemGroup(tag: 'A'),
          AlphabetListViewItemGroup(tag: 'A'),
        ],
        options: const AlphabetListViewOptions(
          listOptions: ListOptions(showSectionHeader: false),
        ),
      ),
    );

    final symbolAFinder = find.text('A');
    expect(symbolAFinder, findsOneWidget);
  });

  testWidgets(
    'TagsThatAreNotInSymbolsAreNotVisible',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          items: [
            AlphabetListViewItemGroup(
              // Not ascii character chosen intentionally.
              // ignore: avoid-non-ascii-symbols
              tag: 'ɣ',
              children: const [Text('A')],
            ),
          ],
        ),
      );

      // Not ascii character chosen intentionally.
      // ignore: avoid-non-ascii-symbols
      final symbolGammaFinder = find.text('ɣ');
      expect(symbolGammaFinder, findsNothing);
    },
  );

  testWidgets('ItemsAreDisplayed', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        items: [
          AlphabetListViewItemGroup(
            tag: 'A',
            children: const [Text('TARGET')],
          ),
        ],
      ),
    );
    final itemFinder = find.text('TARGET');
    expect(itemFinder, findsOneWidget);
  });

  testWidgets('JumpToLocationAfterTapOnSidebar', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        items: [
          AlphabetListViewItemGroup(
            tag: 'A',
            children: List.filled(
              100,
              const SizedBox(
                height: 100,
                width: 100,
              ),
            ),
          ),
          AlphabetListViewItemGroup(
            tag: 'B',
            children: const [Text('TARGET')],
          ),
        ],
      ),
    );

    await tester.tap(
      find.descendant(
        of: find.byType(AlphabetScrollbar),
        matching: find.text('B'),
      ),
    );
    await tester.pump();

    final itemFinder = find.text('TARGET');
    expect(itemFinder, findsOneWidget);
  });

  testWidgets('JumpToLocationAfterDragOnSidebar', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        items: [
          AlphabetListViewItemGroup(
            tag: 'A',
            children: List.filled(
              100,
              const SizedBox(
                height: 100,
                width: 100,
              ),
            ),
          ),
          AlphabetListViewItemGroup(
            tag: 'B',
            children: const [Text('TARGET')],
          ),
        ],
      ),
    );

    final buttonA = find.descendant(
      of: find.byType(AlphabetScrollbar),
      matching: find.text('A'),
    );
    final buttonB = find.descendant(
      of: find.byType(AlphabetScrollbar),
      matching: find.text('B'),
    );

    await tester.drag(
      buttonA,
      tester.getCenter(buttonB) - tester.getCenter(buttonA),
    );

    await tester.pump();

    final itemFinder = find.text('TARGET');
    expect(itemFinder, findsOneWidget);
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({required this.items, super.key, this.options});

  final List<AlphabetListViewItemGroup> items;
  final AlphabetListViewOptions? options;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AlphabetListView(
          items: items,
          options: options ?? const AlphabetListViewOptions(),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AlphabetListViewOptions?>('options', options))
      ..add(IterableProperty<AlphabetListViewItemGroup>('items', items));
  }
}

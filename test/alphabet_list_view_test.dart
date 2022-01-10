import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {



  testWidgets('OnlyUniqueSymbols', (WidgetTester tester) async {
    await tester.pumpWidget(const Home());
    final symbolAFinder = find.text('A');
    expect(symbolAFinder, findsNWidgets(2));
  });



}

List<AlphabetListViewItemGroup> alphabetListViewItemGroups = [
  AlphabetListViewItemGroup(
    tag: 'A',
    children: [
      const Text('B'),
    ],
  ),
];

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: AlphabetListView(items: alphabetListViewItemGroups)),
    );
  }
}

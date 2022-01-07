import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'AlphabetListView demo',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: AlphabetListView(
          alphabetListViewOptions: AlphabetListViewOptions(
            alphabetOverlayOptions: AlphabetOverlayOptions(
              alignment: Alignment.topCenter,
              showOverlay: true,
              alphabetOverlayBuilder: (context, symbol) {
                return Container(
                  child: Text(symbol),
                  color: Colors.pink,
                  padding: const EdgeInsets.all(30),
                );
              },
            ),
            alphabetListOptions: AlphabetListOptions(
              backgroundColor: Colors.green,
              physics: const AlwaysScrollableScrollPhysics(),
              showSectionHeader: true,
              showSectionHeaderForEmptySections: false,
              stickySectionHeader: true,
              alphabetListHeaderBuilder: (context, symbol) {
                return Container(
                  color: Colors.red,
                  child: Text('#$symbol'),
                );
              },
            ),
            alphabetScrollbarOptions: const AlphabetScrollbarOptions(
              jumpToSymbolsWithNoEntries: false,
              backgroundColor: Colors.white54,
            ),
          ),
          items: items,
        ),
      ),
    );
  }
}

List<AlphabetListViewItemGroup> items = [
  AlphabetListViewItemGroup(tag: '1', children: [
    for (var i = 0; i < 10; i++) const Text('AAA'),
  ]),
  AlphabetListViewItemGroup.builder(
    tag: 'B',
    itemBuilder: (context, index) => Text('B' * (index + 1)),
    itemCount: 10,
  ),
  AlphabetListViewItemGroup(tag: 'Z', children: [
    for (var i = 0; i < 5; i++)
      const Align(alignment: Alignment.centerLeft, child: Icon(Icons.work)),
  ]),
  AlphabetListViewItemGroup(tag: '😔', children: [
    for (var i = 0; i < 1; i++) const Text('DDD'),
  ]),
  AlphabetListViewItemGroup(tag: 'E', children: [
    for (var i = 0; i < 5; i++)
      const Align(
        alignment: Alignment.centerLeft,
        child: Text('EEE'),
      ),
  ]),
  AlphabetListViewItemGroup(tag: 'F', children: [
    for (var i = 0; i < 31; i++) const Text('FFF'),
  ]),
  AlphabetListViewItemGroup(tag: 'G', children: [
    for (var i = 0; i < 2; i++) const Text('GGG'),
  ]),
  AlphabetListViewItemGroup(tag: 'H', children: [
    for (var i = 0; i < 33; i++) const Text('HHH'),
  ]),
  AlphabetListViewItemGroup(tag: 'I', children: [
    for (var i = 0; i < 0; i++) const Text('III'),
  ]),
  AlphabetListViewItemGroup(tag: 'J', children: [
    for (var i = 0; i < 4; i++) const Text('JJJ'),
  ]),
  AlphabetListViewItemGroup(tag: 'K', children: [
    for (var i = 0; i < 8; i++) const Text('KKK'),
  ]),
  AlphabetListViewItemGroup(tag: 'L', children: [
    for (var i = 0; i < 2; i++) const Text('LLL'),
  ]),
];

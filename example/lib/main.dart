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
      body: AlphabetListView(
        alphabetListViewOptions: AlphabetListViewOptions(
          alphabetListOptions: AlphabetListOptions(
            physics: const AlwaysScrollableScrollPhysics(),
            showSectionHeader: true,
            showSectionHeaderForEmptySections: false,
            stickySectionHeader: true,
            alphabetListSymbolBuilder: (context, symbol) {
              return Container(
                color: Colors.red,
                child: Text('#$symbol'),
              );
            },
          ),
          alphabetScrollbarOptions: const AlphabetScrollbarOptions(
            jumpToSymbolsWithNoEntries: false,
            symbols: [
              'A',
              'A',
              'B',
              'Z',
              'C',
              'D',
              'E',
              'F',
              'G',
              'H',
              'I',
              '😔',
              '1',
            ],
            backgroundColor: Colors.white60,
          ),
        ),
        items: items,
      ),
    );
  }
}

List<AlphabetListViewItemGroup> items = [
  AlphabetListViewItemGroup(tag: '1', children: [
    for (var i = 0; i < 10; i++) const TestText('AAA'),
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
    for (var i = 0; i < 1; i++) const TestText('DDD'),
  ]),
  AlphabetListViewItemGroup(tag: 'E', children: [
    for (var i = 0; i < 10; i++)
      const Align(
        alignment: Alignment.centerLeft,
        child: CircularProgressIndicator(),
      ),
  ]),
  AlphabetListViewItemGroup(tag: 'F', children: [
    for (var i = 0; i < 31; i++) const TestText('FFF'),
  ]),
  AlphabetListViewItemGroup(tag: 'G', children: [
    for (var i = 0; i < 2; i++) const TestText('GGG'),
  ]),
  AlphabetListViewItemGroup(tag: 'H', children: [
    for (var i = 0; i < 33; i++) const TestText('HHH'),
  ]),
  AlphabetListViewItemGroup(tag: 'I', children: [
    for (var i = 0; i < 0; i++) const TestText('III'),
  ]),
  AlphabetListViewItemGroup(tag: 'J', children: [
    for (var i = 0; i < 4; i++) const TestText('JJJ'),
  ]),
  AlphabetListViewItemGroup(tag: 'K', children: [
    for (var i = 0; i < 8; i++) const TestText('KKK'),
  ]),
  AlphabetListViewItemGroup(tag: 'L', children: [
    for (var i = 0; i < 2; i++) const TestText('LLL'),
  ]),
];

class TestText extends StatefulWidget {
  const TestText(this.string, {Key? key}) : super(key: key);
  final String string;

  @override
  _TestTextState createState() => _TestTextState();
}

class _TestTextState extends State<TestText> {
  @override
  void initState() {
    super.initState();
    //print("INIT");
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.string);
  }

  @override
  void dispose() {
    //print("DISPOSE");
    super.dispose();
  }
}

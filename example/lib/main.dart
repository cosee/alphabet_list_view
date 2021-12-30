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
      body: const AlphabetListView(
        items: items,
      ),
    );
  }
}

const List<AlphabetListViewItemGroup> items = [
  AlphabetListViewItemGroup(tag: 'A', items: [
    Text('A'),
    Text('AA'),
    Text('AAA'),
    Text('AAA'),
    Text('AAA'),
    Text('AAA'),
    Text('AAA'),
    Text('AAA'),
    Text('AAA'),
    Text('AAA'),
  ]),  AlphabetListViewItemGroup(tag: 'B', items: [
    Text('B1'),
    Text('BB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBBx'),
  ]),  AlphabetListViewItemGroup(tag: 'C', items: [
    Text('C'),
    Text('C'),
    Text('CCCCCCCC'),
    Text('CCCCCCCC'),
    Text('CCCCCCCC'),
    Text('CCCCCCCC'),
    Text('CCCCCCCC'),
    Text('CCCCCCCC'),
    Text('CCCCCCCC'),
    Text('CCCCCCCC'),
  ]),
];

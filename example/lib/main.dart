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
    Text('AAA'),
    Text('AAA'),
    Text('AAA'),
    Text('AAA'),
    Text('AAA'),
    Text('AAA'),
    Text('AAA'),
  ]),
  AlphabetListViewItemGroup(tag: 'B', items: [
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
    Text('BBB'),
  ]),
  AlphabetListViewItemGroup(tag: 'C', items: [
    Text('CCC'),
  ]),
  AlphabetListViewItemGroup(tag: 'D', items: [
    Text('DDD'),
    Text('DDD'),
    Text('DDD'),
  ]),
  AlphabetListViewItemGroup(tag: 'E', items: [
    Text('EEE'),
    Text('EEE'),
  ]),
  AlphabetListViewItemGroup(tag: 'F', items: [
    Text('FFF'),
    Text('FFF'),
    Text('FFF'),
    Text('FFF'),
    Text('FFF'),
  ]),
  AlphabetListViewItemGroup(tag: 'G', items: [
    Text('GGG'),
    Text('GGG'),
    Text('GGG'),
  ]),
  AlphabetListViewItemGroup(tag: 'H', items: [
    Text('HHH'),
    Text('HHH'),
    Text('HHH'),
    Text('HHH'),
  ]),
];

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
        items: items,
      ),
    );
  }
}

List<AlphabetListViewItemGroup> items = [
  AlphabetListViewItemGroup(key: GlobalKey(), tag: 'A', children: [
    for (var i = 0; i < 10; i++) const TestText('AAA'),
  ]),
  AlphabetListViewItemGroup.builder(key: GlobalKey(), tag: 'B',
  itemBuilder: (context, index) => Text(index.toString()), itemCount: 10
    ,
  ),
  AlphabetListViewItemGroup(key: GlobalKey(), tag: 'C', children: [
    for (var i = 0; i < 5; i++) const TestText('CCC'),
  ]),
  AlphabetListViewItemGroup(key: GlobalKey(), tag: 'D', children: [
    for (var i = 0; i < 1; i++) const TestText('DDD'),
  ]),
  AlphabetListViewItemGroup(key: GlobalKey(), tag: 'E', children: [
    for (var i = 0; i < 2; i++) const TestText('EEE'),
  ]),
  AlphabetListViewItemGroup(key: GlobalKey(), tag: 'F', children: [
    for (var i = 0; i < 31; i++) const TestText('FFF'),
  ]),
  AlphabetListViewItemGroup(key: GlobalKey(), tag: 'G', children: [
    for (var i = 0; i < 2; i++) const TestText('GGG'),
  ]),
  AlphabetListViewItemGroup(key: GlobalKey(), tag: 'H', children: [
    for (var i = 0; i < 33; i++) const TestText('HHH'),
  ]),
  AlphabetListViewItemGroup(key: GlobalKey(), tag: 'I', children: [
    for (var i = 0; i < 0; i++) const TestText('III'),
  ]),
  AlphabetListViewItemGroup(key: GlobalKey(), tag: 'J', children: [
    for (var i = 0; i < 4; i++) const TestText('JJJ'),
  ]),
  AlphabetListViewItemGroup(key: GlobalKey(), tag: 'K', children: [
    for (var i = 0; i < 8; i++) const TestText('KKK'),
  ]),
  AlphabetListViewItemGroup(key: GlobalKey(), tag: 'L', children: [
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
   // print("INIT");
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

import 'package:alphabet_list_view_example/pages/widget_builder.dart';
import 'package:alphabet_list_view_example/pages/unicode.dart';
import 'package:alphabet_list_view_example/pages/offset.dart';
import 'package:alphabet_list_view_example/pages/default.dart';
import 'package:alphabet_list_view_example/pages/rtl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlphabetListView demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AlphabetListView'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Default'),
              Tab(text: 'RTL'),
              Tab(text: 'WidgetBuilder'),
              Tab(text: 'Unicode'),
              Tab(text: 'Offset'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ExampleDefault(),
              ExampleRTL(),
              ExampleWidgetBuilder(),
              ExampleUnicode(),
              ExampleOffset(),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: const SizedBox.shrink(),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

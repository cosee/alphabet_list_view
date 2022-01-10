import 'package:alphabet_list_view_example/pages/custom1.dart';
import 'package:alphabet_list_view_example/pages/custom2.dart';
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
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AlphabetListView'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Default'),
              Tab(text: 'RTL'),
              Tab(text: 'Custom1'),
              Tab(text: 'Custom2'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ExampleDefault(),
              ExampleRTL(),
              ExampleCustom1(),
              ExampleCustom2(),
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

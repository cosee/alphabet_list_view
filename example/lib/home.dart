import 'package:alphabet_list_view_example/pages/default.dart';
import 'package:alphabet_list_view_example/pages/offset.dart';
import 'package:alphabet_list_view_example/pages/rtl.dart';
import 'package:alphabet_list_view_example/pages/unicode.dart';
import 'package:alphabet_list_view_example/pages/widget_builder.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AlphabetListView'),
          bottom: TabBar(
            indicatorColor: Theme.of(context).colorScheme.secondary,
            isScrollable: true,
            tabs: const [
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
          color: Theme.of(context).colorScheme.primary,
          child: const SizedBox.shrink(),
        ),
      ),
    );
  }
}

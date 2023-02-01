import 'package:alphabet_list_view_example/home.dart';
import 'package:alphabet_list_view_example/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlphabetListView demo',
      theme: CustomTheme.theme(context),
      home: const Home(),
    );
  }
}

import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/cupertino.dart';

typedef SymbolStateBuilder = Widget Function(
  BuildContext context,
  String symbol,
  AlphabetScrollbarItemState state,
);

typedef SymbolBuilder = Widget Function(
  BuildContext context,
  String symbol,
);

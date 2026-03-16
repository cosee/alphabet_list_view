import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/cupertino.dart';

/// Typedef for SymbolStateBuilder
typedef SymbolStateBuilder = Widget Function(
  BuildContext context,
  String symbol,
  AlphabetScrollbarItemState state,
);

/// Typedef for SymbolBuilder
typedef SymbolBuilder = Widget Function(
  BuildContext context,
  String symbol,
);

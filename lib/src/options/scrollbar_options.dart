import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';

/// Options for the scrollbar of the AlphabetListView
class ScrollbarOptions {
  /// Constructor of ScrollbarOptions
  const ScrollbarOptions({
    this.width = 40,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.backgroundColor,
    this.symbols = DefaultScrollbarSymbols.alphabet,
    this.jumpToSymbolsWithNoEntries = false,
    this.forcePosition,
    this.symbolBuilder,
    this.decoration,
  }) : assert(
         backgroundColor == null || decoration == null,
         'Cannot provide both a color and a decoration\n'
         'To provide both, use "decoration: BoxDecoration(color: color)".',
       );

  /// The width of the sidebar.
  final double width;

  /// Padding around the sidebar.
  final EdgeInsets? padding;

  /// Placement of the children in the sidebar.
  final MainAxisAlignment mainAxisAlignment;

  /// Optional background color for the sidebar.
  final Color? backgroundColor;

  /// A [List] of [String] representing the symbols to be shown.
  ///
  /// Strings must be unique.
  final Iterable<String> symbols;

  /// Activates symbols without children.
  ///
  /// Enables jumping to the position even if there are no entries present.
  final bool jumpToSymbolsWithNoEntries;

  /// Force the position of the sidebar.
  ///
  /// If set, [Directionality] will be ignored.
  final AlphabetScrollbarPosition? forcePosition;

  /// Builder function for sidebar symbols.
  final SymbolStateBuilder? symbolBuilder;

  /// Decoration for the sidebar.
  final Decoration? decoration;
}

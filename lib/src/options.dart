import 'package:alphabet_list_view/src/enum.dart';
import 'package:flutter/material.dart';

class AlphabetListViewOptions {
  const AlphabetListViewOptions({
    this.alphabetListOptions = const AlphabetListOptions(),
    this.alphabetScrollbarOptions = const AlphabetScrollbarOptions(),
    this.alphabetOverlayOptions = const AlphabetOverlayOptions(),

  });

  final AlphabetListOptions alphabetListOptions;
  final AlphabetScrollbarOptions alphabetScrollbarOptions;
  final AlphabetOverlayOptions alphabetOverlayOptions;
}

class AlphabetListOptions {
  const AlphabetListOptions({
    this.backgroundColor,
    this.physics,
    this.showSectionHeader = true,
    this.stickySectionHeader = true,
    this.showSectionHeaderForEmptySections = false,
    this.alphabetListHeaderBuilder,
  });

  final Color? backgroundColor;
  final ScrollPhysics? physics;
  final bool showSectionHeader;
  final bool stickySectionHeader;
  final bool showSectionHeaderForEmptySections;
  final Widget Function(
    BuildContext context,
    String symbol,
  )? alphabetListHeaderBuilder;
}

class AlphabetScrollbarOptions {
  const AlphabetScrollbarOptions({
    this.width = 40,
    this.backgroundColor,
    this.alphabetHintOptions,
    this.symbols = defaultSymbols,
    this.jumpToSymbolsWithNoEntries = false,
    this.alphabetScrollbarSymbolBuilder,
  });

  final double width;
  final Color? backgroundColor;
  final AlphabetOverlayOptions? alphabetHintOptions;
  final Iterable<String> symbols;
  final bool jumpToSymbolsWithNoEntries;
  final Widget Function(
    BuildContext context,
    String symbol,
    ScrollbarItemState state,
  )? alphabetScrollbarSymbolBuilder;
}

class AlphabetOverlayOptions {
  const AlphabetOverlayOptions({
    this.showOverlay = true,
    this.alignment = Alignment.center,
    this.alphabetOverlayBuilder,
  });

  final bool showOverlay;
  final Alignment alignment;
  final Widget Function(
    BuildContext context,
    String symbol,
  )? alphabetOverlayBuilder;
}

const List<String> defaultSymbols = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
  '#',
];

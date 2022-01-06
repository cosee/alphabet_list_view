import 'package:flutter/material.dart';

class AlphabetListViewOptions {
  const AlphabetListViewOptions({
    this.alphabetListOptions = const AlphabetListOptions(),
    this.alphabetScrollbarOptions = const AlphabetScrollbarOptions(),
  });

  final AlphabetListOptions alphabetListOptions;
  final AlphabetScrollbarOptions alphabetScrollbarOptions;
}

class AlphabetListOptions {
  const AlphabetListOptions({
    this.showSectionHeader = true,
    this.stickySectionHeader = true,
    this.showSectionHeaderForEmptySections = false,
  });

  final bool showSectionHeader;
  final bool stickySectionHeader;
  final bool showSectionHeaderForEmptySections;
}

class AlphabetScrollbarOptions {
  const AlphabetScrollbarOptions({
    this.alphabetHintOptions,
    this.symbols = defaultSymbols,
    this.jumpToSymbolsWithNoEntries = false,
  });

  final AlphabetHintOptions? alphabetHintOptions;
  final List<String> symbols;
  final bool jumpToSymbolsWithNoEntries;
}

class AlphabetHintOptions {
  const AlphabetHintOptions({
    this.indexHintWidth = 72,
    this.indexHintHeight = 72,
    this.indexHintDecoration = const BoxDecoration(
      color: Colors.black87,
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
    this.indexHintTextStyle =
        const TextStyle(fontSize: 24.0, color: Colors.white),
    this.indexHintChildAlignment = Alignment.center,
    this.indexHintAlignment = Alignment.center,
    this.indexHintPosition,
    this.indexHintOffset = Offset.zero,
  });

  final double indexHintWidth;
  final double indexHintHeight;
  final Decoration indexHintDecoration;
  final Alignment indexHintAlignment;
  final Alignment indexHintChildAlignment;
  final TextStyle indexHintTextStyle;
  final Offset? indexHintPosition;
  final Offset indexHintOffset;
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

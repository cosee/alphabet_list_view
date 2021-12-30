import 'package:flutter/material.dart';

class HintOptions {
  const HintOptions({
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

class ItemOptions {
  const ItemOptions({
    this.padding = const EdgeInsets.all(5),
  });

  final EdgeInsets padding;
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



class AlphabetListViewOptions {
  const AlphabetListViewOptions({
    this.data = defaultSymbols,
    this.needRebuild = false,
    this.ignoreDragCancel = false,
    this.width = 30,
    this.textStyle =
    const TextStyle(fontSize: 12, color: Color.fromRGBO(69, 69, 69, 1.0)),
    this.selectItemTextStyle,
    this.itemNotUsedTextStyle,
    this.itemOptions = const ItemOptions(),
    this.hintOptions = const HintOptions(),
  });

  final List<String> data;
  final bool needRebuild;
  final bool ignoreDragCancel;
  final double width;
  final TextStyle textStyle;
  final TextStyle? selectItemTextStyle;
  final TextStyle? itemNotUsedTextStyle;
  final ItemOptions itemOptions;
  final HintOptions hintOptions;
}



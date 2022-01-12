import 'package:alphabet_list_view/src/enum.dart';
import 'package:flutter/material.dart';

/// Options class.
///
/// Optional class containing all options for the AlphabetListView.
class AlphabetListViewOptions {
  const AlphabetListViewOptions({
    this.listOptions = const ListOptions(),
    this.scrollbarOptions = const ScrollbarOptions(),
    this.overlayOptions = const OverlayOptions(),
  });

  /// Customisation options for the list.
  final ListOptions listOptions;

  /// Customisation options for the scrollbar.
  final ScrollbarOptions scrollbarOptions;

  /// Customisation options for the overlay.
  final OverlayOptions overlayOptions;
}

/// Options for the list of the AlphabetListView.
class ListOptions {
  const ListOptions({
    this.backgroundColor,
    this.physics,
    this.showSectionHeader = true,
    this.stickySectionHeader = true,
    this.showSectionHeaderForEmptySections = false,
    this.listHeaderBuilder,
  });

  /// Optional background color.
  final Color? backgroundColor;

  /// Custom scroll physics.
  final ScrollPhysics? physics;

  /// Show the header above the items.
  final bool showSectionHeader;

  /// Use sticky headers.
  final bool stickySectionHeader;

  /// Show headers for sections without child widgets.
  final bool showSectionHeaderForEmptySections;

  /// Builder function for headers.
  final Widget Function(
    BuildContext context,
    String symbol,
  )? listHeaderBuilder;
}

/// Options for the scrollbar of the AlphabetListView
class ScrollbarOptions {
  const ScrollbarOptions({
    this.width = 40,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.backgroundColor,
    this.symbols = defaultSymbols,
    this.jumpToSymbolsWithNoEntries = false,
    this.forcePosition,
    this.scrollbarSymbolBuilder,
  });

  /// The width of the sidebar.
  final double width;

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
  final Widget Function(
    BuildContext context,
    String symbol,
    AlphabetScrollbarItemState state,
  )? scrollbarSymbolBuilder;
}

/// Options for the overlay of the AlphabetListView
class OverlayOptions {
  const OverlayOptions({
    this.showOverlay = true,
    this.alignment = Alignment.center,
    this.overlayBuilder,
  });

  /// Showing an overlay of the current icon when swiping across the sidebar.
  final bool showOverlay;

  /// The [Alignment] of the overlay.
  final Alignment alignment;

  /// Builder function for the overlay.
  final Widget Function(
    BuildContext context,
    String symbol,
  )? overlayBuilder;
}

/// Default symbols used by the sidebar.
///
/// 'A'-'Z' and '#'
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

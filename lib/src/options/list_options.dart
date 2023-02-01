import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';

/// Options for the list of the AlphabetListView.
class ListOptions {
  /// Constructor of ListOptions
  const ListOptions({
    this.backgroundColor,
    this.topOffset,
    this.padding,
    this.physics,
    this.showSectionHeader = true,
    this.stickySectionHeader = true,
    this.showSectionHeaderForEmptySections = false,
    this.beforeList,
    this.afterList,
    this.listHeaderBuilder,
  }) : assert((topOffset ?? 0) >= 0, 'Offset must not be zero');

  /// Optional background color.
  final Color? backgroundColor;

  /// Sets an offset to the upper edge.
  ///
  /// Must be >= 0 or null
  /// Does not work in combination with [stickySectionHeader] set to true.
  final double? topOffset;

  /// Padding around the list.
  final EdgeInsets? padding;

  /// Custom scroll physics.
  final ScrollPhysics? physics;

  /// Show the header above the items.
  final bool showSectionHeader;

  /// Use sticky headers.
  final bool stickySectionHeader;

  /// Show headers for sections without child widgets.
  final bool showSectionHeaderForEmptySections;

  /// Optional [Widget] before the list.
  final Widget? beforeList;

  /// Optional [Widget] after the list.
  final Widget? afterList;

  /// Builder function for headers.
  final SymbolBuilder? listHeaderBuilder;
}

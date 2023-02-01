import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:flutter/material.dart';

/// Options for the overlay of the AlphabetListView
class OverlayOptions {
  /// Constructor of OverlayOptions
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
  final SymbolBuilder? overlayBuilder;
}

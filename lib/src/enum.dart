/// The status of the sidebar symbols.
///
/// [active]: when the symbol is not deactivated and selected.
/// [inactive]: when the symbol is not deactivated but not selected.
/// [deactivated]: when the symbol is not used.
enum AlphabetScrollbarItemState {
  /// active item
  active,

  /// inactive item
  inactive,

  /// deactivated item
  deactivated,
}

/// The position of the scrollbar in relation to the list.
enum AlphabetScrollbarPosition {
  /// Scrollbar on left side
  left,

  /// Scrollbar on right side
  right,
}

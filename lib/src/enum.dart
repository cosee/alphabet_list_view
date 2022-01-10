/// The status of the sidebar symbols.
///
/// [active]: when the symbol is not deactivated and selected.
/// [inactive]: when the symbol is not deactivated but not selected.
/// [deactivated]: when the symbol is not used e.g. the [AlphabetListViewItemGroup] has no children.
enum AlphabetScrollbarItemState {
  active,
  inactive,
  deactivated,
}

/// The position of the scrollbar in relation to the list.
enum AlphabetScrollbarPosition {
  left,
  right,
}

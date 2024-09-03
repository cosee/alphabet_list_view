import 'package:alphabet_list_view/alphabet_list_view.dart';
import 'package:alphabet_list_view_example/repository.dart';
import 'package:flutter/material.dart';

class ExampleWidgetBuilder extends StatelessWidget {
  const ExampleWidgetBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return AlphabetListView(
      items: _colors,
      options: AlphabetListViewOptions(
        overlayOptions: OverlayOptions(
          alignment: Alignment.centerRight,
          overlayBuilder: (context, symbol) {
            return Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(100),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: FittedBox(
                  child: Text(
                    symbol,
                    textScaler: TextScaler.noScaling,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        scrollbarOptions: ScrollbarOptions(
          jumpToSymbolsWithNoEntries: true,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.secondary,
                Colors.lightGreen,
              ],
            ),
          ),
          symbolBuilder: (context, symbol, state) {
            final color = switch (state) {
              AlphabetScrollbarItemState.active => Colors.green[900],
              AlphabetScrollbarItemState.deactivated => Colors.lightGreen,
              _ => Colors.green[800],
            };

            return Container(
              padding: const EdgeInsets.only(left: 4, top: 2, bottom: 2),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(100),
                ),
                color: state == AlphabetScrollbarItemState.active
                    ? Colors.lightGreen
                    : null,
              ),
              child: Center(
                child: FittedBox(
                  child: Text(
                    symbol,
                    style: TextStyle(color: color, fontSize: 20),
                  ),
                ),
              ),
            );
          },
        ),
        listOptions: ListOptions(
          backgroundColor: const Color.fromRGBO(210, 255, 210, 1),
          stickySectionHeader: false,
          showSectionHeaderForEmptySections: true,
          listHeaderBuilder: (context, symbol) => Padding(
            padding: const EdgeInsets.only(right: 18, top: 4, bottom: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(100),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 8,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Text(
                    symbol,
                    textScaler: TextScaler.noScaling,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<AlphabetListViewItemGroup> get _colors => Repository.colors.entries
      .map(
        (colorStartingLetterGroup) => AlphabetListViewItemGroup(
          tag: colorStartingLetterGroup.key,
          children: colorStartingLetterGroup.value.map(
            (color) => Padding(
              padding: const EdgeInsets.all(8),
              child: _ColorButton(name: color.$1, color: Color(color.$2)),
            ),
          ),
        ),
      )
      .toList();
}

class _ColorButton extends StatelessWidget {
  const _ColorButton({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showSnackBar(context, name),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}

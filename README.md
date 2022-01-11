A ListView with sticky headers and an iOS-like clickable sidebar.

![Preview example](example/screenshots/example.gif "Example")

## Features

- Easy to create
- Customizable header
- Customizable sidebar
- Customizable overlay
- Right to left language support
- Configurable sidebar items

## Usage

Depend on it:

```yaml
dependencies:
  alphabet_list_view: ^0.1.0
```

Import it:

```dart
import 'package:alphabet_list_view/alphabet_list_view.dart';
```

Example:

```dart  
final List<AlphabetListViewItemGroup> tech = [
    AlphabetListViewItemGroup(tag: 'A', children: const [
    Text('Apple'),
    Text('Amazon'),
    Text('Alibaba'),
    ]),
    AlphabetListViewItemGroup(tag: 'I', children: const [
    Text('Intel'),
    Text('IBM'),
    ]),
];

AlphabetListView(
    items: tech,
);
```  

## Customization options

```dart
 final List<AlphabetListViewItemGroup> tech = [
      AlphabetListViewItemGroup(tag: 'A', children: const [
        Text('Apple'),
        Text('Amazon'),
        Text('Alibaba'),
      ]),
      AlphabetListViewItemGroup(tag: 'I', children: const [
        Text('Intel'),
        Text('IBM'),
      ]),
    ];

    final AlphabetListViewOptions options = AlphabetListViewOptions(
      alphabetListOptions: AlphabetListOptions(
        alphabetListHeaderBuilder: (context, symbol) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(symbol),
            ),
          );
        },
      ),
      alphabetScrollbarOptions:
          const AlphabetScrollbarOptions(
            backgroundColor: Colors.yellow,
          ),
      alphabetOverlayOptions: const AlphabetOverlayOptions(
        showOverlay: false,
      ),
    );

    AlphabetListView(
      items: tech,
      alphabetListViewOptions: options,
    );
```  

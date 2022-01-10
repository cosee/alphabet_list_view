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
    AlphabetListViewItemGroup(tag: 'A', children: [
    Text('Apple'),
    Text('Amazon'),
    Text('Alibaba'),
    ]),
    AlphabetListViewItemGroup(tag: 'I', children: [
    Text('Intel'),
    Text('IBM'),
    ]),
];

AlphabetListView(
    items: tech,
);
```  

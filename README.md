# Responsive Notebook Background
[![pub package][pub_badge]][pub_badge_link]
[![package publisher][publisher_badge]][publisher_badge_link]
[![style][style_badge]][style_link]
[![license][license_badge]][license_link]

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
  listOptions: ListOptions(
    listHeaderBuilder: (context, symbol) {
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
  scrollbarOptions:
  const ScrollbarOptions(
    backgroundColor: Colors.yellow,
  ),
  overlayOptions: const OverlayOptions(
    showOverlay: false,
  ),
);

AlphabetListView(
  items: tech,
  options: options,
);
```  
[publisher_badge]: https://img.shields.io/pub/publisher/alphabet_list_view.svg

[publisher_badge_link]: https://pub.dev/publishers/cosee.biz/packages

[license_badge]: https://img.shields.io/github/license/cosee/alphabet_list_view

[license_link]: https://github.com/cosee/alphabet_list_view/blob/master/LICENSE

[style_badge]: https://img.shields.io/badge/style-cosee__lints-brightgreen

[style_link]: https://pub.dev/packages/cosee_lints

[pub_badge]: https://img.shields.io/pub/v/alphabet_list_view.svg

[pub_badge_link]: https://pub.dartlang.org/packages/alphabet_list_view
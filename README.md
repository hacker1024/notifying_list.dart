# notifying_list
A Dart package providing list implementations that notify when they're modified.

## Features
- A callback-based notifying list (`CallbackNotifyingList`)
- A stream-based notifying list (`StreamNotifyingList`)

## Getting started
Import the library:

```dart
import 'package:notifying_list/notifying_list.dart';
```

## Usage

```dart
final callbackList = CallbackNotifyingList<num>(() => print('Modified!'));
callbackList.add(0); // 'Modified!'

final streamList = StreamNotifyingList()
  ..stream.forEach(
    (currentList) => print('Modified! Current list: $currentList'),
  );
streamList.add(0); // 'Modified! Current list: [0]'
```

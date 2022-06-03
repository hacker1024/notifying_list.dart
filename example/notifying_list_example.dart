// ignore_for_file: avoid_print

import 'package:notifying_list/notifying_list.dart';

void main() {
  final callbackList = CallbackNotifyingList<num>(() => print('Modified!'));
  callbackList.add(0);

  final streamList = StreamNotifyingList()
    ..stream.forEach(
      (currentList) => print('Modified! Current list: $currentList'),
    );
  streamList.add(0);
}

import 'dart:async';

import 'package:meta/meta.dart';
import 'package:notifying_list/src/notifying_list.dart';

/// A [List] implementation that emits a copy of itself through a broadcast
/// stream whenever it is modified.
///
/// This is a performant implementation, as all methods that read from and write
/// to the list are proxied to the source list via the [DelegatingList] backend.
class StreamNotifyingList<E> extends NotifyingList<E> implements List<E> {
  final _streamController = StreamController<List<E>>.broadcast();

  /// A stream that emits a copy of the list whenever it is modified.
  Stream<List<E>> get stream => _streamController.stream;

  /// Creates an empty notifying list.
  StreamNotifyingList();

  /// Creates a notifying list of the given length with [fill] at each position.
  ///
  /// The [length] must be a non-negative integer.
  ///
  /// The created list is fixed-length if [growable] is false (the default)
  /// and growable if [growable] is true.
  /// If the list is growable, increasing its [length] will *not* initialize
  /// new entries with [fill].
  /// After being created and filled, the list is no different from any other
  /// growable or fixed-length list created
  /// using `[]` or other [List] constructors.
  ///
  /// All elements of the created list share the same [fill] value.
  ///
  /// See: [List.filled].
  StreamNotifyingList.filled(super.length, super.fill, {super.growable})
      : super.filled();

  /// Creates a notifying list from [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  ///
  /// This constructor creates a growable list when [growable] is true;
  /// otherwise, it returns a fixed-length list.
  ///
  /// See: [List.of].
  StreamNotifyingList.of(super.elements, {super.growable}) : super.of();

  /// Generates a notifying list of values.
  ///
  /// Creates a list with [length] positions and fills it with values created by
  /// calling [generator] for each index in the range `0` .. `length - 1`
  /// in increasing order.
  ///
  /// The created list is fixed-length if [growable] is set to false.
  ///
  /// The [length] must be non-negative.
  StreamNotifyingList.generate(super.length, super.generator, {super.growable})
      : super.generate();

  @protected
  @override
  void onModified() => _streamController.add(List.of(this));
}

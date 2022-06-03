import 'dart:math';

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

abstract class NotifyingList<E> extends DelegatingList<E> implements List<E> {
  /// Creates an empty notifying list.
  NotifyingList() : super([]);

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
  NotifyingList.filled(int length, E fill, {bool growable = false})
      : super(List.filled(length, fill, growable: growable));

  /// Creates a notifying list from [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  ///
  /// This constructor creates a growable list when [growable] is true;
  /// otherwise, it returns a fixed-length list.
  ///
  /// See: [List.of].
  NotifyingList.of(Iterable<E> elements, {bool growable = true})
      : super(List.of(elements, growable: growable));

  /// Generates a notifying list of values.
  ///
  /// Creates a list with [length] positions and fills it with values created by
  /// calling [generator] for each index in the range `0` .. `length - 1`
  /// in increasing order.
  ///
  /// The created list is fixed-length if [growable] is set to false.
  ///
  /// The [length] must be non-negative.
  NotifyingList.generate(int length, E Function(int index) generator,
      {bool growable = true})
      : super(List.generate(length, generator, growable: growable));

  /// Creates a notifying list backed by a [base] list that calls [onModified]
  /// when the base is modified through it.
  @protected
  const NotifyingList._fromBase(super.base);

  @protected
  void onModified();

  @override
  void operator []=(int index, E value) {
    super[index] = value;
    onModified();
  }

  @override
  set length(int newLength) {
    super.length = newLength;
    onModified();
  }

  @override
  set first(E value) {
    super.first = value;
    onModified();
  }

  @override
  set last(E value) {
    super.last = value;
    onModified();
  }

  @override
  void setAll(int at, Iterable<E> iterable) {
    super.setAll(at, iterable);
    onModified();
  }

  @override
  void add(E value) {
    super.add(value);
    onModified();
  }

  @override
  void insert(int index, E value) {
    super.insert(index, value);
    onModified();
  }

  @override
  void insertAll(int index, Iterable<E> iterable) {
    super.insertAll(index, iterable);
    onModified();
  }

  @override
  void addAll(Iterable<E> iterable) {
    super.addAll(iterable);
    onModified();
  }

  @override
  bool remove(Object? element) {
    final result = super.remove(element);
    onModified();
    return result;
  }

  @override
  void removeWhere(bool Function(E element) test) {
    super.removeWhere(test);
    onModified();
  }

  @override
  void retainWhere(bool Function(E element) test) {
    super.retainWhere(test);
    onModified();
  }

  @override
  void sort([Comparator<E>? compare]) {
    super.sort(compare);
    onModified();
  }

  @override
  void shuffle([Random? random]) {
    super.shuffle(random);
    onModified();
  }

  @override
  void clear() {
    super.clear();
    onModified();
  }

  @override
  E removeAt(int index) {
    final result = super.removeAt(index);
    onModified();
    return result;
  }

  @override
  E removeLast() {
    final result = super.removeLast();
    onModified();
    return result;
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    super.setRange(start, end, iterable, skipCount);
    onModified();
  }

  @override
  void removeRange(int start, int end) {
    super.removeRange(start, end);
    onModified();
  }

  @override
  void fillRange(int start, int end, [E? fillValue]) {
    super.fillRange(start, end, fillValue);
    onModified();
  }

  @override
  List<T> cast<T>() => _CastedNotifyingList<T>(onModified, super.cast());
}

class _CastedNotifyingList<E> extends NotifyingList<E> implements List<E> {
  final void Function() onModifiedCallback;

  const _CastedNotifyingList(this.onModifiedCallback, List<E> base)
      : super._fromBase(base);

  @protected
  @override
  void onModified() => onModifiedCallback();
}

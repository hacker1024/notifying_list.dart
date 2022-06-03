import 'package:meta/meta.dart';
import 'package:notifying_list/src/notifying_list.dart';

/// A [List] implementation that calls a callback function whenever it's
/// modified.
///
/// This is a performant implementation, as all methods that read from and write
/// to the list are proxied to the source list via the [DelegatingList] backend.
class CallbackNotifyingList<E> extends NotifyingList<E> implements List<E> {
  final void Function() onModifiedCallback;

  /// Creates an empty notifying list.
  CallbackNotifyingList(this.onModifiedCallback);

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
  CallbackNotifyingList.filled(
    this.onModifiedCallback,
    int length,
    E fill, {
    bool growable = false,
  }) : super.filled(
          length,
          fill,
          growable: growable,
        );

  /// Creates a notifying list from [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  ///
  /// This constructor creates a growable list when [growable] is true;
  /// otherwise, it returns a fixed-length list.
  ///
  /// See: [List.of].
  CallbackNotifyingList.of(
    this.onModifiedCallback,
    Iterable<E> elements, {
    bool growable = true,
  }) : super.of(elements, growable: growable);

  /// Generates a notifying list of values.
  ///
  /// Creates a list with [length] positions and fills it with values created by
  /// calling [generator] for each index in the range `0` .. `length - 1`
  /// in increasing order.
  ///
  /// The created list is fixed-length if [growable] is set to false.
  ///
  /// The [length] must be non-negative.
  CallbackNotifyingList.generate(
    this.onModifiedCallback,
    int length,
    E Function(int index) generator, {
    bool growable = true,
  }) : super.generate(
          length,
          generator,
          growable: growable,
        );

  @protected
  @override
  void onModified() => onModifiedCallback();
}

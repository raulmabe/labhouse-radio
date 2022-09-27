import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension UtilExt on BuildContext {
  NavigatorState get navigator => Navigator.of(this);
  GoRouter get router => GoRouter.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screen => mediaQuery.size;
  EdgeInsets get padding => mediaQuery.padding;

  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;
}

extension IterableExt<T> on Iterable<T> {
  bool containsList(Iterable<Object> a) {
    for (final item in a) {
      if (!contains(item)) return false;
    }
    return true;
  }

  Iterable<T> distinct({bool Function(T previous, T next)? equals}) {
    final list = List<T>.from(this);
    final _equals = equals ?? (prev, next) => prev == next;
    for (var i = 0; i < list.length; ++i) {
      final iItem = list[i];

      for (var j = list.length - 1; j >= 0; --j) {
        final jItem = list[j];

        if (i != j && _equals(iItem, jItem)) {
          list.removeAt(i);
        }
      }
    }
    return list;
  }

  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) => fold(
        <K, List<T>>{},
        (Map<K, List<T>> map, T element) =>
            map..putIfAbsent(keyFunction(element), () => <T>[]).add(element),
      );

  T? get firstOrNull {
    try {
      return elementAt(0);
    } catch (_) {
      return null;
    }
  }

  Iterable<T> hugBy(T hugger) {
    return [
      hugger,
      ...this,
      hugger,
    ];
  }

  Iterable<T> separateBy(T separator, {bool wrap = false}) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return [];

    final _l = [iterator.current];
    while (iterator.moveNext()) {
      _l
        ..add(separator)
        ..add(iterator.current);
    }
    return wrap ? _l.hugBy(separator) : _l;
  }

  Iterable<T> separateByMapped(T Function(int) map) {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return [];

    var index = 0;
    final _l = [iterator.current];
    while (iterator.moveNext()) {
      _l
        ..add(map(index))
        ..add(iterator.current);
      ++index;
    }
    return _l;
  }

  List<T> toggle(T a) {
    if (contains(a)) {
      final result = toList()..remove(a);
      return result;
    } else {
      final result = toList()..add(a);
      return result;
    }
  }
}

extension StringIterableExt on Iterable<String> {
  String? get separatedByBreak => isEmpty ? null : reduce((a, b) => '$a\n$b');

  String? separateByChar(String c) =>
      isEmpty ? null : reduce((a, b) => '$a$c$b');
}

extension IntIterableExt on Iterable<int> {
  int get sum => isEmpty ? 0 : reduce((a, b) => a + b);
}

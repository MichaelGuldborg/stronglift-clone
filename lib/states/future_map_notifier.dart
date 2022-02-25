import 'package:flutter/material.dart';
import 'package:lifter/models/identifiable.dart';

class FutureMapNotifier<T extends Identifiable> extends ChangeNotifier {
  final Future<T?> Function(String id) fetch;
  final Future<List<T?>> Function()? fetchAll;
  final int Function(T a, T b)? compare;

  FutureMapNotifier({
    required this.fetch,
    this.fetchAll,
    this.compare,
  });

  final Map<String, T> _values = {};
  final Map<String, bool> _isFetching = {};
  bool isFetchingAll = false;
  bool isFetchAllFailed = false;

  Future refreshAll() async {
    if (fetchAll == null) return;
    if (isFetchingAll) return;

    isFetchingAll = true;
    final values = await fetchAll!();
    isFetchingAll = false;

    // skip update and notify if empty
    if (values.isEmpty) return;
    _values.clear();
    for (var e in values) {
      if (e == null) continue;
      if (e.id == null) continue;
      _values[e.id!] = e;
    }

    notifyListeners();
  }

  Future<void> refresh(String? id) async {
    if (id == null) return;
    if (_isFetching[id] ?? false) return;
    _isFetching[id] = true;

    final value = await fetch(id);
    _isFetching[id] = false;
    if (value == null) return;
    _values[id] = value;
    notifyListeners();
  }

  T? get(String? id) {
    if (id == null) return null;
    final user = _values[id];
    if (user == null) refresh(id);
    return user;
  }

  List<T?> getMultiple(Iterable<String?> list) {
    return list.map((e) => get(e)).toList();
  }

  List<T> get all {
    final v = _values.values.toList();
    if (v.isEmpty) refreshAll();
    v.sort(compare);
    return v;
  }

  remove(String? id) {
    if (id == null) return null;
    _values.remove(id);
    notifyListeners();
  }
}

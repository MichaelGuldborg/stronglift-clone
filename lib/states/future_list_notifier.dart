import 'package:flutter/material.dart';
import 'package:lifter/models/identifiable.dart';

class FutureListNotifier<T extends Identifiable> extends ChangeNotifier {
  final Future<List<T>> Function() fetchAll;
  final Future<T?> Function(String id)? fetch;

  FutureListNotifier({
    required this.fetchAll,
    this.fetch,
  });

  final List<T> _values = [];
  bool isFetchingAll = false;
  bool isFetchAllFailed = false;

  Future refreshAll() async {
    if (isFetchingAll) return;

    isFetchingAll = true;
    final values = await fetchAll();
    isFetchingAll = false;

    // skip update and notify if empty
    if (values.isEmpty) return;
    _values.clear();
    _values.addAll(values);

    notifyListeners();
  }

  Future<void> refresh(String? id) async {
    if (id == null) return;
    if (fetch == null) return;

    final value = await fetch!(id);
    if (value == null) return;

    final index = _values.indexWhere((e) => e.id == id);
    index == -1 ? _values.add(value) : _values[index] = value;
    notifyListeners();
  }

  T? get(String? id) {
    if (id == null) return null;
    final index = _values.indexWhere((e) => e.id == id);
    if (index != -1) return _values[index];
    refresh(id);
  }

  remove(String? id) {
    if (id == null) return null;
    _values.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  List<T> get all {
    if (_values.isEmpty) refreshAll();
    return _values;
  }
}

import 'package:flutter/material.dart';

class FutureValueNotifier<T> extends ChangeNotifier {
  final Future<T?> Function() fetch;

  FutureValueNotifier({
    required this.fetch,
  });

  T? _value;

  bool isFetching = false;

  bool isFetchFailed = false;

  T? get value {
    if (isFetchFailed) return _value;
    if (_value == null) refresh();
    return _value;
  }

  Future<void> refresh() async {
    if (isFetching) return;
    isFetching = true;
    isFetchFailed = false;
    final value = await fetch();
    if (value == null) isFetchFailed = true;
    _value = value;
    isFetching = false;
    notifyListeners();
  }
}

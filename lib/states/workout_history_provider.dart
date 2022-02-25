import 'package:flutter/material.dart';
import 'package:lifter/models/workout.dart';
import 'package:lifter/services/firebase/firestore_ref.dart';
import 'package:lifter/states/future_map_notifier.dart';
import 'package:provider/provider.dart';

List<Workout> useWorkoutHistory(BuildContext context) {
  final provider = WorkoutHistoryProvider.of(context);
  return provider.all;
}

class WorkoutHistoryProvider extends FutureMapNotifier<Workout> {
  static WorkoutHistoryProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<WorkoutHistoryProvider>(context, listen: listen);
  }

  static Future<Workout?> _fetch(String uid) async {
    final response = await FirestoreRef.history.doc(uid).get();
    return response.data();
  }

  static Future<List<Workout>> _fetchAll() async {
    final response = await FirestoreRef.history.get();
    return response.docs.map((e) => e.data()).toList();
  }

  static int _compare(Workout a, Workout b) {
    return b.end?.compareTo(a.end ?? DateTime.now()) ?? 0;
  }

  WorkoutHistoryProvider() : super(fetch: _fetch, fetchAll: _fetchAll, compare: _compare);

  Future<void> update(String? id, Map<String, dynamic> data) async {
    await FirestoreRef.history.doc(id).update(data);
    await refresh(id);
  }

  Future<void> delete(String? id) async {
    await FirestoreRef.history.doc(id).delete();
    await remove(id);
  }
}

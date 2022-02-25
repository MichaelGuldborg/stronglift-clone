import 'package:flutter/material.dart';
import 'package:lifter/models/exercise.dart';
import 'package:lifter/models/workout.dart';
import 'package:lifter/services/firebase/firestore_ref.dart';
import 'package:lifter/states/future_map_notifier.dart';
import 'package:provider/provider.dart';

List<Workout> useWorkouts(BuildContext context) {
  final provider = WorkoutProvider.of(context);
  return provider.all;
}

class WorkoutProvider extends FutureMapNotifier<Workout> {
  static WorkoutProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<WorkoutProvider>(context, listen: listen);
  }

  static Future<Workout?> _fetch(String uid) async {
    final response = await FirestoreRef.workouts.doc(uid).get();
    return response.data();
  }

  static Future<List<Workout>> _fetchAll() async {
    final response = await FirestoreRef.workouts.get();
    return response.docs.map((e) => e.data()).toList();
  }

  static int _compare(Workout a, Workout b) {
    return a.index?.compareTo(b.index ?? 0) ?? 0;
  }

  WorkoutProvider() : super(fetch: _fetch, fetchAll: _fetchAll, compare: _compare);

  Future<Workout> create() async {
    const alphabet = "ABCDEFGHIJKLMNOPQRSTUVXYZ";
    final letter = alphabet[all.length];
    final workout = Workout(name: 'Workout $letter');
    final response = await FirestoreRef.workouts.add(workout);
    await refresh(response.id);
    return workout;
  }

  Future<void> update(String? id, Map<String, dynamic> data) async {
    await FirestoreRef.workouts.doc(id).update(data);
    await refresh(id);
  }

  Future<void> updateAll(Map<String, dynamic> Function(Workout value) action) async {
    await Future.wait(all.map((e) {
      final data = action(e);
      return FirestoreRef.workouts.doc(e.id).update(data);
    }));
    await refreshAll();
  }

  Future<void> delete(String? id) async {
    await FirestoreRef.workouts.doc(id).delete();
    await remove(id);
  }

  void updateExercise(String? workoutId, String? exerciseId, Exercise Function(Exercise exercise) modify) {
    if (workoutId == null) return;
    if (exerciseId == null) return;
    final workout = get(workoutId);
    if (workout == null) return;
    final index = workout.exercises.indexWhere((e) => e.id == exerciseId);
    if (index == -1) return;
    final exercise = workout.exercises[index];
    workout.exercises[index] = modify(exercise);
    update(workoutId, workout.toMap());
  }
}

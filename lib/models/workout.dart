import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifter/models/identifiable.dart';
import 'package:lifter/services/serializer.dart';

import 'exercise.dart';

class Workout extends Identifiable {
  @override
  final String? id;
  final int? index;
  final String name;
  final List<Exercise> exercises;
  DateTime? start;
  DateTime? end;

  Workout({
    this.id,
    this.index,
    required this.name,
    this.exercises = const [],
    this.start,
    this.end,
  });

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      index: map['index'],
      name: map['name'],
      exercises: serializeList(map['exercises'], Exercise.fromMap),
      start: map['start'] == null ? null : (map['start'] as Timestamp).toDate(),
      end: map['end'] == null ? null : (map['end'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'index': index,
      'name': name,
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'start': start == null ? null : Timestamp.fromDate(start!),
      'end': end == null ? null : Timestamp.fromDate(end!),
    };
  }
}

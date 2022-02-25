import 'package:lifter/services/serializer.dart';

import 'workout.dart';

class Program {
  final String? id;
  final String? name;
  final List<Workout> workouts;
  // final Schedule schedule;

  Program({
    this.id,
    this.name,
    this.workouts = const [],
  });

  factory Program.fromMap(Map<String, dynamic> map) {
    return Program(
      id: map['id'],
      name: map['name'],
      workouts: serializeList(map['workouts'], Workout.fromMap),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'workouts': workouts,
    };
  }
}

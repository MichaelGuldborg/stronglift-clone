import 'package:lifter/models/exercise.dart';
import 'package:lifter/models/workout.dart';
import 'package:lifter/services/firebase/firestore_ref.dart';

class FirebaseFunctions {
  static Future<void> updateWorkoutExercise(Workout workout, Exercise exercise) async {
    workout.exercises.add(exercise);
    await FirestoreRef.workouts.doc(workout.id).update(workout.toMap());
  }
}

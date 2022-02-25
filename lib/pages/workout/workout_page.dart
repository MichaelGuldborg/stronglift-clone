import 'package:flutter/material.dart';
import 'package:lifter/components/buttons/secondary_button.dart';
import 'package:lifter/constants/routes.dart';
import 'package:lifter/constants/theme_colors.dart';
import 'package:lifter/models/exercise.dart';
import 'package:lifter/models/workout.dart';
import 'package:lifter/pages/workout/exercise_page.dart';
import 'package:lifter/pages/workout/workout_rep_button.dart';
import 'package:lifter/services/firebase/firestore_ref.dart';
import 'package:lifter/services/flutter_message.dart';
import 'package:lifter/states/workout_provider.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({Key? key}) : super(key: key);

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final Map<String, Map<String, int?>> _completed = {};

  void updateRep(Exercise exercise, int i) {
    final exerciseId = exercise.id;
    if (exerciseId == null) return;
    final index = i.toString();
    setState(() {
      final next = _completed[exerciseId] ?? {};
      final count = next[index];

      if (count == null) {
        next[index] = exercise.reps;
        _completed[exerciseId] = next;
        return;
      }

      if (count == 0) {
        next[index] = null;
        _completed[exerciseId] = next;
        return;
      }

      next[index] = count - 1;
      _completed[exerciseId] = next;
    });
  }

  void clearRep(Exercise exercise, int index) {
    final exerciseId = exercise.id;
    if (exerciseId == null) return;

    setState(() {
      final next = _completed[exerciseId] ?? {};
      next['$index'] = null;
      _completed[exerciseId] = next;
    });
  }

  int? getCount(Exercise exercise, int index) {
    final exerciseId = exercise.id;
    if (exerciseId == null) return null;
    final complete = _completed[exerciseId] ?? {};
    return complete['$index'];
  }

  String formatWeight(double v) {
    final isInt = v - v.truncate() == 0;
    return isInt ? v.toInt().toString() : v.toString();
  }

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)?.settings.arguments as Workout;
    final workoutId = argument.id;
    final provider = WorkoutProvider.of(context);
    final workout = provider.get(workoutId) ?? argument;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(workout.name),
        actions: [
          SecondaryButton(
            text: 'Edit',
            onPressed: () {
              Navigator.pushNamed(context, Routes.workoutEdit, arguments: workout);
            },
          ),
        ],
      ),
      body: Column(
        children: List.generate(
          workout.exercises.length,
          (index) {
            final exercise = workout.exercises[index];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        exercise.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          final argument = ExercisePageArgument(workout: workout, exercise: exercise);
                          Navigator.pushNamed(context, Routes.exercise, arguments: argument);
                        },
                        child: Text(
                          '${exercise.sets}×${exercise.reps} ${formatWeight(exercise.weight)}kg',
                          style: TextStyle(
                            color: ThemeColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      5,
                      (index) {
                        final disabled = index >= exercise.sets;
                        final count = getCount(exercise, index);
                        final isActive = count != null;

                        return WorkoutRepButton(
                          text: '${count ?? exercise.reps}',
                          isActive: isActive,
                          onTap: () => updateRep(exercise, index),
                          onLongPress: () => clearRep(exercise, index),
                          disabled: disabled,
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SecondaryButton(
              text: 'Note',
              onPressed: () {
                showError('TODO');
              },
            ),
            SecondaryButton(
              text: 'Finnish',
              onPressed: () {
                // add workout to history
                workout.end = DateTime.now();
                for (var e in workout.exercises) {
                  e.completed = _completed[e.id] ?? {};
                }
                FirestoreRef.history.add(workout);

                // update workout with increment
                provider.update(workoutId, {
                  ...workout.toMap(),
                  'exercises': workout.exercises.map((e) {
                    return {...e.toMap(), 'weight': e.weight + e.increments};
                  }).toList(),
                });

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

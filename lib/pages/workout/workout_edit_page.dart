import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:lifter/components/bottom_sheet/bottom_sheet_select.dart';
import 'package:lifter/components/buttons/fab_button.dart';
import 'package:lifter/constants/routes.dart';
import 'package:lifter/models/exercise.dart';
import 'package:lifter/models/workout.dart';
import 'package:lifter/pages/workout/exercise_page.dart';
import 'package:lifter/services/flutter_message.dart';
import 'package:lifter/states/workout_provider.dart';

class WorkoutEditPage extends StatelessWidget {
  const WorkoutEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)?.settings.arguments as Workout;
    final workoutId = argument.id;
    final provider = WorkoutProvider.of(context);
    final workout = provider.get(workoutId) ?? argument;

    return Scaffold(
      appBar: AppBar(title: Text(workout.name)),
      body: ImplicitlyAnimatedReorderableList<Exercise>(
        items: workout.exercises,
        areItemsTheSame: (a, b) => a.id == b.id,
        onReorderFinished: (item, from, to, newItems) {
          workout.exercises
            ..clear()
            ..addAll(newItems);
          provider.update(workoutId, workout.toMap());
        },
        itemBuilder: (context, animation, exercise, index) {
          return Reorderable(
            key: ValueKey(exercise.id),
            builder: (context, animation, inDrag) {
              return ListTile(
                onTap: () async {
                  final argument = ExercisePageArgument(workout: workout, exercise: exercise);
                  Navigator.pushNamed(context, Routes.exercise, arguments: argument);
                },
                leading: Handle(
                  child: Container(
                    width: 40,
                    height: 48,
                    alignment: Alignment.center,
                    child: Icon(Icons.drag_indicator),
                  ),
                ),
                title: Text(exercise.name),
                subtitle: Text('${exercise.sets} sets of ${exercise.reps} reps'),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () async {
                    final index = await showSelectBottomSheet(context, options: ['Edit', 'Delete']);
                    if (index == null) return;
                    if (index == 0) {
                      final argument = ExercisePageArgument(workout: workout, exercise: exercise);
                      Navigator.pushNamed(context, Routes.exercise, arguments: argument);
                    } else if (index == 1) {
                      workout.exercises.removeWhere((e) => e.id == exercise.id);
                      provider.update(workoutId, workout.toMap());
                    }
                  },
                ),
              );
            },
          );
        },
        footer: Column(
          children: [
            // ListTile(
            //   leading: SizedBox.shrink(),
            //   title: Text('Workout Date'),
            //   subtitle: Text('Test'),
            // ),
            Divider(),
            ListTile(
              leading: SizedBox.shrink(),
              title: Text('Reset workout'),
              onTap: () {
                showError('TODO');
              },
            ),
            ListTile(
              leading: SizedBox.shrink(),
              title: Text('Delete workout'),
              onTap: () {
                showError('TODO');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FabButton(
        text: 'Add exercise',
        onPressed: () async {
          final exercise = Exercise(id: '${workout.exercises.length}', name: 'Exercise ${workout.exercises.length}');
          workout.exercises.add(exercise);
          provider.update(workoutId, workout.toMap());
          final argument = ExercisePageArgument(workout: workout, exercise: exercise);
          Navigator.pushNamed(context, Routes.exercise, arguments: argument);
        },
      ),
    );
  }
}

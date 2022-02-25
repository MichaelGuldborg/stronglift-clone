import 'package:flutter/material.dart';
import 'package:lifter/components/bottom_sheet/bottom_sheet_simple.dart';
import 'package:lifter/components/bottom_sheet/bottom_sheet_text_field.dart';
import 'package:lifter/components/buttons/primary_button.dart';
import 'package:lifter/constants/text_styles.dart';
import 'package:lifter/constants/theme_colors.dart';
import 'package:lifter/models/exercise.dart';
import 'package:lifter/models/workout.dart';
import 'package:lifter/states/workout_provider.dart';
import 'package:numberpicker/numberpicker.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)?.settings.arguments as ExercisePageArgument;
    final provider = WorkoutProvider.of(context);
    final workout = provider.get(argument.workout.id) ?? argument.workout;
    final exercise = workout.exercises.firstWhere((e) => e.id == argument.exercise.id, orElse: () => argument.exercise);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () async {
            showTextField(
              context,
              title: 'Exercise Name',
              subtitle: 'Change the name of the exercise',
              value: exercise.name,
              onConfirm: (String s) {
                provider.updateExercise(
                  workout.id,
                  exercise.id,
                  (exercise) => exercise.copyWith(name: s),
                );
              },
            );
          },
          child: Text(exercise.name),
        ),
      ),
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              ListTile(
                title: Text('Exercise Weight'),
                subtitle: Text('${exercise.weight}kg'),
                onTap: () {
                  showTextField(
                    context,
                    title: 'Exercise Weight',
                    subtitle: 'An olympic bar weighs 20kg',
                    value: exercise.weight,
                    keyboardType: TextInputType.number,
                    isWeight: true,
                    onConfirm: (String s) {
                      final value = double.tryParse(s);
                      provider.updateExercise(
                        workout.id,
                        exercise.id,
                        (exercise) => exercise.copyWith(weight: value),
                      );
                    },
                  );
                },
              ),
              ListTile(
                title: Text('Sets×Reps'),
                subtitle: Text('${exercise.sets}×${exercise.reps}'),
                onTap: () async {
                  final result = await showModalBottomSheet<SetRepRequest?>(
                    context: context,
                    builder: (context) => SetRepForm(
                      sets: exercise.sets,
                      reps: exercise.reps,
                    ),
                  );
                  if (result == null) return;
                  provider.updateExercise(
                    workout.id,
                    exercise.id,
                    (e) => e.copyWith(sets: result.sets, reps: result.reps),
                  );
                },
              ),
              ListTile(
                title: Text('Increments'),
                subtitle: Text('${exercise.increments}kg'),
                onTap: () {
                  showTextField(
                    context,
                    title: 'Increments',
                    subtitle: 'KG added per each increment',
                    value: exercise.increments,
                    keyboardType: TextInputType.number,
                    isWeight: true,
                    onConfirm: (String s) {
                      final value = double.tryParse(s);
                      provider.updateExercise(
                        workout.id,
                        exercise.id,
                        (exercise) => exercise.copyWith(increments: value),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class SetRepRequest {
  final int sets;
  final int reps;

  SetRepRequest(this.sets, this.reps);
}

class SetRepForm extends StatefulWidget {
  final int sets;
  final int reps;

  const SetRepForm({
    Key? key,
    required this.sets,
    required this.reps,
  }) : super(key: key);

  @override
  State<SetRepForm> createState() => _SetRepFormState();
}

class _SetRepFormState extends State<SetRepForm> {
  late int sets = widget.sets;
  late int reps = widget.reps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).viewInsets,
      child: BottomSheetSimple(
        title: 'Sets×Reps',
        subtitle: 'Change the number of sets and repetitions',
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Sets',
                    style: TextStyles.bold,
                  ),
                  NumberPicker(
                    value: sets,
                    onChanged: (i) => setState(() => sets = i),
                    minValue: 1,
                    maxValue: 5,
                    selectedTextStyle: TextStyles.bold.copyWith(color: ThemeColors.primary),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(color: ThemeColors.primary, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              alignment: Alignment.center,
              child: Text(
                '×',
                style: TextStyles.bold.copyWith(fontSize: 24),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Reps',
                    style: TextStyles.bold,
                  ),
                  NumberPicker(
                    value: reps,
                    onChanged: (i) => setState(() => reps = i),
                    minValue: 1,
                    maxValue: 100,
                    selectedTextStyle: TextStyles.bold.copyWith(color: ThemeColors.primary),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(color: ThemeColors.primary, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          PrimaryButton.grey(
            text: 'Cancel',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          PrimaryButton.green(
            text: 'OK',
            onPressed: () {
              final request = SetRepRequest(sets, reps);
              Navigator.pop(context, request);
            },
          ),
        ],
      ),
    );
  }
}

class ExercisePageArgument {
  final Workout workout;
  final Exercise exercise;

  ExercisePageArgument({required this.workout, required this.exercise});
}

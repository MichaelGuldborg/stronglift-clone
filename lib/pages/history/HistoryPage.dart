import 'package:flutter/material.dart';
import 'package:lifter/components/bottom_sheet/bottom_sheet_select.dart';
import 'package:lifter/constants/theme_colors.dart';
import 'package:lifter/models/exercise.dart';
import 'package:lifter/services/date_format.dart';
import 'package:lifter/states/workout_history_provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('History'),
      ),
      body: HistoryListView(),
    );
  }
}

class HistoryListView extends StatelessWidget {
  const HistoryListView({
    Key? key,
  }) : super(key: key);

  String formatReps(Exercise exercise) {
    final completed = exercise.completed;
    if (!completed.values.any((e) => e != null)) return 'Skipped';
    return exercise.completed.keys.map((e) => completed[e] ?? '0').join('/');
  }

  @override
  Widget build(BuildContext context) {
    final provider = WorkoutHistoryProvider.of(context);
    final workouts = provider.all;

    return ListView(
      padding: EdgeInsets.only(top: 16, left: 24, right: 24),
      children: List.generate(
        workouts.length,
        (index) {
          final workout = workouts[index];
          return GestureDetector(
            onTap: () async {
              final options = ['Delete', 'Cancel'];
              final index = await showSelectBottomSheet(context, options: options);
              if (index == null || index == options.length - 1) return;
              if (index == 0) {
                provider.delete(workout.id);
              }
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: ThemeColors.shadowGrey),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          workout.name,
                          style: TextStyle(
                            fontSize: 16,
                            color: ThemeColors.textGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(DateFormat.getDateText(workout.end)),
                      ],
                    ),
                  ),
                  Column(
                    children: List.generate(
                      workout.exercises.length,
                      (index) {
                        final exercise = workout.exercises[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                exercise.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                '${formatReps(exercise)} ${exercise.weight}kg',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

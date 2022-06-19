import 'package:flutter/material.dart';
import 'package:lifter/components/buttons/fab_button.dart';
import 'package:lifter/components/buttons/secondary_button.dart';
import 'package:lifter/constants/routes.dart';
import 'package:lifter/constants/text_styles.dart';
import 'package:lifter/constants/theme_colors.dart';
import 'package:lifter/models/user.dart';
import 'package:lifter/services/date_format.dart';
import 'package:lifter/states/user_data_provider.dart';
import 'package:lifter/states/workout_provider.dart';

class HomeLandingPage extends StatelessWidget {
  const HomeLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = useCurrentUser(context);
    final workouts = useWorkouts(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Stronglift Clone', style: TextStyles.title),
        actions: [
          SecondaryButton(
            text: 'Edit',
            onPressed: () {
              Navigator.pushNamed(context, Routes.programEdit);
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 16, left: 24, right: 24),
        children: List.generate(workouts.length, (index) {
          final workout = workouts[index];
          final date = getNextWorkoutDate(currentUser?.frequency, DateTime.now(), index);
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.workout, arguments: workout),
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: index == 0 ? ThemeColors.primaryLight : ThemeColors.shadowGrey),
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
                        Text(DateFormat.getFutureDateText(date)),
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
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${exercise.sets}x${exercise.reps} ${exercise.weight}kg',
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
        }),
      ),
      floatingActionButton: FabButton(
        text: 'Start Workout',
        onPressed: () {
          Navigator.pushNamed(context, Routes.workout, arguments: workouts.first);
        },
      ),
    );
  }
}

DateTime? getNextWorkoutDate(ScheduleFrequency? frequency, DateTime previous, int index) {
  final now = DateTime.now();
  final diff = now.difference(previous);
  final days = diff.inDays;
  if (frequency == ScheduleFrequency.NONE) return null;
  if (frequency == ScheduleFrequency.EVERYDAY) {
    return now.add(Duration(days: index));
  }
  if (frequency == ScheduleFrequency.EVERY_OTHER_DAY) {
    final remainder = days % 2;
    final skipped = days - remainder;
    return previous.add(Duration(days: skipped + index * 2));
  }
  if (frequency == ScheduleFrequency.EVERY_2_DAYS) {
    final remainder = days % 3;
    final skipped = days - remainder;
    return previous.add(Duration(days: skipped + index * 3));
  }

  final weekdays = {
        ScheduleFrequency.X2WEEK: [true, false, false, true, false, false, false],
        ScheduleFrequency.X3WEEK: [true, false, true, false, true, false, false],
        ScheduleFrequency.X4WEEK: [true, false, true, false, true, true, false],
        ScheduleFrequency.X5WEEK: [true, true, true, false, true, true, false],
        ScheduleFrequency.X6WEEK: [true, true, true, true, true, true, false],
      }[frequency] ??
      [true, false, true, false, true, false, false];

  var counter = index;
  final weekdayList = List.generate(14, (index) {
    // if (index < now.weekday) return false;
    final v = weekdays[index % 7];
    if (counter <= 0) return v;
    counter--;
    return false;
  });
  final weekDay = weekdayList.indexWhere((e) => e);

  return now.add(Duration(days: weekDay));
}

import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:lifter/components/bottom_sheet/bottom_sheet_select.dart';
import 'package:lifter/components/buttons/fab_button.dart';
import 'package:lifter/constants/routes.dart';
import 'package:lifter/models/user.dart';
import 'package:lifter/models/workout.dart';
import 'package:lifter/services/flutter_message.dart';
import 'package:lifter/states/user_data_provider.dart';
import 'package:lifter/states/workout_provider.dart';

class ProgramEditPage extends StatelessWidget {
  const ProgramEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = useCurrentUser(context);
    final provider = WorkoutProvider.of(context);
    final workouts = provider.all;

    return Scaffold(
      appBar: AppBar(title: Text('Program')),
      body: ImplicitlyAnimatedReorderableList<Workout>(
        items: workouts,
        areItemsTheSame: (a, b) => a.id == b.id,
        onReorderFinished: (item, from, to, newItems) {
          provider.updateAll((value) {
            final index = newItems.indexWhere((e) => e.id == value.id);
            return {...value.toMap(), 'index': index};
          });
        },
        itemBuilder: (context, animation, workout, index) {
          return Reorderable(
            key: ValueKey(workout.id),
            builder: (context, animation, inDrag) {
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Routes.workoutEdit, arguments: workout);
                },
                leading: Handle(
                  child: Container(
                    width: 40,
                    height: 48,
                    alignment: Alignment.center,
                    child: Icon(Icons.drag_indicator),
                  ),
                ),
                title: Text(
                  workout.name,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  workout.exercises.map((e) => e.name).join(', '),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () async {
                    final index = await showSelectBottomSheet(context, options: ['Edit', 'Delete']);
                    if (index == null) return;
                    if (index == 0) {
                      Navigator.pushNamed(context, Routes.workoutEdit, arguments: workout);
                    } else if (index == 1) {
                      provider.delete(workout.id);
                    }
                  },
                ),
              );
            },
          );
        },
        footer: Column(
          children: [
            ListTile(
              leading: SizedBox.shrink(),
              title: Text('Schedule'),
              subtitle: Text(frequencyToString(currentUser?.frequency)),
              onTap: () {
                Navigator.pushNamed(context, Routes.scheduleEdit);
              },
            ),
            Divider(),
            ListTile(
              leading: SizedBox.shrink(),
              title: Text('Reset Program'),
              onTap: () {
                showError('TODO');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FabButton(
        text: 'Add workout',
        onPressed: () async {
          final workout = await provider.create();
          Navigator.pushNamed(context, Routes.workoutEdit, arguments: workout);
        },
      ),
    );
  }
}

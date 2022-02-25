import 'package:flutter/material.dart';
import 'package:lifter/models/user.dart';
import 'package:lifter/services/firebase/firebase_auth_functions.dart';
import 'package:lifter/states/user_data_provider.dart';

class ScheduleEditPage extends StatelessWidget {
  const ScheduleEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = UserDataProvider.of(context);
    final currentUser = provider.currentUser;
    final currentIndex = currentUser?.frequency.index;

    return Scaffold(
      appBar: AppBar(title: Text('Schedule')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        children: List.generate(ScheduleFrequency.values.length, (index) {
          if (index == 0) return SizedBox.shrink();
          return GestureDetector(
            onTap: () {
              FirebaseAuthFunctions.updateUser({'frequency': index});
              provider.refresh(currentUser?.id);
            },
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Radio(value: index, groupValue: currentIndex, onChanged: (i) {}),
                  Text(frequencyToString(ScheduleFrequency.values[index])),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

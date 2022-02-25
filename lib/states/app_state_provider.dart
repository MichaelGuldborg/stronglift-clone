
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lifter/states/user_data_provider.dart';
import 'package:lifter/states/workout_history_provider.dart';
import 'package:lifter/states/workout_provider.dart';
import 'package:provider/provider.dart';

class AppStateProvider extends StatelessWidget {
  final Widget child;

  const AppStateProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserDataProvider()),
          ChangeNotifierProvider(create: (context) => WorkoutProvider()),
          ChangeNotifierProvider(create: (context) => WorkoutHistoryProvider()),
        ],
        child: child,
      ),
    );
  }
}

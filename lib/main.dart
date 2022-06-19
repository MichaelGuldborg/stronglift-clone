import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifter/constants/routes.dart';
import 'package:lifter/constants/theme.dart';
import 'package:lifter/pages/auth/auth_forgot_password_page.dart';
import 'package:lifter/pages/auth/auth_login_email_page.dart';
import 'package:lifter/pages/auth/auth_splash_page.dart';
import 'package:lifter/pages/auth_register/auth_register_email_page.dart';
import 'package:lifter/pages/auth_register/auth_register_page.dart';
import 'package:lifter/pages/error/error_page_not_found.dart';
import 'package:lifter/pages/home/home_page.dart';
import 'package:lifter/pages/workout/exercise_page.dart';
import 'package:lifter/pages/workout/program_edit_page.dart';
import 'package:lifter/pages/workout/schedule_edit_page.dart';
import 'package:lifter/pages/workout/workout_edit_page.dart';
import 'package:lifter/pages/workout/workout_page.dart';
import 'package:lifter/states/app_state_provider.dart';

import 'firebase_options.dart';

void main() async {
  // Initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Setup firebase crashlytics
  // if (!kIsWeb) {
  //   FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  //   FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
  // }

  // Disable horizontal orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppStateProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'StrongLift',
        theme: theme,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
          builder: (context) => ErrorPageNotFound(name: settings.name),
        ),
        initialRoute: Routes.splash,
        routes: {
          // auth
          Routes.splash: (context) => const AuthSplashPage(),
          Routes.authLoginEmail: (context) => const AuthLoginEmailPage(),
          Routes.authRegister: (context) => const AuthRegisterPage(),
          Routes.authRegisterEmail: (context) => const AuthRegisterEmailPage(),
          Routes.authForgotPassword: (context) =>
              const AuthForgotPasswordPage(),

          // home
          Routes.home: (context) => HomePage(),
          Routes.programEdit: (context) => ProgramEditPage(),
          Routes.scheduleEdit: (context) => ScheduleEditPage(),
          Routes.workout: (context) => WorkoutPage(),
          Routes.workoutEdit: (context) => WorkoutEditPage(),
          Routes.exercise: (context) => ExercisePage(),

          // error
          Routes.errorPageNotFound: (context) => const ErrorPageNotFound(),
        },
      ),
    );
  }
}

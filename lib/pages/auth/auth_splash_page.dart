import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifter/components/app_logo.dart';
import 'package:lifter/constants/routes.dart';

class AuthSplashPage extends StatefulWidget {
  const AuthSplashPage({Key? key}) : super(key: key);

  @override
  _AuthSplashPageState createState() => _AuthSplashPageState();
}

class _AuthSplashPageState extends State<AuthSplashPage> {
  bool loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Delay for visual effect
    Future.delayed(
      const Duration(seconds: 1),
      // () => Navigator.pushReplacementNamed(context, Routes.auth_login_email),
      navigate,
    );
  }

  void navigate() async {
    final isAuthenticated = FirebaseAuth.instance.currentUser?.uid != null;
    if (isAuthenticated) {
      Navigator.pushReplacementNamed(context, Routes.home);
    } else {
      Navigator.pushReplacementNamed(context, Routes.authRegister);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 32),
            child: const AppLogo(),
          ),
          Visibility(
            visible: loading,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

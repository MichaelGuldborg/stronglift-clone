import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifter/constants/routes.dart';
import 'package:lifter/pages/auth/auth_base_page.dart';
import 'package:lifter/pages/auth/auth_button.dart';
import 'package:lifter/pages/auth/auth_text_button.dart';
import 'package:lifter/pages/auth/auth_text_field.dart';
import 'package:lifter/services/analytics.dart';
import 'package:lifter/services/flutter_message.dart';

class AuthLoginEmailPage extends StatefulWidget {
  const AuthLoginEmailPage({Key? key}) : super(key: key);

  @override
  _AuthLoginEmailPageState createState() => _AuthLoginEmailPageState();
}

class _AuthLoginEmailPageState extends State<AuthLoginEmailPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordFocus = FocusNode();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return BaseAuthPage(
      loading: _loading,
      onTitleTap: () {
        _email.text = 'mgivskud9@gmail.com';
        _password.text = 'Password1';
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: AuthTextField(
                controller: _email,
                onEditingComplete: () => _passwordFocus.requestFocus(),
                hintText: 'Email',
              ),
            ),
            AuthTextField(
              controller: _password,
              focusNode: _passwordFocus,
              hintText: 'Password',
              obscureText: true,
            ),
            AuthTextButton(
              text: 'Forgot your password?',
              onPressed: () {
                Analytics.trackEvent('click_auth_login_email_forgot_password');
                Navigator.pushNamed(context, Routes.authForgotPassword);
              },
            ),
          ],
        ),
      ),
      bottom: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthButton(
            text: 'Log ind',
            onPressed: () async {
              Analytics.trackEvent('click_auth_login_email_login');

              final email = _email.text.trim().toLowerCase();
              final password = _password.text.trim();

              // is not valid email
              if (email.isEmpty) {
                showError('Email cannot be empty');
                return;
              }

              // is not valid password
              if (password.isEmpty) {
                showError('Password cannot be empty');
                return;
              }

              setState(() => _loading = true);
              final response = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password)
                  .catchError((error) {
                showError(error.toString());
              });
              setState(() => _loading = false);
              if (response.user == null) {
                return;
              }

              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(context, Routes.home);
            },
          ),
        ],
      ),
    );
  }
}

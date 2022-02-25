import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifter/pages/auth/auth_base_page.dart';
import 'package:lifter/pages/auth/auth_button.dart';
import 'package:lifter/pages/auth/auth_text_button.dart';
import 'package:lifter/pages/auth/auth_text_field.dart';
import 'package:lifter/services/analytics.dart';
import 'package:lifter/services/flutter_message.dart';

class AuthForgotPasswordPage extends StatefulWidget {
  const AuthForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _AuthForgotPasswordPageState createState() => _AuthForgotPasswordPageState();
}

class _AuthForgotPasswordPageState extends State<AuthForgotPasswordPage> {
  final _email = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return BaseAuthPage(
      loading: _loading,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 40, bottom: 80),
              child: Text(
                'Enter your email to receive a link to reset your password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            AuthTextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Email',
            ),
          ],
        ),
      ),
      bottom: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthButton(
            text: 'reset password',
            onPressed: _resetPress,
          ),
          AuthTextButton(
            text: 'back',
            onPressed: () {
              Analytics.trackEvent('click_auth_forgot_password_back');
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  _resetPress() async {
    final email = _email.text.trim().toLowerCase();

    setState(() => _loading = true);
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    setState(() => _loading = false);
    showSuccess('Check your email for instructions on resetting your password');
  }
}



import 'package:flutter/material.dart';
import 'package:lifter/pages/auth/auth_button.dart';

class RegisterBaseView extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onPressed;

  const RegisterBaseView({
    Key? key,
    required this.title,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  height: 1.4,
                ),
              ),
            ),
            child,
            Container(
              margin: EdgeInsets.only(bottom: 8),
              child: AuthButton(
                text: 'Continue',
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

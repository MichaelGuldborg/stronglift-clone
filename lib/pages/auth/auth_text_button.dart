import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';

class AuthTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const AuthTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onPressed: onPressed,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 15,
            color: Colors.white.withOpacity(0.6),
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2
          ),
        ),
      ),
    );
  }
}

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:lifter/constants/theme_colors.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool enabled;

  const AuthButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      duration: Duration(milliseconds: 150),
      onPressed: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        margin: const EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: enabled ? Colors.white : Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(100),
          boxShadow: enabled ? ThemeColors.boxShadow : null,
        ),
        child: Text(
          text.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: enabled ? ThemeColors.primaryDark : ThemeColors.black.withOpacity(0.3),
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
      ),
    );
  }
}

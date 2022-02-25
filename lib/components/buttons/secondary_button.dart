import 'package:flutter/material.dart';
import 'package:lifter/constants/theme_colors.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const SecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = ThemeColors.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
        text,
        style: TextStyle(
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

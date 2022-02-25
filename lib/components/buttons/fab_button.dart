import 'package:flutter/material.dart';
import 'package:lifter/constants/theme_colors.dart';

class FabButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const FabButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = ThemeColors.primary,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(120)),
      color: color,
      focusColor: color,
      hoverColor: color,
      highlightColor: color.withOpacity(0.4),
      splashColor: Colors.white.withOpacity(0.4),
      elevation: 6,
      highlightElevation: 0,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

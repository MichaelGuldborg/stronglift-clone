import 'package:flutter/material.dart';
import 'package:lifter/constants/theme_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = ThemeColors.primary,
    this.textColor = Colors.white,
  }) : super(key: key);

  static Widget green({
    required text,
    required onPressed,
  }) {
    return PrimaryButton(
      text: text,
      onPressed: onPressed,
      color: ThemeColors.green,
      textColor: Colors.white,
    );
  }

  static Widget grey({
    required text,
    required onPressed,
  }) {
    return PrimaryButton(
      text: text,
      onPressed: onPressed,
      color: ThemeColors.lightGrey,
      textColor: Colors.black,
    );
  }

  static Widget red({
    required text,
    required onPressed,
  }) {
    return PrimaryButton(
      text: text,
      onPressed: onPressed,
      color: ThemeColors.lightRed,
      textColor: ThemeColors.darkRed,
    );
  }

  static Widget white({
    required text,
    required onPressed,
  }) {
    return PrimaryButton(
      text: text,
      onPressed: onPressed,
      color: Colors.white,
      textColor: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: color,
      focusColor: color,
      hoverColor: color,
      highlightColor: color.withOpacity(0.4),
      splashColor: Colors.white.withOpacity(0.4),
      elevation: 0,
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

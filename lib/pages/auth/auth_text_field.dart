import 'package:flutter/material.dart';
import 'package:lifter/constants/theme_colors.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;

  const AuthTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.onEditingComplete,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        keyboardType: keyboardType,
        autocorrect: false,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        cursorColor: ThemeColors.primary,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: ThemeColors.backgroundGrey,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          fillColor: Colors.transparent,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
      ),
    );
  }
}

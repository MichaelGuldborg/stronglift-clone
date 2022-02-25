import 'package:flutter/material.dart';
import 'package:lifter/constants/theme_colors.dart';
import 'package:lifter/pages/auth_register/auth_register_base_view.dart';
import 'package:lifter/services/date_format.dart';

class AuthRegisterBirthDateView extends StatefulWidget {
  final void Function(DateTime birthDate) onConfirm;

  const AuthRegisterBirthDateView({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<AuthRegisterBirthDateView> createState() => _AuthRegisterBirthDateViewState();
}

class _AuthRegisterBirthDateViewState extends State<AuthRegisterBirthDateView> {
  DateTime? birthDate;

  @override
  Widget build(BuildContext context) {
    return RegisterBaseView(
      title: 'When should we celebrate your birthdate?',
      child: GestureDetector(
        onTap: () async {
          final result = await showDatePicker(
            context: context,
            initialDate: birthDate ?? DateTime(DateTime.now().year - 18),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (result == null) return;
          setState(() {
            birthDate = result;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ThemeColors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            height: 56,
            alignment: Alignment.center,
            child: Text(
              birthDate == null ? 'Your birth date' : DateFormat.getDateText(birthDate),
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.85),
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
      onPressed: () {
        if (birthDate == null) return;
        widget.onConfirm(birthDate!);
      },
    );
  }
}

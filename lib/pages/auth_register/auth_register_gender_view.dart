import 'package:flutter/material.dart';
import 'package:lifter/constants/theme_colors.dart';
import 'package:lifter/pages/auth_register/auth_register_base_view.dart';

class AuthRegisterGenderView extends StatefulWidget {
  final void Function(String gender) onConfirm;

  const AuthRegisterGenderView({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<AuthRegisterGenderView> createState() => _AuthRegisterGenderViewState();
}

class _AuthRegisterGenderViewState extends State<AuthRegisterGenderView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return RegisterBaseView(
      title: 'What\'s your gender?',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          final isActive = currentIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.white.withOpacity(0.0),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Icon(
                        [Icons.male, Icons.female, Icons.transgender][index],
                        size: 48,
                        color: isActive ? ThemeColors.primary : Colors.white,
                      ),
                    ),
                    Text(
                      ['Male', 'Female', 'Other'][index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isActive ? ThemeColors.primary : Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
      onPressed: () {
        widget.onConfirm(['male', 'female', 'other'][currentIndex]);
      },
    );
  }
}

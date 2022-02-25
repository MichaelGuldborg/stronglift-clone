import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lifter/constants/routes.dart';
import 'package:lifter/constants/theme_colors.dart';
import 'package:lifter/models/register_request.dart';
import 'package:lifter/pages/auth_register/auth_register_birth_date_view.dart';
import 'package:lifter/pages/auth_register/auth_register_gender_view.dart';
import 'package:lifter/pages/auth_register/auth_register_name_view.dart';

class AuthRegisterPage extends StatefulWidget {
  const AuthRegisterPage({Key? key}) : super(key: key);

  @override
  State<AuthRegisterPage> createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends State<AuthRegisterPage> {
  final steps = 3;
  final _controller = PageController(initialPage: 0);
  int currentIndex = 0;
  RegisterRequest request = RegisterRequest();

  void back() {
    _controller.previousPage(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
    setState(() {
      currentIndex = max(0, currentIndex - 1);
    });
  }

  void next() {
    _controller.nextPage(
      duration: Duration(milliseconds: 400),
      curve: Curves.ease,
    );
    setState(() {
      currentIndex = min(steps, currentIndex + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_controller.offset.floor() == 0) return true;
        back();
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(leading: BackButton(color: Colors.white)),
        body: Container(
          decoration: BoxDecoration(
            gradient: ThemeColors.backgroundGradient,
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  children: [
                    AuthRegisterNameView(
                      onConfirm: (String firstName, String lastName) {
                        request.firstName = firstName;
                        request.lastName = lastName;
                        next();
                      },
                    ),
                    AuthRegisterGenderView(
                      onConfirm: (gender) {
                        request.gender = gender;
                        next();
                      },
                    ),
                    AuthRegisterBirthDateView(
                      onConfirm: (birthDate) {
                        request.birthDate = birthDate;
                        Navigator.pushNamed(context, Routes.authRegisterEmail, arguments: request);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(steps, (index) {
                    final isActive = index <= currentIndex;
                    return Container(
                      width: 8,
                      height: 8,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: isActive ? Colors.white.withOpacity(0.85) : Colors.white30,
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

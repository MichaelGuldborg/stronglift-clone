import 'dart:math';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lifter/components/loading/loading_overlay.dart';
import 'package:lifter/constants/routes.dart';
import 'package:lifter/constants/theme_colors.dart';
import 'package:lifter/models/register_request.dart';
import 'package:lifter/pages/auth/auth_button.dart';
import 'package:lifter/pages/auth/auth_text_field.dart';
import 'package:lifter/services/analytics.dart';
import 'package:lifter/services/firebase/firebase_auth_functions.dart';
import 'package:lifter/services/flutter_message.dart';

class AuthRegisterEmailPage extends StatefulWidget {
  const AuthRegisterEmailPage({Key? key}) : super(key: key);

  @override
  _AuthRegisterEmailPageState createState() => _AuthRegisterEmailPageState();
}

class _AuthRegisterEmailPageState extends State<AuthRegisterEmailPage> {
  bool _loading = false;
  final _email = TextEditingController();
  final _password = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    return LoadingOverlay(
      loading: _loading,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: BackButton(color: Colors.white),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            gradient: ThemeColors.backgroundGradient,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 64, bottom: 16),
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () async {
                    if (!kDebugMode) return;
                    _email.text = 'mgivskud9+${Random().nextInt(1000)}@gmail.com';
                    _password.text = 'Password1';
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    width: isKeyboardVisible ? 0 : 80,
                    height: isKeyboardVisible ? 0 : 80,
                    padding: const EdgeInsets.only(left: 8, top: 16, bottom: 16, right: 16),
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   shape: BoxShape.circle,
                    //   gradient: ThemeColors.whiteGradient,
                    //   boxShadow: ThemeColors.boxShadow,
                    // ),
                    // child: AppLogo(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (!kDebugMode) return;
                  _email.text = 'mgivskud9+${Random().nextInt(1000)}@gmail.com';
                  _password.text = 'Password1';
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Welcome to your new lifting tracker',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthTextField(
                      controller: _email,
                      focusNode: _emailFocus,
                      hintText: 'Email',
                      onEditingComplete: () => FocusScope.of(context).requestFocus(_passwordFocus),
                    ),
                    AuthTextField(
                      controller: _password,
                      focusNode: _passwordFocus,
                      hintText: 'Password',
                      obscureText: true,
                      onEditingComplete: _registerPress,
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 400),
                opacity: isKeyboardVisible ? 1 : 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  height: isKeyboardVisible ? 190 : 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 8),
                          child: Text(
                            'The password is required to be at least 8 characters long',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      BouncingWidget(
                        onPressed: _registerPress,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: ThemeColors.boxShadow,
                          ),
                          child: Icon(
                            Icons.check,
                            color: ThemeColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 32, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthButton(
                      text: 'create account',
                      onPressed: _registerPress,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _registerPress() async {
    Analytics.trackEvent('click_auth_register_email_confirm');
    FocusScope.of(context).unfocus();
    final request = ModalRoute.of(context)?.settings.arguments as RegisterRequest;
    request.email = _email.text.trim().toLowerCase();
    request.password = _password.text.trim();

    setState(() => _loading = true);
    try {
      await FirebaseAuthFunctions.registerUser(request);
    } catch (e) {
      showError(e.toString());
    }
    setState(() => _loading = false);

    Navigator.pushReplacementNamed(context, Routes.home);
  }
}

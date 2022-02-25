
import 'package:flutter/material.dart';
import 'package:lifter/pages/auth_register/auth_register_base_view.dart';
import 'package:lifter/pages/auth/auth_text_field.dart';

class AuthRegisterNameView extends StatelessWidget {
  final _name = TextEditingController();
  final void Function(String firstName, String lastName) onConfirm;

  AuthRegisterNameView({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegisterBaseView(
      title: 'Nice to meet you! What do your friends call you?',
      child: AuthTextField(
        controller: _name,
        hintText: 'Your name...',
      ),
      onPressed: () {
        final text = _name.text.trim();
        final split = text.split(' ');
        final firstName = split.first;
        final lastName = split.sublist(1).join(' ');
        onConfirm(firstName, lastName);
      },
    );
  }
}

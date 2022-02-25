import 'package:flutter/material.dart';

class BaseErrorPage extends StatelessWidget {
  final String title;
  final String message;
  final Widget child;
  final Widget button;

  const BaseErrorPage({
    Key? key,
    required this.title,
    required this.message,
    required this.child,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 32),
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: child,
              ),
            ),
            button,
          ],
        ),
      ),
    );
  }
}

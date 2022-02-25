import 'package:flutter/material.dart';
import 'package:lifter/pages/error/base_error_page.dart';

class ErrorPageNotFound extends StatelessWidget {
  final String? name;

  const ErrorPageNotFound({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseErrorPage(
      title: 'Page not found',
      message: 'We could not find the page $name, it might have been removed',
      child: Container(),
      button: MaterialButton(
        child: const Text('Back'),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}

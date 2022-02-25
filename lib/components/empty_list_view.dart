import 'package:flutter/material.dart';

class EmptyListView extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;

  const EmptyListView({
    Key? key,
    required this.title,
    required this.subtitle,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        )
      ],
    );
  }
}

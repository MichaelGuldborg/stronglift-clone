import 'package:flutter/material.dart';
import 'package:lifter/constants/theme_colors.dart';

class FilterButton extends StatelessWidget {
  final IconData icon;
  final bool value;
  final VoidCallback onTap;

  final String? text;
  final double size = 56;
  final Color activeColor;

  const FilterButton({
    Key? key,
    required this.icon,
    required this.value,
    required this.onTap,
    this.text,
    this.activeColor = ThemeColors.green,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = value ? activeColor : Colors.black45;
    final color = value ? activeColor : Colors.black12;

    const activeShadow = BoxShadow(
      color: Colors.black38,
      offset: Offset(0, 1),
      spreadRadius: -1,
      blurRadius: 4,
    );

    const inactiveShadow = BoxShadow(
      color: Colors.black45,
      offset: Offset(0, 4),
      spreadRadius: -12,
      blurRadius: 30,
    );

    final boxShadow = value ? [activeShadow] : [inactiveShadow];

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: size,
        height: size,
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: boxShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: color),
            Visibility(
              visible: text != null,
              child: Container(
                margin: const EdgeInsets.only(top: 6),
                child: Text(
                  text ?? "",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

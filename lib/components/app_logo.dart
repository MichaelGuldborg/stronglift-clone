import 'package:flutter/material.dart';
import 'package:lifter/constants/theme_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final Color color;

  const AppLogo({
    Key? key,
    this.size = 80,
    this.color = ThemeColors.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.xor),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.xor),
        child: FlutterLogo(size: size),
      ),
    );
  }
}

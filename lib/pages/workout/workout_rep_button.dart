import 'package:flutter/material.dart';
import 'package:lifter/constants/theme_colors.dart';

class WorkoutRepButton extends StatefulWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final bool disabled;

  const WorkoutRepButton({
    Key? key,
    required this.text,
    required this.isActive,
    required this.onTap,
    this.onLongPress,
    this.disabled = false,
  }) : super(key: key);

  @override
  State<WorkoutRepButton> createState() => _WorkoutRepButtonState();
}

class _WorkoutRepButtonState extends State<WorkoutRepButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ColorTween backgroundColor = ColorTween(begin: Color(0xffeeeeee), end: ThemeColors.primary);
  ColorTween textColor = ColorTween(begin: Color(0xffcccccc), end: Colors.white);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    backgroundColor.animate(_controller);
    textColor.animate(_controller);
    _controller.addListener(() {
      setState(() {});
    });
  }

  void animate() {
    if (widget.isActive) {
      final isAtUpper = _controller.value == _controller.upperBound;
      if (isAtUpper) return;
      _controller.forward();
    } else {
      final isAtLower = _controller.value == _controller.lowerBound;
      if (isAtLower) return;
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    const double size = 52.0;
    animate();

    if (widget.disabled) {
      return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color(0xffeeeeee).withOpacity(0.5),
        ),
        child: Icon(
          Icons.close,
          color: Color(0xffcccccc).withOpacity(0.5),
          size: 18,
        ),
      );
    }

    return Material(
      color: backgroundColor.evaluate(_controller),
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        splashColor: Colors.white.withOpacity(0.3),
        splashFactory: InkRipple.splashFactory,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 18,
              color: textColor.evaluate(_controller),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

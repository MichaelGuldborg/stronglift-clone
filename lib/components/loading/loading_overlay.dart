import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool loading;
  final double size;
  final BoxShape shape;

  const LoadingOverlay({
    Key? key,
    required this.child,
    this.loading = false,
    this.size = double.maxFinite,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: loading,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(60),
              shape: shape,
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}

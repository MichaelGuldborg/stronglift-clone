import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lifter/components/app_logo.dart';
import 'package:lifter/components/loading/loading_overlay.dart';
import 'package:lifter/constants/theme_colors.dart';

class BaseAuthPage extends StatelessWidget {
  final Widget child;
  final Widget? bottom;
  final bool loading;
  final VoidCallback? onTitleTap;

  const BaseAuthPage({
    Key? key,
    required this.child,
    this.bottom,
    this.loading = false,
    this.onTitleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    return LoadingOverlay(
      loading: loading,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(iconTheme: IconThemeData(color: Colors.white),),
        body: Container(
          decoration: BoxDecoration(gradient: ThemeColors.backgroundGradient),
          child: Column(
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: isKeyboardVisible ? 0 : 1,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  height: isKeyboardVisible ? 0 : 120,
                  margin: EdgeInsets.only(top: kToolbarHeight),
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: kDebugMode ? onTitleTap : null,
                    child: const AppLogo(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: child,
              ),
              Visibility(
                visible: bottom != null,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: bottom ?? const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

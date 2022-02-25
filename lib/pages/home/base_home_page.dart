import 'package:flutter/material.dart';
import 'package:lifter/components/loading/loading_overlay.dart';

class BaseHomePage extends StatelessWidget {
  final String title;
  final Widget child;
  final bool loading;

  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onAddPress;
  final VoidCallback? onTitleTap;

  const BaseHomePage({
    Key? key,
    required this.title,
    required this.child,
    this.loading = false,
    this.leading,
    this.actions,
    this.onAddPress,
    this.onTitleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double toolbarHeight = 80;
    actions?.add(const SizedBox(width: 16));
    return LoadingOverlay(
      loading: loading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(toolbarHeight),
          child: Container(
            height: toolbarHeight,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xfff9fafb),
              // 0 -1px 0 0 #dfe1e6
              boxShadow: [
                BoxShadow(
                  color: Color(0x29171933),
                  offset: Offset(0, 0),
                  blurRadius: 20,
                )
              ],
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 6, bottom: 6),
              child: AppBar(
                leading: leading,
                actions: actions,
                centerTitle: true,
                title: GestureDetector(
                  onTap: onTitleTap,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            child,
            Visibility(
              visible: onAddPress != null,
              child: PositionedAddButton(
                onTap: onAddPress ?? () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PositionedAddButton extends StatelessWidget {
  final VoidCallback onTap;

  const PositionedAddButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              // 0 2px 10px 0 rgba(0, 0, 0, 0.1)
              boxShadow: [
                BoxShadow(
                  color: Color(0x19000000),
                  offset: Offset(0, 2),
                  blurRadius: 10,
                  spreadRadius: 0,
                )
              ]),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BottomSheetCheckBox extends StatelessWidget {
  final bool disabled;
  final bool checked;

  const BottomSheetCheckBox({
    Key? key,
    this.checked = false,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !disabled,
      replacement: Icon(Icons.close),
      child: checked ? Icon(Icons.check) : SizedBox.shrink(),
    );
  }
}

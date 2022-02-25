import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifter/components/bottom_sheet/bottom_sheet_simple.dart';
import 'package:lifter/components/buttons/primary_button.dart';

void showTextField(
  BuildContext context, {
  required String title,
  required String subtitle,
  Object? value,
  Function(String text)? onConfirm,
  TextInputType keyboardType = TextInputType.text,
  bool isWeight = false,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Container(
      padding: MediaQuery.of(context).viewInsets,
      child: BottomSheetTextField(
        title: title,
        subtitle: subtitle,
        value: value.toString(),
        onConfirm: onConfirm,
        keyboardType: keyboardType,
        isWeight: isWeight,
      ),
    ),
  );
}

class BottomSheetTextField extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function(String text)? onConfirm;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isWeight;

  BottomSheetTextField({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onConfirm,
    String value = '',
    this.keyboardType = TextInputType.text,
    this.isWeight = false,
  })  : controller = TextEditingController()..text = value,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheetSimple(
      title: title,
      subtitle: subtitle,
      actions: [
        PrimaryButton.grey(
          text: 'Cancel',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        PrimaryButton.green(
          text: 'OK',
          onPressed: () {
            final value = controller.value.text;
            onConfirm!(value);
            Navigator.pop(context, value);
          },
        ),
      ],
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
            ),
          ),
          Visibility(
            visible: isWeight && keyboardType == TextInputType.number,
            child: WeightFieldButtons(
              onTap: (v) {
                final value = double.parse(controller.value.text);
                controller.text = (value + v).toString();
              },
            ),
          )
        ],
      ),
    );
  }
}

class WeightFieldButtons extends StatelessWidget {
  final void Function(double value) onTap;

  const WeightFieldButtons({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              child: Text('-2.5kg', style: TextStyle(color: Colors.black)),
              style: TextButton.styleFrom(padding: EdgeInsets.all(12)),
              onPressed: () => onTap(-2.5),
            ),
          ),
          SizedBox(width: 24),
          Expanded(
            child: TextButton(
              child: Text('+2.5kg', style: TextStyle(color: Colors.black)),
              style: TextButton.styleFrom(padding: EdgeInsets.all(12)),
              onPressed: () => onTap(2.5),
            ),
          ),
        ],
      ),
    );
  }
}

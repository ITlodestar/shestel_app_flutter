import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    required this.label,
    this.contentPadding,
    this.value,
    this.onTap,
    this.activeColor,
    this.fontSize,
    this.gap = 4.0,
    this.bold = false,
    this.isChecked = false,
  });

  final String label;
  final EdgeInsets? contentPadding;
  final bool? value;
  final Function? onTap;
  final Color? activeColor;
  final double? fontSize;
  final double gap;
  final bool bold;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => onTap(!value),
      child: Padding(
        padding: contentPadding ?? const EdgeInsets.all(0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Checkbox(
              value: isChecked,
              activeColor: activeColor,
              visualDensity: VisualDensity.compact,
              onChanged: (isChecked) => isChecked,
            ),
            SizedBox(
              width: gap,
            ), // you can control gap between checkbox and label with this field
            Flexible(
              child: Text(label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  color: MyColors.textcolor
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
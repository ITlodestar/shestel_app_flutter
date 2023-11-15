import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
import 'CustomTexts.dart';
class ContentBox extends StatelessWidget {
  final String title;
  final bool checked;
  Function(bool?) onChanged;
  ContentBox({
    required this.title,
    required this.onChanged,
    required this.checked,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
                color: MyColors.bordercolor
            ),
            borderRadius: BorderRadius.circular(4)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [

                hSizedBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ParagraphText(text: title, fontSize: 18, fontFamily: 'semibold',),
                  ],
                )
              ],
            ),
            Theme(
              data: Theme.of(context).copyWith(
                  unselectedWidgetColor: MyColors.primaryColor,
                  backgroundColor: Colors.white
              ),
              child: Checkbox(
                checkColor: Colors.white,
                // fillColor: MaterialStateProperty.resolveWith(getColor),
                value: checked,
                activeColor: MyColors.primaryColor,
                onChanged: onChanged,
              ),
            )


          ],
        ),
      ),
    );
  }
}

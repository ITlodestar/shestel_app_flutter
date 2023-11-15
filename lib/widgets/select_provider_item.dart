import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sized_box.dart';
import 'CustomTexts.dart';
import 'buttons.dart';
class SelectProviderBox extends StatelessWidget {
  final Map provider;
  final bool? checked;
  Function(bool?) onChanged;
  SelectProviderBox({
    required this.provider,
    required this.onChanged,
    this.checked=false,
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    height:36,
                    width:44,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: MyColors.bordercolor
                        ),
                        borderRadius: BorderRadius.circular(4)
                    ),

                    child: Image.network(provider['logo_path'], height: 36, width: 44,),
                  ),
                ),
                hSizedBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      ParagraphText(text: provider['provider_name'], fontSize: 13, fontFamily: 'light',),
                    // ParagraphText(text: '\$15', fontSize: 13, fontFamily: 'medium', color: MyColors.primaryColor,)
                  ],
                )
              ],
            ),
            Theme(
              data:  Theme.of(context).copyWith(
                  unselectedWidgetColor: MyColors.primaryColor,
                  backgroundColor: Colors.white
              ),
              child:  Checkbox(
                checkColor: Colors.white,
                // fillColor: MaterialStateProperty.resolveWith(getColor),
                value: checked,
                activeColor: MyColors.primaryColor,
                onChanged: onChanged,
                    // (bool? value) {

                // },
              ),
            ),


          ],
        ),
      ),
    );
  }
}

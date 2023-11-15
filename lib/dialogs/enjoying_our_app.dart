import 'package:flutter/material.dart';

import '../constants/sized_box.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';

final SimpleDialog dialog1 = SimpleDialog(
  backgroundColor: Colors.transparent,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  insetPadding: EdgeInsets.all(0),
  contentPadding: EdgeInsets.all(30),
  // title: Text('Allow Liza to see', textAlign: TextAlign.center,),
  children: [
    SimpleDialogItem(),
  ],
);
class SimpleDialogItem extends StatelessWidget {
  TextEditingController codeController = TextEditingController();
  TextEditingController namecontroller = TextEditingController();

  get selectedValue => null;

  @override
  Widget build(BuildContext context) {

    return SimpleDialogOption(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height - 470,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          // border: Border.all(
          //     color: MyColors.primaryColor
          // ),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            vSizedBox2,
            vSizedBox2,
            ParagraphText(
              text: 'Enjoying our app?',
              fontSize: 20,fontFamily: 'semibold',
              color: Colors.black,
            ),
            vSizedBox,
            ParagraphText(
              text: 'Tap a star to rate it within the\napp store.',
              fontSize: 14,
              fontFamily: 'regular',
              color: Colors.black,
              textAlign: TextAlign.center,
            ),
            vSizedBox2,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star_outlined, color: Colors.amber, size: 30,
                ),
                Icon(
                  Icons.star_outlined, color: Colors.amber, size: 30,
                ),
                Icon(
                  Icons.star_outlined, color: Colors.amber, size: 30,
                ),
                Icon(
                  Icons.star_outline_outlined, color: Colors.amber, size: 30,
                ),
                Icon(
                  Icons.star_outline_outlined, color: Colors.amber, size: 30,
                ),
              ],
            ),
            vSizedBox2,
            RoundEdgedButton(
              width: 150,
              text: 'Submit',
              textColor: Colors.white,
              fontSize: 16,
              height: 30,
              verticalPadding: 0,
              borderRadius: 10,
              horizontalPadding: 0,
              onTap: (){
                Navigator.pop(context);
                // push(context: context, screen: Email_Confirmation_Page());
              },
            )

          ],
        ),
      ),
      // onPressed: onPressed,

    );
  }

  void setState(Null Function() param0) {}
}
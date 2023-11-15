import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/forgot.dart';
import 'package:livestream/pages/homepage.dart';
import 'package:livestream/pages/signup.dart';
import 'package:livestream/pages/tabs.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';



class Email_Confirmation_Page extends StatefulWidget {
  static const String id="Email_Confirmation_Page";
  const Email_Confirmation_Page({Key? key}) : super(key: key);

  @override
  State<Email_Confirmation_Page> createState() => _Email_Confirmation_PageState();
}

class _Email_Confirmation_PageState extends State<Email_Confirmation_Page> {
  TextEditingController namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      // backgroundColor: MyColors.backcolor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(MyImages.back),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topLeft
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            MyImages.check,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                          vSizedBox4,
                          vSizedBox4,
                          ParagraphText(
                            text: 'Successfuly Registered !',
                            fontFamily: 'semibold',
                            fontSize: 28,
                            color: Colors.white,
                          ),
                          vSizedBox,
                          vSizedBox4,
                          vSizedBox4,
                          // ParagraphText(
                          //   text: 'Now that you have registered your account you can log in on your streaming services to import your watchlist and keep watching your content where you left off or you can continue to finalize your profile customization and start connecting and sharing your content with your friends',
                          //   color: Colors.white,
                          //   fontFamily: 'light',
                          //   fontSize: 16,),
                          vSizedBox2,
                          RoundEdgedButton(
                            text: 'Continue',
                            textColor: Colors.white,
                            width: MediaQuery.of(context).size.width - 200,
                            onTap: (){
                              pushReplacement(context: context, screen: tabs_second_page());
                            },
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // if(_keyboardVisible==false)
            // Positioned(
            //   bottom: 80,
            //   child:RoundEdgedButton(
            //   text: 'Skip',
            //   textColor: Colors.white,
            //   height: 35,
            //   width: 70,
            //   horizontalPadding: 0,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/forgot.dart';
import 'package:livestream/pages/loginpage.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';

class SignupPage extends StatefulWidget {
  static const String id="SignupPage";
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      MyImages.logo,
                      height: 90,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  vSizedBox2,
                  ParagraphText(
                    text: 'Login',
                    fontFamily: 'semibold',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  ParagraphText(
                    text: 'Please enter your email id and password',
                    color: Colors.white,
                    fontFamily: 'light',
                    fontSize: 15,),
                  vSizedBox2,
                  vSizedBox,
                  CustomTextField(
                      controller: namecontroller,
                      hintText: 'Name',
                      prefixIcon: MyImages.user,
                  ),
                  vSizedBox2,
                  CustomTextField(
                    controller: namecontroller,
                    hintText: 'Email ID',
                    prefixIcon: MyImages.mail,
                  ),
                  vSizedBox2,
                  CustomTextField(
                      controller: namecontroller,
                      hintText: 'Password',
                      prefixIcon: MyImages.lock,
                  ),
                  vSizedBox2,
                  RoundEdgedButton(
                    text: 'Sign Up',
                    textColor: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    onTap: (){

                    },
                  ),
                  vSizedBox4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ParagraphText(text: 'If you have account? ', color: Colors.white,),
                      GestureDetector(
                        onTap: (){
                          push(context: context, screen: LoginPage());
                        },
                        child: ParagraphText(
                          text: 'Login',
                          color: MyColors.primaryColor,
                        ),
                      ),
                    ],
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

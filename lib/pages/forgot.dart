import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/lets_start_page.dart';
import 'package:livestream/pages/loginpage.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../functions/validations.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';
import '../widgets/showSnackbar.dart';

class ForgotPage extends StatefulWidget {
  static const String id="ForgotPage";
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  TextEditingController email = TextEditingController();
  bool load = false;
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
                  Center(
                    child: ParagraphText(
                      text: 'Forgot Password',
                      fontFamily: 'semibold',
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  Center(
                    child: ParagraphText(
                      text: 'Please enter your registered email id. ',
                      color: Colors.white,
                      fontFamily: 'light',
                      fontSize: 15,),
                  ),
                  vSizedBox2,
                  vSizedBox,
                  CustomTextField(
                      controller: email,
                      hintText: 'Email ID',
                      // prefixIcon: MyImages.mail,
                  ),
                  vSizedBox2,
                  Center(
                    child: RoundEdgedButton(
                      text: 'Submit',
                      load: load,
                      textColor: Colors.white,
                      width: MediaQuery.of(context).size.width - 200,
                      onTap: () async{

                        Map data={

                          "email":{"value":email.text, "type":"EMAIL", "msg":"Please enter valid email"}

                        };

                        if(validateMap(data)==1){

                          print("success-----" + data.toString());
                          load = true;
                          setState(() {});
                          Map res = await Webservices.getData('forget-password', data);
                          print("success res-----" + res.toString());
                          load =false;
                          setState(() {});
                          if(res['status'].toString()=="1"){
                            showSnackbar(res['message']);
                            Navigator.pop(context);

                          }
                          else{
                            showSnackbar(res['message']);
                          }
                        }



                      },
                    ),
                  ),
                  vSizedBox4,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ParagraphText(text: 'Back To ', color: Colors.white,),
                      GestureDetector(
                        onTap: (){
                          push(context: context, screen: Lets_started_Page());
                        },
                          child: ParagraphText(text: 'Login', color: MyColors.primaryColor,))
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

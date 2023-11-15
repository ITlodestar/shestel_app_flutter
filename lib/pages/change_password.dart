import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/lets_start_page.dart';
import 'package:livestream/pages/loginpage.dart';
import 'package:livestream/widgets/appbar.dart';

import '../constants/colors.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../functions/validations.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';
import '../widgets/showSnackbar.dart';

class Change_Password_Page extends StatefulWidget {
  static const String id="Change_Password_Page";
  const Change_Password_Page({Key? key}) : super(key: key);

  @override
  State<Change_Password_Page> createState() => _Change_Password_PageState();
}

class _Change_Password_PageState extends State<Change_Password_Page> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  bool load = false;
  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      // backgroundColor: MyColors.backcolor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar:appBar(
          context: context,
          title: 'Change Password',
          titleColor: MyColors.white,
          appBarColor: Colors.transparent
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Container(
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
                  // Center(
                  //   child: Image.asset(
                  //     MyImages.logo,
                  //     height: 90,
                  //     fit: BoxFit.fitHeight,
                  //   ),
                  // ),
                  // vSizedBox2,
                  ParagraphText(
                    text: 'Change Password',
                    fontFamily: 'semibold',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  ParagraphText(
                    text: ' Please fill out the empty fields to change your password.',
                    color: Colors.white,
                    fontFamily: 'light',
                    fontSize: 15,),
                  vSizedBox2,
                  vSizedBox,
                  ParagraphText(
                    text: 'Old Password',
                    color: Colors.white,
                    fontFamily: 'light',
                    fontSize: 14,),
                  vSizedBox05,
                  CustomTextField(
                      controller: currentPassword,
                    obscureText: true,
                      hintText: 'Enter Old Password',
                  ),

                  vSizedBox2,

                  ParagraphText(
                    text: 'New Password',
                    color: Colors.white,
                    fontFamily: 'light',
                    fontSize: 14,),
                  vSizedBox05,

                  CustomTextField(
                    controller: newPassword,
                    obscureText: true,
                    hintText: 'Enter New Password',
                  ),


                  vSizedBox2,

                  ParagraphText(
                    text: 'Confirm New Password',
                    color: Colors.white,
                    fontFamily: 'light',
                    fontSize: 14,),
                  vSizedBox05,

                  CustomTextField(
                    controller: confirmNewPassword,
                    hintText: 'Confirm New Passwrd',
                    obscureText: true,
                  ),
                  vSizedBox2,
                  Center(
                    child: RoundEdgedButton(
                      text: 'Save',
                      textColor: Colors.white,
                      load: load,
                      width: MediaQuery.of(context).size.width - 200,
                      onTap: () async{

                        Map data={

                          "current_password":{"value":currentPassword.text, "type":"NO", "msg":"Please enter your current password"},
                          "new_password":{"value":newPassword.text, "type":"NO", "msg":"Please enter new password"},
                          "confirm_password":{"value":confirmNewPassword.text, "type":"NO", "msg":""},

                        };

                        if(validateMap(data)==1){
                          if(newPassword.text==confirmNewPassword.text){
                            // print("success-----" + data.toString());
                            load = true;
                            setState(() {});
                            Map res = await Webservices.postData('change-password', data,null);
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
                          else{
                            showSnackbar("New password and confirm new password should be matched..");
                          }


                        }



                      },
                    ),
                  ),
                ],
              ),
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
    );
  }
}

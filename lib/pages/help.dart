import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/forgot.dart';
import 'package:livestream/pages/homepage.dart';
import 'package:livestream/pages/signup.dart';
import 'package:livestream/widgets/appbar.dart';

import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../functions/validations.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';

import '../widgets/customtextfield.dart';
import '../widgets/showSnackbar.dart';

class Help_Page extends StatefulWidget {
  static const String id="Help_Page";
  const Help_Page({Key? key}) : super(key: key);

  @override
  State<Help_Page> createState() => _Help_PageState();
}

class _Help_PageState extends State<Help_Page> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();
  bool load = false;
  @override
  void initState() {
    // TODO: implement initState
    autoFill();
    super.initState();
  }
  autoFill(){
    phone.text = user_data!['phone']??'';
    name.text = user_data!['first_name'] +" "+ user_data!['last_name'];
    email.text = user_data!['email']??'';
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: appBar(
          context: context,
          title: 'Help',
          titleColor: Colors.white,
          appBarColor: Colors.transparent,
          // actions: [
          //   IconButton(onPressed: (){},
          //     icon: Icon(
          //       Icons.notifications,
          //     ),
          //   )
          // ]
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(MyImages.background_home),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topLeft
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vSizedBox6,
                  vSizedBox8,
                  ParagraphText(
                    text: 'Name',

                    color: Colors.white,
                    fontFamily: 'light',
                    fontSize: 15,),
                  vSizedBox,
                  CustomTextField(
                      controller: name,
                      hintText: 'Name',
                  ),
                  vSizedBox2,
                  ParagraphText(
                    text: 'Phone Number',
                    color: Colors.white,
                    fontFamily: 'light',
                    fontSize: 15,),
                  vSizedBox,
                  CustomTextField(
                      controller: phone,
                      hintText: 'Number',
                  ),
                  vSizedBox2,
                  ParagraphText(
                    text: 'Email ID',
                    color: Colors.white,
                    fontFamily: 'light',
                    fontSize: 15,),
                  vSizedBox,
                  CustomTextField(
                      controller: email,
                      hintText: 'Email',
                  ),
                  vSizedBox2,
                  ParagraphText(
                    text: 'Message',
                    color: Colors.white,
                    fontFamily: 'light',
                    fontSize: 15,),
                  vSizedBox,
                  CustomTextField(
                    controller: message,
                    hintText: 'Say something...',
                    maxLines: 5,
                    height: 150,
                  ),
                  vSizedBox4,
                  Center(
                    child: RoundEdgedButton(
                      text: 'Send',
                      load: load,
                      textColor: Colors.white,
                      minWidth: 182,
                      width: MediaQuery.of(context).size.width,
                      onTap: () async{
                        Map data={
                          "name":{"value":name.text, "type":"NO", "msg":"Please enter valid name"},
                          "email":{"value":email.text, "type":"EMAIL", "msg":"Please enter valid email"},
                          "phone":{"value":phone.text, "type":"PHONE", "msg":"Please enter valid phone number"},
                          "message":{"value":message.text, "type":"NO", "msg":"Please enter message"},
                        };


                        if(validateMap(data)==1){

                          // print("success-----" + data.toString());
                          load = true;
                          setState(() {});
                          Map res = await Webservices.postData('help', data,null);
                          print("success res-----" + res.toString());
                          load =false;
                          setState(() {});
                          if(res['status'].toString()=="1"){

                            showSnackbar(res['message']);
                            message.text='';


                          }
                          else{
                            showSnackbar(res['message']);
                          }



                        }





                        // push(context: context, screen: Home_Page());
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

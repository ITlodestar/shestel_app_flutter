import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/drawer.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/account_detail_page.dart';
import 'package:livestream/pages/change_password.dart';
import 'package:livestream/pages/forgot.dart';
import 'package:livestream/pages/help.dart';
import 'package:livestream/pages/homepage.dart';
import 'package:livestream/pages/lets_start_page.dart';
import 'package:livestream/pages/receive_notification.dart';
import 'package:livestream/pages/signup.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:in_app_review/in_app_review.dart';
import '../constants/auth.dart';
import '../constants/colors.dart';
import '../constants/global_data.dart';
import '../constants/image_urls.dart';
import '../constants/sized_box.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import '../widgets/buttons.dart';
import '../widgets/customtextfield.dart';
import 'country_edit.dart';
import 'faq.dart';
bool _value = false;
enum Availability { loading, available, unavailable }
class Settings_Page extends StatefulWidget {

  static const String id="Settings_Page";
  const Settings_Page({Key? key}) : super(key: key);

  @override
  State<Settings_Page> createState() => _Settings_PageState();
}
class _Settings_PageState extends State<Settings_Page> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desc = TextEditingController();
  bool load = false;
  final InAppReview _inAppReview = InAppReview.instance;
  String _appStoreId = '';
  String _microsoftStoreId = '';
  Availability _availability = Availability.loading;

  @override
  void initState() {
    // TODO: implement initState
    (<T>(T? o) => o!)(WidgetsBinding.instance).addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();

        setState(() {
          // This plugin cannot be tested on Android by installing your app
          // locally. See https://github.com/britannio/in_app_review#testing for
          // more information.
          _availability = isAvailable && !Platform.isAndroid
              ? Availability.available
              : Availability.unavailable;
        });
      } catch (_) {
        setState(() => _availability = Availability.unavailable);
      }
    });
    super.initState();
  }
  // final InAppReview inAppReview = InAppReview.instance;
  @override
  Widget build(BuildContext context) {
    bool _keyboardVisible = false;
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar(
          context: context,
          title: 'Settings',
          titleColor: Colors.white,
          appBarColor: Colors.black,
          // actions: [
          //   IconButton(onPressed: (){},
          //     icon: Icon(
          //       Icons.notifications,
          //     ),
          //   )
          // ]
      ),
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage(MyImages.background_home),
          //     fit: BoxFit.fitWidth,
          //     alignment: Alignment.topLeft
          // ),
        ),
        child: SingleChildScrollView(
          child: Container(

            padding: EdgeInsets.symmetric(horizontal: 16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vSizedBox2,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   ParagraphText(
                     text: 'Do Not Disturb ',
                     fontSize: 18,
                     fontFamily: 'regular',
                   ),
                    Theme(
                      data: ThemeData(),
                      child: Switch(
                        value:  user_data!['mute_notification'].toString()=="1"?true:false,
                        inactiveTrackColor: MyColors.white.withOpacity(0.2),
                        activeColor: MyColors.primaryColor,
                        activeTrackColor: MyColors.primaryColor.withOpacity(0.5),
                        onChanged: (value) async{

                            String o_status="0";
                            if(value==true){
                              o_status="1";
                              user_data!['mute_notification']="1";
                              setState((){});
                            }
                            else {
                              o_status="0";
                              user_data!['mute_notification']="0";
                              setState((){});
                            }
                            Map data={
                              "mute_notification":{"value":o_status, "type":"NO", "msg":""},
                            };
                            await Webservices.postData('edit-profile', data,null);
                            print("request data----"+data.toString());
                            Map res = await Webservices.getData('user-detail', {"id":{'value':user_id}});
                            if(res['status'].toString()=="1") {
                              print("res data ----"+res['data'].toString());
                              await updateUserDetails(res['data']);
                            }

                        },
                      ),
                    ),
                  ],
                ),
                vSizedBox,
                GestureDetector(
                  onTap: (){
                    push(context: context, screen: Receive_Notification_Page());
                  },
                  child:  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: ParagraphText(
                      text: 'Notifications',
                      fontSize: 18,
                      fontFamily: 'regular',
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    push(context: context, screen: Account_detail_PAge());

                  },
                  child:  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: ParagraphText(
                      text: 'Edit Profile',
                      fontSize: 18,
                      fontFamily: 'regular',
                    ),
                  ),
                ),

                // GestureDetector(
                //   onTap: () async{
                //     await push(context: context, screen: CountryEditPage());
                //     setState(() {
                //
                //     });
                //
                //   },
                //   child:  Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.symmetric(vertical: 5),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         ParagraphText(
                //           text: 'Country',
                //           fontSize: 18,
                //           fontFamily: 'regular',
                //         ),
                //         Image.network('https://www.countryflagicons.com/FLAT/64/'+country_code.toUpperCase()+'.png', height: 44,)
                //       ],
                //     ),
                //   ),
                // ),

                GestureDetector(
                  onTap: (){
                    push(context: context, screen: Change_Password_Page());

                  },
                  child:  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: ParagraphText(
                      text: 'Change Password',
                      fontSize: 18,
                      fontFamily: 'regular',
                    ),
                  ),
                ),

                GestureDetector(
                  child:  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: ParagraphText(
                      text: 'Feedback',
                      fontSize: 18,
                      fontFamily: 'regular',
                    ),
                  ),
                  onTap: ()async{




                    // if (await inAppReview.isAvailable()) {
                    _inAppReview.openStoreListing();
                    // }
                    // showCustomDialogBox(
                    //   marginhorizontal: 24,
                    //     border: false,
                    //     context: context,
                    //     child: Column(
                    //       children: [
                    //         vSizedBox2,
                    //         MainHeadingText(text: 'Enjoying our app?', fontSize: 20,),
                    //         vSizedBox,
                    //         ParagraphText(
                    //             text: 'Tap a star to rate it within the\napp store.',
                    //             color: MyColors.black,
                    //           textAlign: TextAlign.center,
                    //           fontSize: 14,
                    //         ),
                    //         vSizedBox2,
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Icon(Icons.star, size: 30, color: MyColors.yellow,),
                    //             Icon(Icons.star, size: 30, color: MyColors.yellow,),
                    //             Icon(Icons.star, size: 30, color: MyColors.yellow,),
                    //             Icon(Icons.star_border_outlined, size: 30, color: MyColors.yellow,),
                    //             Icon(Icons.star_border_outlined, size: 30, color: MyColors.yellow,),
                    //           ],
                    //         ),
                    //         vSizedBox2,
                    //         CustomTextField(
                    //             controller: desc,
                    //             hintText: 'Add Comment',
                    //             maxLines: 7,
                    //             height: 150,
                    //             border: Border.all(color: MyColors.primaryColor),
                    //             borderradius: 12,
                    //         ),
                    //         vSizedBox2,
                    //         RoundEdgedButton(
                    //             text: 'Submit',
                    //             textColor: MyColors.white,
                    //             verticalPadding: 0,
                    //             horizontalPadding: 0,
                    //             height: 30,
                    //             minWidth: 120,
                    //           onTap: (){
                    //               Navigator.pop(context);
                    //           },
                    //         ),
                    //         vSizedBox2,
                    //       ],
                    //     )
                    // );
                  },
                ),

                GestureDetector(
                  onTap: (){
                    push(context: context, screen: Help_Page());

                  },
                  child:  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: ParagraphText(
                      text: 'Help',
                      fontSize: 18,
                      fontFamily: 'regular',
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    push(context: context, screen: Faq_Page());
                    // push(context: context, screen: Help_Page());

                  },
                  child:  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child:
                      ParagraphText(
                        text: 'FAQ',
                        fontSize: 18,
                        fontFamily: 'regular',
                      ),

                  ),
                ),
                // Divider(color: MyColors.white.withOpacity(0.0), height: 30,),
                GestureDetector(
                  onTap: (){

                   logOutModal(context);
                  },
                  child:  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: ParagraphText(
                      text: 'Logout',
                      fontSize: 18,
                      fontFamily: 'regular',
                    ),
                  ),
                ),
                Divider(color: MyColors.white.withOpacity(0.0), height: 30,),


                Center(
                  child: RoundEdgedButton(
                    text: 'Delete Account',
                    load: load,
                    color: Colors.red,
                    textColor: Colors.white,
                    width:  230,
                    onTap: () async{
                      deleteModal(context);



                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<dynamic> deleteModal(context){
    return  showDialog(
      context: context,

      builder: (contexta) {
        double h = MediaQuery.of(contexta).size.height;
        double w = MediaQuery.of(contexta).size.width;
        return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            insetPadding: const EdgeInsets.all(50),
            elevation: 16,
            child: Stack(
                clipBehavior: Clip.none,
                // width: double.infinity,
                // alignment: Alignment.center,
                children:[
                  Container(
                      width: double.infinity,
                      child:
                      Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[

                            Text(
                              // translate("message.kycpending"), textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWaeight.bold, fontSize: 18),),
                              "Are you sure you want to delete your account?",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'semibold',
                                color: Colors.black,
                                fontSize: 18, height: 1.8,
                              ),
                            ),

                            const SizedBox(height:10),

                            const SizedBox(height:20),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children:[
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.0),

                                      ),
                                      // margin: const EdgeInsets.only(top: 20, left: 200, right: 0),
                                      // left: 20,
                                      height: 40,
                                      width:80,
                                      child:
                                      ElevatedButton(

                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          textStyle: TextStyle(color: MyColors.primaryColor),
                                          onSurface: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                              side: BorderSide(width:2.0,color: MyColors.primaryColor)
                                          ),
                                        ),
                                        onPressed:(){
                                          // log('hee');
                                          Navigator.pop(contexta, false);
                                          // Navigator.of(contexta).pop();
                                        },
                                        child:  Text(
                                            "NO",

                                            textAlign: TextAlign.center,style: TextStyle(
                                          fontFamily: 'semibold',
                                          color: MyColors.primaryColor,
                                          fontSize: 16,
                                        )
                                        ),
                                      )
                                  ),
                                  // SizedBox(width:10),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30.0),
                                        gradient: const LinearGradient(
                                          begin: Alignment(-0.95, 0.0),
                                          end: Alignment(1.0, 0.0),
                                          colors: [ MyColors.primaryColor,  MyColors.primaryColor],
                                          stops: [0.0, 1.0],
                                        ),
                                      ),
                                      // margin: const EdgeInsets.only(top: 20, left: 200, right: 0),
                                      // left: 20,
                                      height: 40,
                                      width: 80,
                                      child:
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.transparent,
                                          onSurface: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        onPressed:() async{

                                          Map data={
                                            // "first_name":{"value":user_data!['first_name'], "type":"NO", "msg":""},
                                            // "last_name":{"value":user_data!['last_name'], "type":"NO", "msg":""},
                                          };



                                          // print("success-----" + data.toString());

                                          load = true;
                                          setState(() {});

                                          Map res = await Webservices.getData('delete-profile', data);
                                          print("success res-----" + res.toString());
                                          load =false;
                                          setState(() {});
                                          if(res['status'].toString()=="1"){
                                            await logout();
                                            pushAndRemoveUntil(context: context, screen: Lets_started_Page());
                                          }
                                          else{

                                          }

                                        },
                                        child:  Text(
                                            "Yes",
                                            textAlign: TextAlign.center,style: TextStyle(
                                          fontFamily: 'semibold',
                                          fontSize: 18,
                                        )
                                        ),
                                      )
                                  )




                                ]
                            ),
                            // SizedBox(height: 20),

                            // SizedBox(height: 20),

                          ],
                        ),
                      )

                  ),
                ]
            )

        );
      },
    ).then((exit) {

    });
  }
}

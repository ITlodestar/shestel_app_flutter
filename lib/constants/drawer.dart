import 'package:flutter/material.dart';
import 'package:livestream/constants/colors.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/pages/lets_start_page.dart';
import 'package:livestream/pages/my_streaming_service_page.dart';
import 'package:livestream/pages/notifications.dart';
import 'package:livestream/pages/settings.dart';
import 'package:livestream/pages/streaming_expenses_page.dart';
import 'package:livestream/widgets/unreadCountCircle.dart';

import '../functions/navigation_functions.dart';
import '../pages/account_detail_page.dart';
import '../pages/help.dart';
import '../pages/homepage.dart';
import '../pages/privacy.dart';
import '../pages/streaming_service_page.dart';
import '../pages/terms.dart';
import '../services/webservices.dart';
import '../widgets/CustomTexts.dart';
import 'auth.dart';
import 'global_data.dart';
import 'image_urls.dart';

bool _value = false;

StatefulBuilder get_drawer(BuildContext contexta){


  return StatefulBuilder(
      builder: (context, setState) {
        return Drawer(

          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          backgroundColor: Colors.black,

          child: Stack(
            children: [
              SingleChildScrollView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox4,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(Icons.close, size: 30, color: MyColors.white,),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(user_data!["profile"], height: 65,width: 65, fit: BoxFit.cover,),
                          ), hSizedBox2,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ParagraphText(text: 'Hi ${user_data!['first_name']}', fontSize: 24, fontFamily: 'medium',),
                              ParagraphText(text: '@${user_data!["username"]}', fontSize: 15, fontFamily: 'medium',),

                            ],
                          ),

                        ],
                      ),

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Switch(
                          value: user_data!['online_status'].toString()=="1"?true:false,
                          inactiveTrackColor: MyColors.white.withOpacity(0.3),
                          activeColor: MyColors.primaryColor,
                          activeTrackColor: MyColors.primaryColor.withOpacity(0.5),
                          onChanged: (value) async{
                            String o_status="0";
                            if(value==true){
                              o_status="1";
                              user_data!['online_status']="1";
                              setState((){});
                            }
                            else {
                              o_status="0";
                              user_data!['online_status']="0";
                              setState((){});
                            }
                            Map data={
                              "online_status":{"value":o_status, "type":"NO", "msg":""},
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
                      ],
                    ),
                    Divider(color: Colors.white54, ),
                    // vSizedBox2,

                    ListTile(
                      title: ParagraphText(text: 'My Services', fontSize: 16,),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                        // push(context: context, screen: Streaming_service_Page());
                        Navigator.pop(context);
                        push(context: contexta, screen: My_Streaming_service_Page());

                      },
                    ),
                    ListTile(
                      title: ParagraphText(text: 'My Dashboard', fontSize: 16,),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                        push(context: context, screen: Streaming_Expenses_Page());
                      },
                    ),
                    ListTile(
                      title:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          ParagraphText(text: 'Notifications', fontSize: 16,),
                          unreadCircle(type: 'notification')
                          // if(NotiCount>0)
                          //   Container(
                          //       height: 20,
                          //       width: 20,
                          //       decoration: BoxDecoration(
                          //         color: Colors.red,
                          //         borderRadius: BorderRadius.circular(100),
                          //       ),
                          //       child: Center(child: Padding(
                          //         padding: EdgeInsets.symmetric(horizontal: 3),
                          //         child: ParagraphText(text:NotiCount.toString(),textAlign: TextAlign.end,color: Colors.white,fontSize: 10,),
                          //       ))),
                        ],),
                      // ParagraphText(text: 'Notifications', fontSize: 16,),
                      // subtitle: ParagraphText(text: NotiCount.toString(),textAlign: TextAlign.end,),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                        Navigator.pop(context);
                        push(context: contexta, screen: Notifications_Page());
                      },
                    ),
                    ListTile(
                      title:  ParagraphText(text: 'Settings', fontSize: 16,),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                        Navigator.pop(context);
                        push(context: contexta, screen: Settings_Page());

                      },
                    ),
                    ListTile(
                      title:  ParagraphText(text: 'Terms and Conditions', fontSize: 16,),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                        push(context: context, screen: Terms_Page());

                      },
                    ),
                    ListTile(
                      title:  ParagraphText(text: 'Privacy Policy', fontSize: 16,),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                        push(context: context, screen: Privacy_Page());

                      },
                    ),
                    // ListTile(
                    //   title:  ParagraphText(text: 'Help', fontSize: 16, fontFamily: 'light',),
                    //   onTap: () {
                    //     // Update the state of the app.
                    //     // ...
                    //     push(context: context, screen: Help_Page());
                    //
                    //   },
                    // ),
                    // ListTile(
                    //   title:  ParagraphText(text: 'Logout', fontSize: 16,),
                    //   onTap: () {
                    //     logOutModal(context);
                    //     // Update the state of the app.
                    //     // ...
                    //   },
                    // ),

                    // vSizedBox6,


                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(color: Colors.white.withOpacity(0.3),),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
                      child: Image.asset(MyImages.logo, height: 50,),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
  );

}


Future<dynamic> logOutModal(context){
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
                            "Are you sure you want to logout?",
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
                                        await logout();
                                        pushAndRemoveUntil(context: context, screen: Lets_started_Page());
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




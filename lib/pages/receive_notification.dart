import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/auth.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/functions/navigation_functions.dart';
import 'package:livestream/pages/select_genres.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:livestream/widgets/buttons.dart';
import 'package:livestream/widgets/customtextfield.dart';
import 'package:livestream/widgets/showSnackbar.dart';
import '../constants/global_data.dart';
import '../services/webservices.dart';
import 'homepage.dart';

import '../constants/colors.dart';
enum SingingCharacter { lafayette, jefferson }
bool isChecked = false;
class Receive_Notification_Page extends StatefulWidget {

  const Receive_Notification_Page({Key? key,}) : super(key: key);

  @override
  State<Receive_Notification_Page> createState() => _Receive_Notification_PageState();
}
bool show = true;
bool hide = false;
bool hideone = false;
bool isSwitched =false;

bool isdone = false;
int count = 0;
class _Receive_Notification_PageState extends State<Receive_Notification_Page> {
  SingingCharacter? _character = SingingCharacter.lafayette;
  Map data = {
    "email_notification":{"value":"0"},
    "sms_notification":{"value":"0"},
    "push_notification":{"value":"0"},
  };
  bool loading = false;
  List<Map> text=[
    {
      "text":"Email",
      "key":"email_notification"
    },
    {
      "text":"In - app",
      "key":"push_notification"
    },
    {
      "text":"SMS",
      "key":"sms_notification"
    }

  ];
  TextEditingController search = TextEditingController();
 List prefrence=[];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDetail();
  }


  getDetail(){
    autofill();
  }

  autofill() async{

    data["email_notification"]["value"]=user_data!['email_notification'].toString();
    data["sms_notification"]["value"]=user_data!['sms_notification'].toString();
    data["push_notification"]["value"]=user_data!['push_notification'].toString();
    print('this is user data---'+data.toString());
    setState(() {

    });

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldKey,
      backgroundColor: Colors.black,
      // appBar: appBar(
      //   context: context,
      //   title: 'Streaming services ',
      //   titleColor: Colors.white,
      //   actions: [
      //     IconButton(onPressed: (){},
      //         icon: Icon(
      //           Icons.notifications,
      //         ),
      //     )
      //   ]
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MyImages.background_home),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vSizedBox6,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.chevron_left_outlined,
                            color: MyColors.white,
                            size: 30,
                          ),
                        ),
                        hSizedBox,
                        Expanded(
                          child: ParagraphText(
                            text: 'How do you want to receive your notifications?',
                            fontSize: 21,
                            fontFamily: 'medium',
                          ),
                        ),
                      ],
                    ),
                    vSizedBox2,
                    for(var i=0;i<text.length;i++)
                    Padding(
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
                                      ParagraphText(
                                        text: text[i]['text'],
                                        fontSize: 18,
                                        fontFamily: 'semibold',
                                      ),
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
                                  value: data[text[i]['key']]['value']=="0"?false:true,
                                  activeColor: MyColors.primaryColor,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if(value!=null)
                                        data[text[i]['key']]['value'] = value==true?"1":"0";

                                    });
                                  },
                                ),
                              )


                            ],
                          ),
                        ),
                      ),
                    vSizedBox2,
                    Center(
                      child: RoundEdgedButton(
                        text: 'Done',
                        load: loading,
                        textColor: Colors.white,
                        width: MediaQuery.of(context).size.width - 200,
                        color: MyColors.primaryColor,
                        onTap: (){
                          update();
                        },

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }



  update() async{
    loading = true;
    setState(() {});
    await Webservices.postData('edit-profile', data,null);
    loading = false;
    showSnackbar("Notification settings updated successfully");
    setState(() {});
    print("request data----"+data.toString());
    Map res = await Webservices.getData('user-detail', {"id":{'value':user_id}});
    if(res['status'].toString()=="1") {

      print("res data ----"+res['data'].toString());
      await updateUserDetails(res['data']);
    }
  }
}

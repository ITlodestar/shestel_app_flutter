import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:livestream/widgets/buttons.dart';
import 'package:livestream/widgets/customtextfield.dart';
import '../constants/auth.dart';
import '../constants/global_data.dart';
import '../services/webservices.dart';
import 'homepage.dart';

import '../constants/colors.dart';
enum SingingCharacter { lafayette, jefferson }
class Streaming_Expenses_Page extends StatefulWidget {
  const Streaming_Expenses_Page({Key? key}) : super(key: key);

  @override
  State<Streaming_Expenses_Page> createState() => _Streaming_Expenses_PageState();
}
bool show = true;
bool hide = false;
bool hideone = false;
bool isSwitched =false;

class _Streaming_Expenses_PageState extends State<Streaming_Expenses_Page> {
  SingingCharacter? _character = SingingCharacter.lafayette;
  List streamExpense=[];
  String totalExpense= "0";
  TextEditingController search = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }
  getUserData() async{

    streamExpense = user_data!['services'];
    totalExpense =  double.parse(user_data!['total_expenses'].toString()).toStringAsFixed(2);
    setState(() {
    });

    // print('token-----'+user_data)

    Map res = await Webservices.getData('user-detail', {"id":{'value':user_id}});
    print('user response--'+res.toString());
    if(res['status'].toString()=="1") {
        await updateUserDetails(res['data']);
        streamExpense = res['data']['services'];
        totalExpense =  double.parse(res['data']['total_expenses'].toString()).toStringAsFixed(2);

        
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldKey,
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: appBar(
        context: context,
        title: 'My Dashboard',
        titleColor: Colors.white,
        // actions: [
        //   IconButton(onPressed: (){},
        //       icon: Icon(
        //         Icons.notifications,
        //       ),
        //   )
        // ]
      ),
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


                    vSizedBox8,
                    vSizedBox4,
                    for(var i=0; i<streamExpense.length; i++)
                      if(streamExpense[i]['price'].toString()!='0')
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: MyColors.bordercolor
                                          ),
                                          borderRadius: BorderRadius.circular(4)
                                      ),

                                      child: Image.network(streamExpense[i]['logo_path'], height: 36, width: 44, fit: BoxFit.contain,),
                                    ),
                                  ),
                                  hSizedBox,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ParagraphText(text: streamExpense[i]['providerName'], fontSize: 13, fontFamily: 'light',),
                                      // if(hideone==false)

                                    ],
                                  )
                                ],
                              ),
                              ParagraphText(
                                text: (hideone==true)?'': '${currency_symbol}${streamExpense[i]['price']}/${streamExpense[i]['frequency']}',
                                fontSize: 13,
                                fontFamily: 'medium',
                                color: MyColors.white,
                              )

                              // Radio<SingingCharacter>(
                              //   value: SingingCharacter.lafayette,
                              //   groupValue: _character,
                              //   activeColor: MyColors.primaryColor,
                              //   onChanged: (SingingCharacter? value) {
                              //     setState(() {
                              //       _character = value;
                              //     });
                              //   },
                              // ),


                            ],
                          ),
                        ),
                      ),
                    vSizedBox4,
                    vSizedBox4,
                    vSizedBox4,

                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:  Container(
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ParagraphText(text: 'My Expenses ',
                            fontSize: 16,
                            fontFamily: 'semibold',
                            color: Colors.black,
                          ),
                          ParagraphText(text: 'for streaming Subscription ',
                            fontSize: 12,
                            fontFamily: 'regular',
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ParagraphText(text: '${currency_symbol}${totalExpense}',
                          fontSize: 20,
                          fontFamily: 'semibold',
                          color: MyColors.primaryColor,
                        ),
                        ParagraphText(text: '/month',
                          fontSize: 10,
                          fontFamily: 'light',
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}

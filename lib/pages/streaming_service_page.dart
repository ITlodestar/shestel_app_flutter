import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livestream/constants/image_urls.dart';
import 'package:livestream/constants/sized_box.dart';
import 'package:livestream/widgets/CustomTexts.dart';
import 'package:livestream/widgets/appbar.dart';
import 'package:livestream/widgets/buttons.dart';
import 'package:livestream/widgets/customtextfield.dart';
import 'homepage.dart';

import '../constants/colors.dart';
enum SingingCharacter { lafayette, jefferson }
class Streaming_service_Page extends StatefulWidget {
  const Streaming_service_Page({Key? key}) : super(key: key);

  @override
  State<Streaming_service_Page> createState() => _Streaming_service_PageState();
}
bool show = true;
bool hide = false;
bool hideone = false;
bool isSwitched =false;
class _Streaming_service_PageState extends State<Streaming_service_Page> {
  SingingCharacter? _character = SingingCharacter.lafayette;
  TextEditingController search = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: scaffoldKey,
      backgroundColor: Colors.black,
      appBar: appBar(
        context: context,
        title: 'My Streaming Services',
        titleColor: Colors.white,
        actions: [
          IconButton(onPressed: (){},
              icon: Icon(
                Icons.notifications,
              ),
          )
        ]
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
                      CustomTextField(
                          controller: search,
                          hintText: 'Search for movies or TV shows',
                          prefixIcon: MyImages.search
                      ),
                    // vSizedBox,
                    // ParagraphText(text: 'Select all your streaming services & hit ‘Done’',
                    //   fontSize: 12,),
                    vSizedBox,
                    Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.white.withOpacity(0.20)
                                    )
                                )
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  show = true;
                                  hide = false;
                                  hideone = false;
                                });
                              },
                              child: Column(
                                children: [
                                  ParagraphText(
                                    text:'Subscription',
                                    fontFamily: show? 'medium':'light',
                                    color: show? MyColors.primaryColor:  Colors.white,
                                    fontSize: 16,
                                  ),
                                  vSizedBox05,
                                  // if(show==true)
                                    Container(
                                      height: 1,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: show==true? MyColors.primaryColor: Colors.transparent
                                      ),
                                    )
                                ],
                              ),
                            ),
                            hSizedBox4,
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  show = false;
                                  hide = true;
                                  hideone = false;
                                });
                              },
                              child: Column(
                                children: [
                                  ParagraphText(
                                    fontFamily: hide? 'medium':'light',
                                    color: hide? MyColors.primaryColor:  Colors.white,
                                    fontSize: 16, text: 'Buy/Rent',
                                  ),
                                  vSizedBox05,
                                  // if(hide==true)
                                    Container(
                                      height: 1,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: hide==true? MyColors.primaryColor: Colors.transparent
                                      ),
                                    )
                                ],
                              ),
                            ),
                            hSizedBox4,
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  show = false;
                                  hide = false;
                                  hideone = true;
                                });
                              },
                              child: Column(
                                children: [
                                  ParagraphText(
                                    fontFamily: hideone? 'medium':'light',
                                    color: hideone? MyColors.primaryColor:  Colors.white,
                                    fontSize: 15, text: 'Free',
                                  ),
                                  vSizedBox05,
                                  // if(hideone==true)
                                    Container(
                                      height: 1,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: hideone==true? MyColors.primaryColor: Colors.transparent
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    vSizedBox,
                    for(var i=0; i<20; i++)
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

                                      child: Image.asset(MyImages.netflix, height: 36, width: 44,),
                                    ),
                                  ),
                                  hSizedBox,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ParagraphText(text: 'Netflix', fontSize: 13, fontFamily: 'light',),
                                      if(hideone==false)
                                      ParagraphText(
                                        text: (hideone==true)?'': '\$15',
                                        fontSize: 13,
                                        fontFamily: 'medium',
                                        color: MyColors.primaryColor,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Radio<SingingCharacter>(
                                value: SingingCharacter.lafayette,
                                groupValue: _character,
                                activeColor: MyColors.primaryColor,
                                onChanged: (SingingCharacter? value) {
                                  setState(() {
                                    _character = value;
                                  });
                                },
                              ),


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
                          ParagraphText(text: 'for streaming subscription: ',
                            fontSize: 12,
                            fontFamily: 'regular',
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ParagraphText(text: '\$xxx',
                          fontSize: 20,
                          fontFamily: 'semibold',
                          color: MyColors.primaryColor,
                        ),
                        ParagraphText(text: ' /month',
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
